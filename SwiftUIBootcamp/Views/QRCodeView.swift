//
//  QRCodeView.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/6.
//

import SwiftUI

struct QRCodeView: View {
    @State private var qrString: String = ""
    private var resultQRImg: Image?
    @State var qrImageWidth: Double = 100
    @State var currentColor: Color = Color(uiColor: .black)
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.6)
                    .ignoresSafeArea()
                VStack {
                    
                    VStack {
                        TextField("输入二维码内容", text: $qrString)
                            .frame(height: 60)
                            .clearButton(text: $qrString)
                            .textFieldStyle(.roundedBorder)
                        stylingQRImg()
                            .resizable()
                            .frame(width: CGFloat(qrImageWidth), height: CGFloat(qrImageWidth))
//                        UIImage(named: "openai")
//                        QRImage(generatorQRCode(from: qrString))
                    }
                    ScrollView {
                        Group {
                            GroupTitleView(title: "二维码")
                            HStack {
                                ChangeSizeView()
                                ColorPickerView(title: "颜色", selection: $currentColor)
                                    .frame(width: 150, alignment: .trailing)
                            }
                            
                        }
                    }
                }
                .padding()
                .navigationTitle("Generator QRCode")
                .ignoresSafeArea(edges: .bottom)
            }
 
        }
    }
    
    func generatorQRCode(from string: String) -> CIImage? {
        guard !string.isEmpty else { return nil }
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = string.data(using: .ascii, allowLossyConversion: false)
        filter.setValue(data, forKey: "inputMessage")
        
        guard let ciimage = filter.outputImage else { return nil }
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let colorImage = scaledCIImage.tinted(using: UIColor(currentColor))
        return colorImage
    }
    func stylingQRImg() -> Image {
        
        guard let colorImage = generatorQRCode(from: qrString) else { return Image(systemName: "qrcode")}
        
        guard let logo = UIImage(named: "openai.png")?.cgImage else {
            return Image(systemName: "qrcode")
        }
       let newImage =  colorImage.combined(with: CIImage(cgImage: logo))
        
        let uiimage = UIImage(ciImage: newImage!)
        let data1 = uiimage.pngData()!
        return Image(uiImage: UIImage(data:data1)!)
    }
    @ViewBuilder
    func QRImage(_ qrImage: Image?) -> some View {
        VStack {
            if let qrImage {
                VStack {
                    qrImage
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: CGFloat(qrImageWidth), height: CGFloat(qrImageWidth))
                    Text("长按识别/导出二维码")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(Int(qrImageWidth)) * \(Int(qrImageWidth))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
   
            }else {
                Image(systemName: "qrcode")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
            }
        }
    }
    @ViewBuilder
    func GroupTitleView(title: String) -> some View {
        HStack {
            Text(title)
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background {
                    Rectangle()
                        .fill(.gray.opacity(0.5))
                }
            
        }
    }
    @ViewBuilder
    func ChangeSizeView() -> some View {
        HStack {
            Text("二维码尺寸")
                .foregroundColor(.white)
                .font(.subheadline)
            Slider(value: $qrImageWidth, in: 50...200)
            
        }
    }
    @ViewBuilder
    func ColorPickerView(title:String,selection: Binding<Color>) -> some View {
        ColorPicker(title, selection: selection)
            .foregroundColor(.white)
            .fixedSize()
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding()
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
    }
}
