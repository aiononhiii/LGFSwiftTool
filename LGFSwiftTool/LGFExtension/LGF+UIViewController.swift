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
}

#endif // canImport(UIKit)
