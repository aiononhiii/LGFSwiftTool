//
//  LGF+Int.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/21.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension Int {
    
    // MARK: - 获取相对于屏幕宽度
    func lgf_W() -> CGFloat {
        return CGFloat(self * Int(UIDevice.lgf_ScreenW / 375))
    }
    
    // MARK: - 获取相对于屏幕高度
    func lgf_H() -> CGFloat {
        return CGFloat(self * Int(UIDevice.lgf_ScreenH / 667))
    }
    
    // MARK: - 获取相对于屏幕宽度
    func lgf_W() -> Double {
        return Double(self * Int(UIDevice.lgf_ScreenW / 375))
    }
    
    // MARK: - 获取相对于屏幕高度
    func lgf_H() -> Double {
        return Double(self * Int(UIDevice.lgf_ScreenH / 667))
    }
    
    // MARK: - 获取相对于屏幕宽度
    func lgf_W() -> Int {
        return self * Int(UIDevice.lgf_ScreenW / 375)
    }
    
    // MARK: - 获取相对于屏幕高度
    func lgf_H() -> Int {
        return self * Int(UIDevice.lgf_ScreenH / 667)
    }
    
}

#endif // canImport(UIKit)
