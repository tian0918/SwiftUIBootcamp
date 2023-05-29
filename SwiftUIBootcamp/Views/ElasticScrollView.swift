//
//  ElasticScrollView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/29.
//

import SwiftUI

struct ElasticScrollView: View {
    // View properties
    @State private var scrollRect: CGRect = .zero
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { proxy in
                    let size = proxy.size
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 8) {
                            ForEach(1..<20) { _ in
                                MessageRow()
                                    .elasticScroll(scrollRect: scrollRect, screenSize: size)
                                    
                            }
                        }
                        .padding(15)
                        .offsetExtractor(coordinateSpace: "SCROLLVIEW") {
                            scrollRect = $0
                        }
                    }
                    .coordinateSpace(name: "SCROLLVIEW")
                }
            }
            .navigationTitle("Elastic Demo")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    @ViewBuilder
    func MessageRow() -> some View {
        HStack(spacing:15) {
                Image(systemName: "brain.head.profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .foregroundColor(.orange)
                .frame(width: 55, height: 55)
                .overlay(alignment: .bottomTrailing) {
                    Circle()
                        .fill(.green.gradient)
                        .frame(width: 5,height: 5)
                }
            VStack(alignment: .leading,spacing: 10) {
                Text("name")
                    .font(.callout)
                    .fontWeight(.bold)
                Text("SubName")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
                
        }
    }
}

struct ElasticScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ElasticScrollView()
    }
}
