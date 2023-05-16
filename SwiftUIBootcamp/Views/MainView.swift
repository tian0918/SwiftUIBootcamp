//
//  MainView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/6.
//

import SwiftUI

struct MainView: View {
    var type:ViewType
    var body: some View {
        VStack {
            switch type {
            case .CUSTOMTAB:
                 CustomTabView()
            case .QRCODE:
                 QRCodeView()
            case .CREDITCARD:
                 CreditCardView()
            case .CLOCKVIEW:
                ClockView()

            }
        }
        
    }
}
