//
//  View_Extensions.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/29.
//

import SwiftUI

extension View {
    @ViewBuilder
    func elasticScroll(scrollRect: CGRect, screenSize: CGSize) -> some View {
        self
            .modifier(ElasticScrollHelper(scrollRect: scrollRect, screenSize: screenSize))
    }
}
fileprivate struct ElasticScrollHelper: ViewModifier {
    var scrollRect: CGRect
    var screenSize: CGSize
    
    @State private var viewRect: CGRect = .zero
    func body(content: Content) -> some View {
        let progress = scrollRect.minY / scrollRect.maxX
        let elasticOffset = (progress * viewRect.minY) * 1.2
        
        let bottomProgress = max(1 - (scrollRect.maxY / screenSize.height), 0)
        let bottomElasticOffset = (viewRect.maxY * bottomProgress) * 1.2
        content
        
            .offset(y: scrollRect.minY > 0 ? elasticOffset : 0)
            .offset(y: scrollRect.minY > 0 ? -(progress * scrollRect.minY) : 0)
            .offset(y: scrollRect.maxY < screenSize.height ? bottomElasticOffset : 0)
            .offsetExtractor(coordinateSpace: "SCROLLVIEW") {
                viewRect = $0
            }
    }
}

struct View_Extensions_Previews: PreviewProvider {
    static var previews: some View {
        ElasticScrollView()
    }
}
