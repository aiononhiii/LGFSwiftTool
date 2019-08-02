//
//  LGF+UIApplication.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/7/31.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIApplication {
    
    // MARK: - 获取当前最顶层的控制器
    var lgf_TopViewController: UIViewController? {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }
    
    // MARK: - 获取当前最顶层的 Navigation 控制器
    var lgf_TopNavigationController: UINavigationController? {
        return lgf_TopViewController as? UINavigationController
    }
    
}
#endif // canImport(UIKit)
