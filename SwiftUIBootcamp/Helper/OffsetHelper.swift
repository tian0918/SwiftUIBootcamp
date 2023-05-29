//
//  OffsetHelper.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/29.
//

import SwiftUI

struct OffsetHelper: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
extension View {
    @ViewBuilder
    func offsetExtractor(coordinateSpace: String, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .named(coordinateSpace))
                    Color.clear
                        .preference(key: OffsetHelper.self, value: rect)
                        .onPreferenceChange(OffsetHelper.self, perform: completion)
                }
            }
    }
}

struct OffsetHelper_Previews: PreviewProvider {
    static var previews: some View {
        ElasticScrollView()
    }
}
