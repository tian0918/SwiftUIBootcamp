//
//  CreitCardView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/9.
//

//
//  CreditCardView.swift
//  HotProspects
//
//  Created by txby on 2023/4/4.
//

import SwiftUI

struct CreditCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var activeTF: ActiveKeyboardField!
    @State private var cardNumber: String = ""
    @State private var cardHolderName: String = ""
    @State private var cvvCode: String = ""
    @State private var expireDate: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                CardView()
                Spacer(minLength: 0)
                Button{
                    
                }label: {
                    Label("Add Card", systemImage: "lock")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.blue.gradient)
                        }
                }
                .disableWithOpacity(cardNumber.count != 19 || expireDate.count != 5 || cvvCode.count != 3 || cardHolderName.isEmpty )
            }
            .padding()
//            .toolbar(.hidden, for: .navigationBar)
            .navigationTitle("CreditCard")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    if activeTF != .cardHolderName {
                        Button("Next") {
                            switch activeTF {
                            case .cardNumber:
                                activeTF = .expirationDate
                            case .cardHolderName:
                                break
                            case .expirationDate:
                                activeTF = .cvv
                            case .cvv:
                                activeTF = .cardHolderName
                            case .none: break
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigation) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func CardView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBlue))
            
            
            VStack(spacing: 10) {
                HStack {
                    TextField("XXXX XXXX XXXX XXXX", text: .init(get: {
                        cardNumber
                    }, set: { val in
                        cardNumber = ""
                        
                        let startIndex = val.startIndex
                        for index in 0..<val.count {
                            let stringIndex = val.index(startIndex, offsetBy: index)
                            cardNumber += String(val[stringIndex])
                            
                            if (index + 1) % 5 == 0 && val[stringIndex] != " " {
                                cardNumber.insert(" ", at: stringIndex)
                            }
                        }
                        if val.last == " "{
                            cardNumber.removeLast()
                        }
                        cardNumber = String(cardNumber.prefix(19))
                    }))
                    .font(.title3)
                    .keyboardType(.numberPad)
                    .focused($activeTF,equals: .cardNumber)
                    Spacer(minLength: 0)
                   
                    
                }
                HStack {
                    TextField("MM/YY", text: .init(get: {
                        expireDate
                    }, set: { value in
                        expireDate = value
                        if value.count == 3 && !value.contains("/") {
                            let startIndex = value.startIndex
                            let thirdPosition = value.index(startIndex, offsetBy: 2)
                            expireDate.insert("/", at: thirdPosition)
                        }
                        if expireDate.last == "/" {
                            expireDate.removeLast()
                        }
                        expireDate = String(expireDate.prefix(5))
                    }))
                        .keyboardType(.numberPad)
                        .focused($activeTF, equals: .expirationDate)
                    Spacer(minLength: 0)
                    
                    TextField("CVV", text: .init(get: {
                        cvvCode
                    }, set: { val in
                        cvvCode = val
                        cvvCode = String(cvvCode.prefix(3))
                    }))
                        .frame(width: 35)
                        .focused($activeTF, equals: .cvv)
                        .keyboardType(.numberPad)
                }
                .padding(.top, 15)
                Spacer(minLength: 0)
                
                TextField("CARD HOLDER NAME", text: $cardHolderName)
                    .focused($activeTF, equals: .cardHolderName)
                    .submitLabel(.done)
            }
            .padding(20)
            .tint(.white)
        }
        .frame(height: 200)
        .padding(.top, 35)
    }
    
}


extension View {
    @ViewBuilder
    func disableWithOpacity(_ status: Bool) -> some View {
        self.disabled(status)
            .opacity(status ? 0.6 : 1)
    }
}
enum ActiveKeyboardField {
    case cardNumber
    case cardHolderName
    case expirationDate
    case cvv
}
