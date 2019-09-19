//
//  LGF+UIButton.swift
//  LGFSwiftTool
//
//  Created by 来 on 2019/9/19.
//  Copyright © 2019 来国锋. All rights reserved.
//


#if canImport(UIKit)
import UIKit

public class LayoutButton: UIButton {
    
    enum lgf_Position {
        case top
        case bottom
        case left
        case right
    }
    
    private var position: lgf_Position?
    private var space: CGFloat = 0
    
    convenience init(_ position: lgf_Position, at space: CGFloat = 0) {
        self.init(type: .custom)
        self.position = position
        self.space = space
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if let position = position {
            switch position {
            case .top:
                let titleHeight = titleLabel?.bounds.height ?? 0
                let imageHeight = imageView?.bounds.height ?? 0
                let imageWidth = imageView?.bounds.width ?? 0
                let titleWidth = titleLabel?.bounds.width ?? 0
                titleEdgeInsets = UIEdgeInsets.init(top: (titleHeight + space) * 0.5, left: -imageWidth * 0.5, bottom: -space, right: imageWidth * 0.5)
                imageEdgeInsets = UIEdgeInsets.init(top: 0, left: titleWidth * 0.5, bottom: (imageHeight + space), right: -titleWidth * 0.5)
            case .bottom:
                let titleHeight = titleLabel?.bounds.height ?? 0
                let imageHeight = imageView?.bounds.height ?? 0
                let imageWidth = imageView?.bounds.width ?? 0
                let titleWidth = titleLabel?.bounds.width ?? 0
                titleEdgeInsets = UIEdgeInsets.init(top: -(titleHeight + space) * 0.5, left: -imageWidth * 0.5, bottom: space, right: imageWidth * 0.5)
                imageEdgeInsets = UIEdgeInsets.init(top: (imageHeight + space), left: titleWidth * 0.5, bottom: 0, right: -titleWidth * 0.5)
            case .left:
                titleEdgeInsets = UIEdgeInsets.init(top: 0, left: space, bottom: 0, right: 0)
                imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: space)
            case .right:
                let imageWidth = (imageView?.bounds.width ?? 0) + space
                let titleWidth = (titleLabel?.bounds.width ?? 0) + space
                titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageWidth, bottom: 0, right: imageWidth)
                imageEdgeInsets = UIEdgeInsets.init(top: 0, left: titleWidth, bottom: 0, right: -titleWidth)
            }
        }
    }
}

#endif // canImport(UIKit)
