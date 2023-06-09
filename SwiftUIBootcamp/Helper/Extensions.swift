//
//  Extensions.swift
//  SwiftUIBootcamp
//
//  Created by txby on 2023/5/8.
//

import SwiftUI
extension View {
    func clearButton(text: Binding<String>) -> some View {
        modifier(TextFieldClearButton(text: text))
    }
    //Screen Bounds Extensions
    func screenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
    var viewWidth: CGFloat {
        return screenBounds().width
    }
//    func viewWidth() -> CGFloat {
//        
//        return screenBounds().width
//    }
}
extension CIImage {
    var transparent: CIImage? {
        return inverted?.blackTransparent
    }
    var inverted: CIImage? {
        guard let invertedColorFilter = CIFilter(name: "CIColorInvert") else { return nil }
        
        invertedColorFilter.setValue(self, forKey: "inputImage")
        return invertedColorFilter.outputImage
    }
    
    var blackTransparent: CIImage? {
        guard let blackTransparentFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
        blackTransparentFilter.setValue(self, forKey: "inputImage")
        return blackTransparentFilter.outputImage
    }
    
    
    func tinted(using color: UIColor) -> CIImage? {
        guard
            let transparentQRImage = transparent,
            let filter = CIFilter(name: "CIMultiplyCompositing"),
            let colorFilter = CIFilter(name: "CIConstantColorGenerator") else { return nil }
        
        let ciCOlor = CIColor(color: color)
        colorFilter.setValue(ciCOlor, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage
        
        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(transparentQRImage, forKey: kCIInputBackgroundImageKey)
        
        return filter.outputImage
    }
    
    func combined(with image: CIImage) -> CIImage? {
        guard let combinedFilter = CIFilter(name: "CISourceOverCompositing") else { return nil }
        let centerTransForm = CGAffineTransform(translationX: extent.midX - (image.extent.width / 2), y: extent.midY - (image.extent.height / 2))
        combinedFilter.setValue(image.transformed(by: centerTransForm), forKey: "inputImage")
        combinedFilter.setValue(self, forKey: "inputBackgroundImage")
        return combinedFilter.outputImage!
        
    }
}
