//
//  LGF+Xib.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: -  协议静态值
public protocol lgf_NibInstantiatable {
    static var lgf_NibName: String { get }
    static var lgf_NibBundle: Bundle { get }
    static var lgf_NibOwner: Any? { get }
    static var lgf_NibOptions: [UINib.OptionsKey: Any]? { get }
    static var lgf_InstantiateIndex: Int { get }
}

// MARK: -  静态值赋默认值可在 view 类里面重新定义修改
public extension lgf_NibInstantiatable where Self: NSObject {
    static var lgf_NibName: String { return lgf_ClassName }
    static var lgf_NibBundle: Bundle { return Bundle(for: self) }
    static var lgf_NibOwner: Any? { return self }
    static var lgf_NibOptions: [UINib.OptionsKey: Any]? { return nil }
    static var lgf_InstantiateIndex: Int { return 0 }
}

public extension lgf_NibInstantiatable where Self: UIView {
    static func lgf() -> Self {
        let nib = UINib(nibName: lgf_NibName, bundle: lgf_NibBundle)
        return nib.instantiate(withOwner: lgf_NibOwner, options: lgf_NibOptions)[lgf_InstantiateIndex] as! Self
    }
}

// 嵌入某个 view
public protocol lgf_EmbeddedNibInstantiatable {
    associatedtype lgf_Embedded: lgf_NibInstantiatable
}

public extension lgf_EmbeddedNibInstantiatable where Self: UIView, lgf_Embedded: UIView {
    var embedded: lgf_Embedded { return subviews[0] as! lgf_Embedded }
    // 在 override func awakeFromNib() {} 中添加该方法
    func lgf_ConfigureEmbededView() {
        let view = lgf_Embedded.lgf()
        insertSubview(view, at: 0)
        view.lgf_FillSuperview()
    }
}

/**
 final class NibView: UIView, NibInstantiatable {
     @IBOutlet weak var label: UILabel!
 }
 
 final class SecondaryNibView: UIView, NibInstantiatable {
     static var nibName: String { return NibView.className }
     static var instantiateIndex: Int { return 1 }
 
     @IBOutlet weak var label: UILabel!
 }
 
 final class EmbeddedView: UIView, NibInstantiatable {
     @IBOutlet weak var label: UILabel!
 }
 
 @IBDesignable
 final class IBEmbeddedView: UIView, EmbeddedNibInstantiatable {
     typealias Embedded = EmbeddedView
 
     override func awakeFromNib() {
         super.awakeFromNib()
         configureEmbededView()
     }
 }
 
 final class SuperviewOfEmbeddedView: UIView, NibInstantiatable {
 static var nibName: String { return NibView.className }
 static var instantiateIndex: Int { return 2 }
 
 @IBOutlet weak var embeddedView: IBEmbeddedView!
 }
 
 class NibInstantiatableTests: XCTestCase {
 
 func testInstantiate() {
     let view = NibView.lgf()
     view.label.text = "lgf"
 }
 
 func testInstantiateSecondaryView() {
     let view = SecondaryNibView.lgf()
     view.label.text = "lgf"
 }
 
 func testInstantiateSuperviewOfOwnerView() {
     let view = SuperviewOfEmbeddedView.lgf()
     view.embeddedView.embedded.label.text = "lgf"
 }
 }
 **/
#endif // canImport(UIKit)
