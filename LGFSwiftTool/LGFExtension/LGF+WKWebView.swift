//
//  LGF+WKWebView.swift
//  LGFSwiftTool
//
//  Created by 来 on 2020/5/14.
//  Copyright © 2020 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import WebKit

typealias OlderClosureType =  @convention(c) (Any, Selector, UnsafeRawPointer, Bool, Bool, Any?) -> Void
typealias NewerClosureType =  @convention(c) (Any, Selector, UnsafeRawPointer, Bool, Bool, Bool, Any?) -> Void

public extension WKWebView {
    
    /// 这个属性UIWebview有，WKWebView要自己实现
    var lgf_KeyboardDisplayRequiresUserAction: Bool? {
        set {
            setLgf_KeyboardRequiresUserInteraction(newValue ?? true)
        }
        get {
            return self.lgf_KeyboardDisplayRequiresUserAction
        }
    }
    
    func setLgf_KeyboardRequiresUserInteraction( _ value: Bool) {
        guard let WKContentViewClass: AnyClass = NSClassFromString("WKContentView") else {
            print("Cannot find the WKContentView class")
            return
        }
        let olderSelector: Selector = sel_getUid("_startAssistingNode:userIsInteracting:blurPreviousNode:userObject:")
        let newSelector: Selector = sel_getUid("_startAssistingNode:userIsInteracting:blurPreviousNode:changingActivityState:userObject:")
        let newerSelector: Selector = sel_getUid("_elementDidFocus:userIsInteracting:blurPreviousNode:changingActivityState:userObject:")
        let ios13Selector: Selector = sel_getUid("_elementDidFocus:userIsInteracting:blurPreviousNode:activityStateChanges:userObject:")
        if let method = class_getInstanceMethod(WKContentViewClass, olderSelector) {
            let originalImp: IMP = method_getImplementation(method)
            let original: OlderClosureType = unsafeBitCast(originalImp, to: OlderClosureType.self)
            let block : @convention(block) (Any, UnsafeRawPointer, Bool, Bool, Any?) -> Void = { (me, arg0, arg1, arg2, arg3) in
                original(me, olderSelector, arg0, !value, arg2, arg3)
            }
            let imp: IMP = imp_implementationWithBlock(block)
            method_setImplementation(method, imp)
        }
        if let method = class_getInstanceMethod(WKContentViewClass, newSelector) {
            swizzleAutofocusMethod(method, newSelector, value)
        }
        if let method = class_getInstanceMethod(WKContentViewClass, newerSelector) {
            swizzleAutofocusMethod(method, newerSelector, value)
        }
        if let method = class_getInstanceMethod(WKContentViewClass, ios13Selector) {
            swizzleAutofocusMethod(method, ios13Selector, value)
        }
    }
    
    func swizzleAutofocusMethod(_ method: Method, _ selector: Selector, _ value: Bool) {
        let originalImp: IMP = method_getImplementation(method)
        let original: NewerClosureType = unsafeBitCast(originalImp, to: NewerClosureType.self)
        let block : @convention(block) (Any, UnsafeRawPointer, Bool, Bool, Bool, Any?) -> Void = { (me, arg0, arg1, arg2, arg3, arg4) in
            original(me, selector, arg0, !value, arg2, arg3, arg4)
        }
        let imp: IMP = imp_implementationWithBlock(block)
        method_setImplementation(method, imp)
    }
    
}

#endif // canImport(UIKit)
