//
//  CircularSliderView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/16.
//

import SwiftUI

struct CircularSliderView: View {
    @State var startAngle: Double = 0
    @State var toAngle: Double = 180
    
    @State var startProgress: CGFloat = 0
    @State private var toProgress: CGFloat = 0.5
    var body: some View {
        VStack {
            HStack {
                VStack(alignment:.leading, spacing: 8) {
                    Text("Today")
                        .font(.title.bold())
                    Text("Good Mornint!")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    
                }label: {
                    Image(systemName: "figure.fall")
                        .foregroundColor(.blue)
                        .frame(width:60, height: 60)
                        
                }
               
            }
        
            SleepTimeSlider()
                .padding(.top, 50)
            Button{
                
            }label: {
                 Text("Satrt Sleep")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal,40)
                    .background(.blue,in:Capsule())
            }
            .padding(.top, 45)
            HStack(spacing: 25) {
                VStack(alignment: .leading, spacing: 8) {
                    Label{
                        Text("bedtime")
                            .foregroundColor(.black)
                    }icon: {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.blue)
                    }
                    .font(.callout)
                    Text(getTime(angle: startAngle).formatted(date: .omitted, time: .shortened))
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity,alignment: .center)
                VStack(alignment: .leading, spacing: 8) {
                    Label{
                        Text("Wakeup")
                            .foregroundColor(.black)
                    }icon: {
                        Image(systemName: "alarm")
                            .foregroundColor(.blue)
                    }
                    .font(.callout)
                    Text(getTime(angle: toAngle).formatted(date: .omitted, time: .shortened))
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity,alignment: .center)
            }
            .padding()
            .background(.black.opacity(0.06), in: RoundedRectangle(cornerRadius: 15))
            .padding(.top, 35)
        }
        .padding()
        //Move To top no Spacer()
        .frame(maxHeight: .infinity, alignment: .top)
    }
    @ViewBuilder
    func SleepTimeSlider() -> some View {
        GeometryReader { prox in
            let width = prox.size.width
            ZStack {
                
                // Clock Design
                ZStack {
                    ForEach(1...60, id: \.self) { index in
                        Rectangle()
                            .fill(index % 5 == 0 ? .black : .gray)
                            .frame(width: 2, height: index % 5 == 0 ? 10 : 5)
                            .offset(y: (width - 60) / 2)
                            .rotationEffect(.init(degrees: Double(index) * 6))
                    }
                    // Clock Text
                    let texts = [6,9,12,3]
                    ForEach(Array(stride(from:0, to:24, by:2)), id: \.self) {index in
                        Text("\(index)")
                            .font(.callout)
                            .foregroundColor(.black)
                            .rotationEffect(.init(degrees: 180 - Double(index) * 15))
                            .offset(y: (width - 90) / 2)
                            .rotationEffect(.init(degrees: 180 + Double(index) * 15))
                    }
                }
                
                
                Circle()
                    .stroke(.black.opacity(0.06), lineWidth: 40)
                // Allowing Revrese Swiping
                let reverseRotation = (startProgress > toProgress) ? -Double((1 - startProgress) * 360) : 0
                Circle()
                    .trim(from: startProgress > toProgress ? 0 : startProgress, to: toProgress + (-reverseRotation / 360))
                    .stroke(.blue, style:
                                StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round)
                    )
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                
                // Slider Buttons
                Image(systemName: "moon.fill")
                    .font(.callout)
                    .foregroundColor(.blue)
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -startAngle))
                    .background(.white, in: Circle())
                // Moving To right & Rotating
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: startAngle))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                onDrag(value: value,fromSlider: true)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
                Image(systemName: "alarm")
                    .font(.callout)
                    .foregroundColor(.blue)
                    .frame(width: 30, height: 30)
                // Rotating Image inside the circle
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -toAngle))
                    .background(.white, in: Circle())
                // Moving To right & Rotating
                    .offset(x: width / 2)
                 
                    .rotationEffect(.init(degrees: toAngle))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                onDrag(value: value)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
                
                // Hour text
                VStack(spacing: 6) {
                    Text("\(getTimeDifference().0)hr")
                        .font(.largeTitle.bold())
                    Text("\(getTimeDifference().1)min")
                        .foregroundColor(.gray)
                }
                .scaleEffect(1.1)
            }
        }
        .frame(width: screenBounds().width / 1.6, height: screenBounds().width / 1.6)
    }
    func onDrag(value: DragGesture.Value, fromSlider: Bool = false) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        //Removing the Button Radius
        // Button Dimeter = 30
        
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        
        // Converting to angle
        var angle = radians * 180 / .pi
        if angle < 0 { angle = 360 + angle}
        
        // Progress
        let progress = angle / 360
        if fromSlider {
            self.startAngle = angle
            self.startProgress = progress
        }else {
            self.toAngle = angle
            self.toProgress = progress
        }
        
    }
    
    // Returning Time based Drag
    func getTime(angle: Double) -> Date {
        let progress = angle / 15
        
        let hour = Int(progress)
        let remainder = (progress.truncatingRemainder(dividingBy: 1 ) * 12).rounded()
        var minute = remainder * 5
        minute = (minute > 55 ? 55 : minute)
        
        let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           
           let calendar = Calendar.current
           let components = calendar.dateComponents([.month,.day,.year], from: Date())
             
           let rawDay = (components.day ?? 0)
           var day: Int = 0
           
           if angle == toAngle{
               day = rawDay + 1
           }
           else{
               day = (startAngle > toAngle) ? rawDay : rawDay + 1
           }
           if let date = formatter.date(from: "\(components.year ?? 0)-\(components.month ?? 0)-\(day) \(hour == 24 ? 0 : hour):\(Int(minute)):00"){
               return date
           }
           return .init()
    }
    
    func getTimeDifference() ->(Int, Int) {
        
        let calendar = Calendar.current
        let result = calendar.dateComponents([.hour, .minute], from: getTime(angle: startAngle), to: getTime(angle: toAngle))
        
        return (result.hour ?? 0 , result.minute ?? 0)
    }
}

struct CircularSliderView_Previews: PreviewProvider {
    static var previews: some View {
        CircularSliderView()
    }
}
