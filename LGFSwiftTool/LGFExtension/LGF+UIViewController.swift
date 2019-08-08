//
//  LGF+UIViewController.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIViewController {
    
    // MARK: - 便捷 添加子控制器
    func lgf_AddChildView(_ child: UIViewController, layoutOption: lgf_LayoutOption = .fill) {
        loadViewIfNeeded()
        child.loadViewIfNeeded()
        addChild(child)
        view.addSubview(child.view)
        lgf_Layout(child.view, layoutOption: layoutOption)
        child.didMove(toParent: self)
    }
    
    // MARK: - 便捷 从父控制器上删除
    func lgf_Remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    // MARK: - 便捷 autolayout
    private func lgf_Layout(_ child: UIView, layoutOption: lgf_LayoutOption) {
        switch layoutOption {
        case .fill:
            child.lgf_FillSuperview()
        case .custom(let customLayout):
            customLayout(view, child)
        }
    }
    
    // MARK: - autolayout 状态
    enum lgf_LayoutOption {
        case fill
        case custom((UIView, UIView) -> Void)
    }
    
    // MARK: - 查找顶层控制器、
    // 获取顶层控制器 根据window
    static func lgf_GetTopVC() -> (UIViewController?) {
        var window = UIApplication.shared.keyWindow
        //是否为当前显示的window
        if window?.windowLevel != .normal {
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == .normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return lgf_GetTopVC(withCurrentVC: vc)
    }
    ///根据控制器获取 顶层控制器
    static func lgf_GetTopVC(withCurrentVC VC :UIViewController?) -> UIViewController? {
        if VC == nil {
            print("🌶： 找不到顶层控制器")
            return nil
        }
        if let presentVC = VC?.presentedViewController {
            //modal出来的 控制器
            return lgf_GetTopVC(withCurrentVC: presentVC)
        }else if let tabVC = VC as? UITabBarController {
            // tabBar 的跟控制器
            if let selectVC = tabVC.selectedViewController {
                return lgf_GetTopVC(withCurrentVC: selectVC)
            }
            return nil
        } else if let naiVC = VC as? UINavigationController {
            // 控制器是 nav
            return lgf_GetTopVC(withCurrentVC:naiVC.visibleViewController)
        } else {
            // 返回顶控制器
            return VC
        }
    }
}

#endif // canImport(UIKit)
