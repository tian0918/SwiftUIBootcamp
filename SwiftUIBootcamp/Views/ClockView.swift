//
//  ClockView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/16.
//

import SwiftUI

struct ClockView: View {
    @State private var isDark:Bool = false
    var width = UIScreen.main.bounds.width
    @State private var currentTime = Time(min: 0, sec: 0, hour: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    let hours = Array(1...12)
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Angle Clock")
                        .font(.title2.bold())
                    Spacer()
                    Button {
                        isDark.toggle()
                    } label: {
                        Image(systemName: isDark ? "sun.min.fill" : "moon.fill")
                            .font(.system(size: 22))
                            .foregroundColor(isDark ? .black : .white)
                            .padding()
                            .background(Color.primary)
                            .clipShape(Circle())
                    }

                    
                }
                .padding()
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color("mainColo").opacity(0.1))
                    //Seconds And Min dots...
                    ForEach(0..<60, id: \.self) { i in
                        Rectangle()
                            .fill(Color.primary)
                            .opacity(i % 5 == 0 ? 1 : 0.4)
                            .frame(width: 2, height: (i % 5) == 0 ? 15 : 5)
                            .offset(y:(width - 110) / 2)
                            .rotationEffect(.init(degrees: Double(i) * 6))
//
                    }
                    ForEach(1..<13, id: \.self) {i in
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 20, height: 20)
                            .offset(y:(width - 150) / 2)

                            .overlay {

                                Text("\(i)")
                                    .foregroundColor(Color.primary)
                                    .rotationEffect(.init(degrees: 180 - Double(i) * 30))
                                    .font(.system(size: i % 3 == 0 ? 18 : 12))
                                    .offset(y:(width - 150) / 2)

                            }
                            .rotationEffect(.init(degrees: 180 + (Double(i) * 30)))
                    }
                    // Sec...
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 2, height: (width - 180) / 2)
                        .offset(y: -(width - 180) / 4)
                        .rotationEffect(.init(degrees: Double(currentTime.sec) * 6))
                        
                    //Min...
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 4, height: (width - 200) / 2)
                        .offset(y: -(width - 200) / 4)
                        .rotationEffect(.init(degrees: Double(currentTime.min) * 6))
                    //Hour...
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 4.5, height: (width - 240) / 2)
                        .offset(y: -(width - 240) / 4)
                        .rotationEffect(.init(degrees: Double(currentTime.hour + (currentTime.min / 60)) * 30))
                    //Center Circle
                    Circle()
                        .fill(Color.primary)
                        .frame(width: 15, height: 15)
                        
                    
                    
                }
                .frame(width: width-80, height: width-80)
                
                //Getting Local Region Name...
//                Text(getRegion())
//                    .font(.largeTitle)
//                    .fontWeight(.heavy)
//                    .padding(.top, 35)
                Text(getTime())
                    .font(.system(size: 45))
                    .padding(.top, 10)
                
                Spacer()
            }
            .onAppear(perform: {
                let calendar = Calendar.current
                let min = calendar.component(.minute, from: Date())
                let second = calendar.component(.second, from: Date())
                let hour = calendar.component(.hour, from: Date())
                
                withAnimation(Animation.linear(duration: 0.01)) {
                    self.currentTime = Time(min: min, sec: second, hour: hour)
                }
            })
            .onReceive(receiver, perform: { _ in
                let calendar = Calendar.current
                let min = calendar.component(.minute, from: Date())
                let second = calendar.component(.second, from: Date())
                let hour = calendar.component(.hour, from: Date())
                
                withAnimation(Animation.linear(duration: 0.01)) {
                    self.currentTime = Time(min: min, sec: second, hour: hour)
                }
            })
            .preferredColorScheme(isDark ? .dark : .light)
        }
    }
    func getTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "HH:mm:ss EE"
        return format.string(from: Date())
    }
    func getRegion() -> String {
        let str = Locale.current.localizedString(forRegionCode: Locale.current.language.region?.identifier ?? "") ?? ""
        return str
    }
}
struct Time {
    var min: Int
    var sec: Int
    var hour: Int
}
struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
