//
//  LGF+Double.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/20.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension Double {
    
    // MARK: - 获取相对于屏幕宽度
    func lgf_W() -> CGFloat {
        return CGFloat(self * Double(UIDevice.lgf_ScreenW / 375.0))
    }
    
    // MARK: - 获取相对于屏幕高度
    func lgf_H() -> CGFloat {
        return CGFloat(self * Double(UIDevice.lgf_ScreenH / 667.0))
    }
    
}

#endif // canImport(UIKit)
