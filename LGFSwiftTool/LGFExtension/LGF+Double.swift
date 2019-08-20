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
    func lgf_ScreenW() -> CGFloat {
        return CGFloat(self) * UIDevice.lgf_ScreenW / 375.0
    }
    
    // MARK: - 获取相对于屏幕高度
    func lgf_ScreenH() -> CGFloat {
        return CGFloat(self) * UIDevice.lgf_ScreenH / 667.0
    }
    
}

#endif // canImport(UIKit)
