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
            if type == .QRCODE {
                QRCodeView()
            }
            if type == .CREDITCARD {
                CreditCardView()
            }
        }
        
    }
}
