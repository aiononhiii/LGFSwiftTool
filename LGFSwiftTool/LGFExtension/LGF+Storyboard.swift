//
//  LGF+Storyboard.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: -  Storyboard 初始化类型枚举
public enum lgf_StoryboardInstantiateType {
    case initial
    case identifier(String)
}

// MARK: -  协议静态值
public protocol lgf_StoryboardInstantiatable {
    static var lgf_StoryboardName: String { get }
    static var lgf_StoryboardBundle: Bundle { get }
    static var lgf_InstantiateType: lgf_StoryboardInstantiateType { get }
}

public extension lgf_StoryboardInstantiatable where Self: NSObject {
    // 静态默认 StoryboardName 可以在控制器类重新赋值修改
    static var lgf_StoryboardName: String {
        return lgf_ClassName
    }
    // 静态默认 StoryboardBundle 可以在控制器类重新赋值修改
    static var lgf_StoryboardBundle: Bundle {
        return Bundle(for: self)
    }
    // 静态默认 Storyboard 初始化类型（见 lgf_StoryboardInstantiateType 枚举） 可以在控制器类重新赋值修改
    static var lgf_InstantiateType: lgf_StoryboardInstantiateType {
        return .identifier(lgf_StoryboardName)
    }
    private static var lgf_Storyboard: UIStoryboard {
        return UIStoryboard(name: lgf_StoryboardName, bundle: lgf_StoryboardBundle)
    }
}

// MARK: - 便捷 Storyboard 初始化
public extension lgf_StoryboardInstantiatable where Self: UIViewController {
    static func lgf() -> Self {
        switch lgf_InstantiateType {
        case .initial:
            return lgf_Storyboard.instantiateInitialViewController() as! Self
        case .identifier(let identifier):
            return lgf_Storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        }
    }
}

// MARK: - 使用
/**
 
 // 箭头 storyboard 初始化
 final class InitialViewController: UIViewController, lgf_StoryboardInstantiatable {
     @IBOutlet weak var label: UILabel!
     static var lgf_InstantiateType: lgf_StoryboardInstantiateType {
         return .initial
     }
 }
 
 // 初始化
 func testInstantiateByInitial() {
     let viewControlelr = InitialViewController.lgf()
     _ = viewControlelr.view// _ = viewControlelr.view 之前 viewControlelr.label == nil, 之后 viewControlelr.label 才有值
     viewControlelr.label.text = "lgf"
 }
 
 // identifier storyboard 初始化
 final class IdentifierViewController: UIViewController, lgf_StoryboardInstantiatable {
     @IBOutlet weak var label: UILabel!
     static var lgf_StoryboardName: String { return InitialViewController.className }
 }
 
 // 初始化
 func testInstantiateByIdentifier() {
     let viewControlelr = IdentifierViewController.lgf()
     _ = viewControlelr.view// _ = viewControlelr.view 之前 viewControlelr.label == nil, 之后 viewControlelr.label 才有值
     viewControlelr.label.text = "lgf"
 }
 
**/
#endif // canImport(UIKit)

