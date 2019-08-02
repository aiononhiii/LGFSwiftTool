//
//  LGF+UINavigationController.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UINavigationController {
    
    // MARK: - push 添加 completion 完成回调
    open func lgf_PushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        lgf_ExecuteTransitionCoordinator(animated: animated, completion: completion)
    }
    
    // MARK: - pop 添加 completion 完成回调
    @discardableResult
    open func lgf_PopViewController(animated: Bool, completion: @escaping () -> Void) -> UIViewController? {
        let viewController = popViewController(animated: animated)
        lgf_ExecuteTransitionCoordinator(animated: animated, completion: completion)
        return viewController
    }
    
    // MARK: - pop 添加 completion 完成回调
    @discardableResult
    open func lgf_PopToViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) -> [UIViewController]? {
        let viewControllers = popToViewController(viewController, animated: animated)
        lgf_ExecuteTransitionCoordinator(animated: animated, completion: completion)
        return viewControllers
    }
    
    // MARK: - pop 添加 completion 完成回调
    @discardableResult
    open func lgf_PopToRootViewController(animated: Bool, completion: @escaping () -> Void) -> [UIViewController]? {
        let viewControllers = popToRootViewController(animated: animated)
        lgf_ExecuteTransitionCoordinator(animated: animated, completion: completion)
        return viewControllers
    }
    
    // MARK: - 主线程回调
    private func lgf_ExecuteTransitionCoordinator(animated: Bool, completion: @escaping () -> Void) {
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async(execute: completion)
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    
}

#endif // canImport(UIKit)
