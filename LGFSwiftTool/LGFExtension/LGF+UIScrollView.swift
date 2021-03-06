//
//  LGF+UIScrollView.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/5.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIScrollView {
    
    // MARK: - 获取横向滚动index
    func lgf_HorizontalIndex() -> Int {
        return Int(self.contentOffset.x / self.bounds.size.width)
    }
    
    // MARK: - 获取竖向滚动index
    func lgf_VerticalIndex() -> Int {
        return Int(self.contentOffset.y / self.bounds.size.height)
    }
    
    // MARK: - scrollview table 底部滚动
    class func lgf_Table(_ backgroundColorHexString: String) -> UIScrollView {
        let scv: UIScrollView = UIScrollView.init()
        scv.backgroundColor = UIColor.init(lgf_HexString: backgroundColorHexString)
        scv.showsVerticalScrollIndicator = false
        scv.showsHorizontalScrollIndicator = false
        scv.alwaysBounceVertical = true
        scv.alwaysBounceHorizontal = false
        return scv
    }
    
    // MARK: - scrollview table 自动 contentSize
    func lgf_AutoContentSize(_ bottom: CGFloat) -> Void {
        if self.subviews.count > 0 {
            self.layoutIfNeeded()
            DispatchQueue.main.async {
                let contentSizeHeight: CGFloat = self.subviews.last!.lgf_Y + self.subviews.last!.lgf_Height + bottom
                self.contentSize = CGSize.init(width: self.lgf_Width, height: contentSizeHeight)
            }
        }
    }
}

#endif // canImport(UIKit)
