//
//  ViewModifiers.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/8.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
 
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button{
                    self.text = ""
                }label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(uiColor: .opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
        }
    }
}
