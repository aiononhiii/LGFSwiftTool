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
    
    // MARK: -  获取横向滚动index
    func lgf_HorizontalIndex() -> Int {
        return Int(self.contentOffset.x / self.bounds.size.width)
    }
    
    // MARK: -  获取竖向滚动index
    func lgf_VerticalIndex() -> Int {
        return Int(self.contentOffset.y / self.bounds.size.height)
    }
    
}

#endif // canImport(UIKit)
