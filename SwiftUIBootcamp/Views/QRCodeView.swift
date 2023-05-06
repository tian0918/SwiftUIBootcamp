//
//  QRCodeView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/6.
//

import SwiftUI

struct QRCodeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("QRCode")
            }
            .navigationTitle("Generator QRCode")
        }
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
    }
}
