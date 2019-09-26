//
//  LGF+UIButton.swift
//  LGFSwiftTool
//
//  Created by 来 on 2019/9/19.
//  Copyright © 2019 来国锋. All rights reserved.
//


#if canImport(UIKit)
import UIKit

public enum lgf_ImageEdgeInsetsType {
    case top, left, right, bottom
}

public extension UIButton {
    
    // MARK: - 按钮图片上下左右
    func lgf_ImagePosition(at type: lgf_ImageEdgeInsetsType, space: CGFloat) {
        DispatchQueue.main.async {
            guard let imageV = self.imageView else { return }
            guard let titleL = self.titleLabel else { return }
            //获取图像的宽和高
            let imageWidth = imageV.frame.size.width
            let imageHeight = imageV.frame.size.height
            //获取文字的宽和高
            let labelWidth  = titleL.intrinsicContentSize.width
            let labelHeight = titleL.intrinsicContentSize.height
            
            var imageEdgeInsets = UIEdgeInsets.zero
            var labelEdgeInsets = UIEdgeInsets.zero
            //UIButton同时有图像和文字的正常状态---左图像右文字，间距为0
            switch type {
            case .left:
                //正常状态--只不过加了个间距
                imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
            case .right:
                //切换位置--左文字右图像
                //图像：UIEdgeInsets的left是相对于UIButton的左边移动了labelWidth + space * 0.5，right相对于label的左边移动了-labelWidth - space * 0.5
                imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: -labelWidth - space * 0.5)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
            case .top:
                //切换位置--上图像下文字
                /**图像的中心位置向右移动了labelWidth * 0.5，向上移动了-imageHeight * 0.5 - space * 0.5
                 *文字的中心位置向左移动了imageWidth * 0.5，向下移动了labelHeight*0.5+space*0.5
                 */
                imageEdgeInsets = UIEdgeInsets(top: -imageHeight * 0.5 - space * 0.5, left: labelWidth * 0.5, bottom: imageHeight * 0.5 + space * 0.5, right: -labelWidth * 0.5)
                labelEdgeInsets = UIEdgeInsets(top: labelHeight * 0.5 + space * 0.5, left: -imageWidth * 0.5, bottom: -labelHeight * 0.5 - space * 0.5, right: imageWidth * 0.5)
            case .bottom:
                //切换位置--下图像上文字
                /**图像的中心位置向右移动了labelWidth * 0.5，向下移动了imageHeight * 0.5 + space * 0.5
                 *文字的中心位置向左移动了imageWidth * 0.5，向上移动了labelHeight*0.5+space*0.5
                 */
                imageEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + space * 0.5, left: labelWidth * 0.5, bottom: -imageHeight * 0.5 - space * 0.5, right: -labelWidth * 0.5)
                labelEdgeInsets = UIEdgeInsets(top: -labelHeight * 0.5 - space * 0.5, left: -imageWidth * 0.5, bottom: labelHeight * 0.5 + space * 0.5, right: imageWidth * 0.5)
            }
            self.titleEdgeInsets = labelEdgeInsets
            self.imageEdgeInsets = imageEdgeInsets
        }
    }
}

#endif // canImport(UIKit)
