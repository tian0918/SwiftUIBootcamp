//
//  BellView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/16.
//

import SwiftUI

struct BellView: View {
    var timeNumber:[Int] = [0,9,8,7,6,5,4,3,2,1]
    var body: some View {
        VStack {
            
//            ForEach(1..<12) {
//                Text("\($0)")
//                    .frame(width: 35, height: 35)
//                    .padding()
//                    .overlay {
//                        Circle()
//                            .stroke(.orange,lineWidth: 2)
//                            .padding(5)
//                    }
//            }
            
            ZStack {
                Circle()
                    .fill(.black.opacity(0.8))
                    .padding(.horizontal)
                ForEach(0..<timeNumber.count, id: \.self) { i in
                    Text("\(timeNumber[i])")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background{
                            Circle()
                                .stroke(.red)
                        }
                        .offset(y:150)
                        .rotationEffect(.init(degrees: Double(i) * 23))
                }
            }
        }
        
    }
}

struct BellView_Previews: PreviewProvider {
    static var previews: some View {
        BellView()
    }
}
