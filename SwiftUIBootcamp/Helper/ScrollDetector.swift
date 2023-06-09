//
//  ScrollDetector.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/6/1.
//

import SwiftUI

struct ScrollDetector: UIViewRepresentable {

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    var onScroll: (CGFloat) -> ()
    var onDraggingEnd: (CGFloat, CGFloat) -> ()
    
    func makeUIView(context: Context) ->  UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let scollview = uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.isDelegatedAddes {
                scollview.delegate = context.coordinator
                context.coordinator.isDelegatedAddes = true
            }
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollDetector
        
        init(parent: ScrollDetector) {
            self.parent = parent
        }
        
        var isDelegatedAddes: Bool = false
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.onScroll(scrollView.contentOffset.y)
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            parent.onDraggingEnd(targetContentOffset.pointee.y, velocity.y)
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView.panGestureRecognizer.view)
            parent.onDraggingEnd(scrollView.contentOffset.y, velocity.y)
        }
    }
    
}
