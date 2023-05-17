//
//  ContentView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/6.
//

import SwiftUI

struct ContentView: View {
    private var items:[BootcampModel] = [
        BootcampModel(title: "QRCode Generator", destinationName: "QRCodeView", type: .QRCODE),
        BootcampModel(title: "CreitCard View", destinationName: "CreditCardView", type: .CREDITCARD),
        BootcampModel(title: "Custom TabBar View", destinationName: "", type: .CUSTOMTAB),
        BootcampModel(title: "Clock View", destinationName: "", type: .CLOCKVIEW),
        BootcampModel(title: "Alram View", destinationName: "", type: .ALARM),
        BootcampModel(title: "Bell View", destinationName: "", type: .BELLVIEW)
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
    case CREDITCARD
    case CUSTOMTAB
    case CLOCKVIEW
    case ALARM
    case BELLVIEW
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
