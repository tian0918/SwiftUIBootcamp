//
//  MainView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/6.
//

import SwiftUI

struct MainView: View {
    var type:String
    var body: some View {
        VStack {
            if type == "QRCodeView" {
                QRCodeView()
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(type: "QRCodeView")
    }
}
