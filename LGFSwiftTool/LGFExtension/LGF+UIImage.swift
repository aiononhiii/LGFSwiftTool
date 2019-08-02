//
//  LGF+UIImage.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIImage {
    
    // MARK: - 生成一张指定大小和颜色的图片（IOS 10 以上）
    @available(iOS 10.0, *)
    convenience init(color: UIColor, size: CGSize) {
        let image = UIGraphicsImageRenderer(size: size).image { context in
            context.cgContext.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
    }
    
    // MARK: - 为图片设置主题色（IOS 10 以上）
    @available(iOS 10.0, *)
    func lgf_Image(withTint color: UIColor) -> UIImage {
        guard let cgImage = cgImage else { return self }
        let rect = CGRect(origin: .zero, size: size)
        return UIGraphicsImageRenderer(size: size).image { context in
            context.cgContext.scaleBy(x: 1, y: -1)
            context.cgContext.translateBy(x: 0, y: -self.size.height)
            context.cgContext.clip(to: rect, mask: cgImage)
            context.cgContext.setFillColor(color.cgColor)
            context.fill(rect)
        }
    }
    
    // MARK: - 裁剪图片
    func lgf_Cropped(to rect: CGRect) -> UIImage {
        guard let cgImage = cgImage,
            let imageRef = cgImage.cropping(to: rect) else { return UIImage() }
        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
    }
    
    // MARK: - 调整图片size（IOS 10 以上）
    @available(iOS 10.0, *)
    func lgf_Resized(to newSize: CGSize) -> UIImage {
        let scaledSize = newSize.applying(.init(scaleX: 1 / scale, y: 1 / scale))
        return UIGraphicsImageRenderer(size: scaledSize).image { context in
            draw(in: .init(origin: .zero, size: scaledSize))
        }
    }
    
    // MARK: - 调整图片size（IOS 10 以上）
    @available(iOS 10.0, *)
    func lgf_Resized(to newSize: CGSize, scalingMode: lgf_ScalingMode) -> UIImage {
        let scaledNewSize = newSize.applying(.init(scaleX: 1 / scale, y: 1 / scale))
        let aspectRatio = scalingMode.aspectRatio(between: scaledNewSize, and: size)
        let aspectRect = CGRect(x: (scaledNewSize.width - size.width * aspectRatio) / 2.0,
                                y: (scaledNewSize.height - size.height * aspectRatio) / 2.0,
                                width: size.width * aspectRatio,
                                height: size.height * aspectRatio)
        return UIGraphicsImageRenderer(size: scaledNewSize).image { context in
            draw(in: aspectRect)
        }
    }
    
    // MARK: - 图片转JPEG
    /// - Parameter quarity: 转换率
    func lgf_ToJPEG(quarity: CGFloat = 1.0) -> Data? {
        return self.jpegData(compressionQuality: quarity)
    }
    
    // MARK: - 图片转PNG
    func lgf_ToPNG() -> Data? {
        return self.pngData()
    }
    
    // MARK: - 图片圆角/边配置（高性能）
    @available(iOS 10.0, *)
    func lgf_Rounded(cornerRadius: CGFloat? = nil, borderWidth: CGFloat = 0, borderColor: UIColor = .white) -> UIImage {
        let diameter = min(size.width, size.height)
        let isLandscape = size.width > size.height
        let xOffset = isLandscape ? (size.width - diameter) / 2 : 0
        let yOffset = isLandscape ? 0 : (size.height - diameter) / 2
        let imageSize = CGSize(width: diameter, height: diameter)
        return UIGraphicsImageRenderer(size: imageSize).image { _ in
            let roundedPath = UIBezierPath(roundedRect: CGRect(origin: .zero, size: imageSize),
                                           cornerRadius: cornerRadius ?? diameter / 2)
            roundedPath.addClip()
            draw(at: CGPoint(x: -xOffset, y: -yOffset))
            if borderWidth > 0 {
                borderColor.setStroke()
                roundedPath.lineWidth = borderWidth
                roundedPath.stroke()
            }
        }
    }
    
    // MARK: - 获取图片上某个点的像素颜色(用于便捷取颜色)
    func lgf_PixelColor(at point: CGPoint) -> UIColor? {
        let size = cgImage.map { CGSize(width: $0.width, height: $0.height) } ?? self.size
        guard point.x >= 0, point.x < size.width, point.y >= 0, point.y < size.height,
            let data = cgImage?.dataProvider?.data,
            let pointer = CFDataGetBytePtr(data) else { return nil }
        let numberOfComponents = 4
        let pixelData = Int((size.width * point.y) + point.x) * numberOfComponents
        let r = CGFloat(pointer[pixelData]) / 255.0
        let g = CGFloat(pointer[pixelData + 1]) / 255.0
        let b = CGFloat(pointer[pixelData + 2]) / 255.0
        let a = CGFloat(pointer[pixelData + 3]) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - 规范化图片
    var canonicalized: UIImage {
        guard let cgImage = cgImage else { return self }
        let bytesPerPixel = 4
        var data = [UInt8](repeating: 0, count: cgImage.width * cgImage.height * bytesPerPixel)
        let bytesPerRow = bytesPerPixel * cgImage.width
        
        guard let context = CGContext(data: &data,
                                      width: cgImage.width,
                                      height: cgImage.height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: bytesPerRow,
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { return self }
        
        context.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width: cgImage.width, height: cgImage.height)))
        guard let image = context.makeImage() else { return self }
        return UIImage(cgImage: image, scale: 1, orientation: .up)
    }
}

extension UIImage {
    // 缩放枚举
    public enum lgf_ScalingMode {
        case aspectFill
        case aspectFit
        
        func aspectRatio(between size: CGSize, and otherSize: CGSize) -> CGFloat {
            let aspectWidth  = size.width / otherSize.width
            let aspectHeight = size.height / otherSize.height
            
            switch self {
            case .aspectFill: return max(aspectWidth, aspectHeight)
            case .aspectFit: return min(aspectWidth, aspectHeight)
            }
        }
    }
}
#endif // canImport(UIKit)
