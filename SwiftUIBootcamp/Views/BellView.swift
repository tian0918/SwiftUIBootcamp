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
            ZStack {
                Circle()
                    .fill(.black.opacity(0.8))
               
                Circle()
                    .trim(from:0, to:0.6)
                    .stroke(.blue, style:
                                StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round)
                    )
                    .padding(30)
                    .rotationEffect(.init(degrees: 85))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                onDrag(value: value)
                            })
                    )
                ForEach(0..<timeNumber.count, id: \.self) { i in
                    Text("\(timeNumber[i])")
                        .foregroundColor(.white)
                        .rotationEffect(.init(degrees: -Double(i) * 23))
                        .frame(width: 30, height: 30)
                        .background{
                            Circle()
                        }
                        .offset(y:viewWidth / 2 - 50)
                        .rotationEffect(.init(degrees: Double(i) * 23))
                }

                //Stop Sign
                Rectangle()
                    .fill(.white)
                    .frame(width: 5, height: 50)
                    .offset(y:viewWidth / 2 - 55)
                    .rotationEffect(.init(degrees: -30))
            }
            .frame(width:viewWidth - 40)
        }
        
    }
    func onDrag(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        //Removing the Button Radius
        // Button Dimeter = 30
        
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        
        // Converting to angle
        var angle = radians * 180 / .pi
        if angle < 0 { angle = 360 + angle}
        
       
        
    }
}

struct BellView_Previews: PreviewProvider {
    static var previews: some View {
        BellView()
    }
}
