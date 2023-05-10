//
//  CustomTabView.swift
//  HotProspects
//
//  Created by txby on 2023/5/10.
//

import SwiftUI

struct CustomTabView: View {
    // View property
    @State private var activityTab: Tab = .home
    // For Smooth Shape Effect We're going to use Geomerty Effect
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                TabView(selection: $activityTab) {
                    Text("Home")
                        .tag(Tab.home)
                    // Hiding Native Tab Bar
                        .toolbar(.hidden, for: .tabBar)
                    Text("Service")
                        .tag(Tab.service)
                        .toolbar(.hidden, for: .tabBar)
                    Text("Partners")
                        .tag(Tab.partners)
                        .toolbar(.hidden, for: .tabBar)
                    Text("Activity")
                        .tag(Tab.activity)
                        .toolbar(.hidden, for: .tabBar)
                }
                CustomaTabBar()
            }
            .navigationTitle("Custom Tab Bar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    // Custom tab bar
    @ViewBuilder
    func CustomaTabBar(_ tint: Color = .blue.opacity(0.6), _ inactiveTint: Color = .blue) -> some View {
        // Movingall the remaining Tab item's to botoom
        HStack(alignment: .bottom, spacing:0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activiteTab: $activityTab,
                    position: $tabShapePosition
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(content: {
            TabShape(midpoint: tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
                // Adding Blur + Shadow
                // For Shape Smoothening
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        })
        // Adding animation
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activityTab)
    }
}

// Tab bar item
struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activiteTab: Tab
    @Binding var position: CGPoint
    @State private var tabPosition: CGPoint = .zero
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activiteTab == tab ? .white : inactiveTint)
                // Increasing size for activite tab
//                .frame(width: 35, height: 35)
                .frame(width: activiteTab == tab ? 58 : 35, height: activiteTab == tab ? 58 : 35)
                .background {
                    if activiteTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVITETAB", in: animation)
                    }
                }
            
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activiteTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .containerShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX
            
            if activiteTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activiteTab = tab
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
}
enum Tab: String, CaseIterable {
    case home = "Home"
    case service = "Service"
    case partners = "Partners"
    case activity = "Activity"
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .service:
            return "envelope.open.badge.clock"
        
        case .partners:
            return "hand.raised"
        case .activity:
            return "bell"
        }
    }
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
