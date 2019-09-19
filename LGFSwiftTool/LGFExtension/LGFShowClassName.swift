//
//  LGFShowClassName.swift
//  LGFFreePTDemo-swift
//
//  Created by apple on 2019/7/29.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIViewController {

    class func lgf_ShowClassName(_ isShow: Bool) {
        #if DEBUG
        if isShow {
            let vda = #selector(UIViewController.viewDidAppear(_:))
            let lgf_vda = #selector(UIViewController.lgf_ViewDidAppear(_:))
            let vdaMethod = class_getInstanceMethod(self, vda)
            let lgf_vdaMethod = class_getInstanceMethod(self, lgf_vda)
            self.lgf_MethodReplace(m: vda, rm: lgf_vda, mm: vdaMethod!, rmm: lgf_vdaMethod!)
        }
        #endif
    }

    class func lgf_MethodReplace(m: Selector, rm: Selector, mm: Method, rmm: Method) -> Void {
        #if DEBUG
        let didAddMethod: Bool = class_addMethod(self, m, method_getImplementation(rmm), method_getTypeEncoding(rmm))
        if didAddMethod {
            class_replaceMethod(self, rm, method_getImplementation(mm), method_getTypeEncoding(mm))
        } else {
            method_exchangeImplementations(mm, rmm)
        }
        #endif
    }

    @objc func lgf_ViewDidAppear(_ animated: Bool) {
        #if DEBUG
        self.lgf_ViewDidAppear(animated)
        if Bundle.init(for: self.classForCoder) == Bundle.main {
            if self.parent != nil && Bundle.init(for: self.parent!.classForCoder) != Bundle.main {
                var allVC = "当前正在\n\n\(type(of: self))\n\n控制器"
                allVC = allVC + (self.children.count > 0 ? "\n\n拥有子控制器:\n" : "")
                self.children.forEach { (vc) in
                    allVC = allVC + "\n\(type(of: vc))"
                }
                self.lgf_CallMsg(allVC)
            }
        }
        #endif
    }
    
    
    func lgf_CallMsg(_ msg: String) -> Void {
        debugPrint(msg)
        #if DEBUG
        let message = UILabel.init(frame: UIScreen.main.bounds)
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: msg)
        let allRange = "".lgf_NsRange(from: msg.range(of: msg)!)
        let range = "".lgf_NsRange(from: msg.range(of: "\(type(of: self))")!)
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightText, range: allRange)
        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Light",size: 14)!, range: allRange)
        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold",size: 18)!, range: range)
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: range)
        message.attributedText = attributeString
        message.textRect(forBounds: CGRect.init(x: 20, y: 20, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 40), limitedToNumberOfLines: 100)
        message.numberOfLines = 100
        message.textAlignment = .center
        message.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        UIApplication.shared.windows.first?.addSubview(message)
        message.lgf_AddTap(target: self, action: #selector(lgf_HideClassMessage(_:)))
        #endif
    }
    
    @objc func lgf_HideClassMessage(_ sender: UITapGestureRecognizer) -> Void {
        sender.view?.removeFromSuperview()
    }
}
#endif // canImport(UIKit)
