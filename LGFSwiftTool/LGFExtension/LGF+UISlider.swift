//
//  LGF+UISlider.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UISlider {
    // MARK: - 动画 setValue
    public func lgf_SetAnimateValue(_ value: Float, duration: Double) {
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.setValue(value, animated: true)
        }, completion: nil)
    }
}

#endif // canImport(UIKit)
