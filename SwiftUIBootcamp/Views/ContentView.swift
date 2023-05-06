//
//  ContentView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/6.
//

import SwiftUI

struct ContentView: View {
    private var items:[BootcampModel] = [
        BootcampModel(title: "QRCode Generator", destinationName: "QRCodeView", type: .QRCODE)
    ]
    var body: some View {
//        NavigationStack {
            VStack {
                List {
                    ForEach(items) { item in
                        NavigationLink{
                            MainView(type: item.type)
                        } label: {
                            Text(item.title)
                        }
                    }

                }
            }
           
//        }
    }
}

struct BootcampModel: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var destinationName: String
    var type: ViewType
    
    
}
enum ViewType {
    case QRCODE
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
