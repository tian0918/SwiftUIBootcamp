//
//  StickyHeaderView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/6/1.
//

import SwiftUI

struct StickyHeaderView: View {
    @State private var offsetY: CGFloat = 0
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            ScrollViewReader { scrollproxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HeaderView(size: size, safeArea: safeArea)
//                            .offset(y: -safeArea.top)
                            .zIndex(1000)
                        SampleCardview()
                    }
                    .id("SCROLLVIEW")
                    .background {
                        ScrollDetector { offset in
                            offsetY = -offset
                        } onDraggingEnd: { offset, velocity in
                            let headerHeight = (size.height * 0.3) + CGFloat(46)
                            let minimumHeight = 65 + safeArea.top
                            let targetEnd = offset + (velocity * 45)
                            if targetEnd < (headerHeight - minimumHeight) && targetEnd > 0 {
                                withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.65)) {
                                    scrollproxy.scrollTo("SCROLLVIEW", anchor: .top)
                                }
                            }
                        }

                    }
                }
            }
        }
//        .ignoresSafeArea()
//        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    func HeaderView(size: CGSize, safeArea: EdgeInsets) -> some View {
        let headerHeight = (size.height * 0.3) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        GeometryReader { _ in
            ZStack {
                Rectangle()
                    .fill(.orange.gradient)
                VStack(spacing: 15) {
                    GeometryReader{
                        let rect = $0.frame(in: .global)
                        let halfScaleHeight = (rect.height * 0.3) * 0.5
                        let midY = rect.midY
                        let bottomPadding: CGFloat = 15
                        let resizedOffsetY = (midY - (minimumHeaderHeight - halfScaleHeight - bottomPadding))
                        Image("cat")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: rect.width, height: rect.height)
                            .clipShape(Circle())
                            .scaleEffect(1 - (progress * 0.7), anchor: .leading)
                            .offset(x: -(rect.minX - 15) * progress, y: -resizedOffsetY * progress)
                    }
                    .frame(width: headerHeight * 0.4, height: headerHeight * 0.4)
                    Text("Cat")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
//                        .scaleEffect(1 - (progress * 0.15))
//                        .offset(y: -4.5 * progress)
                }
                .padding(.top, safeArea.top)
                .padding(.bottom)
            }
            .frame(height: (headerHeight + offsetY) < minimumHeaderHeight ?  minimumHeaderHeight : (headerHeight + offsetY), alignment: .bottom)
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
        
    }
    @ViewBuilder
    func SampleCardview() -> some View {
        VStack(spacing: 15) {
            ForEach(1...25, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.black.opacity(0.05))
                    .frame(height: 75)
            }
        }
        .padding(15)
    }
}

struct StickyHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StickyHeaderView()
    }
}
