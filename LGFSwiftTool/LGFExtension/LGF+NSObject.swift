//
//  LGF+NSObject.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var lgf_ClassName: String { get }
    var lgf_ClassName: String { get }
}

// MARK: - 便捷获取当前类名字符串
public extension ClassNameProtocol {
    static var lgf_ClassName: String {
        return String.init(describing: self)
    }
    var lgf_ClassName: String {
        return Self.lgf_ClassName
    }
}

extension NSObject: ClassNameProtocol {}

// MARK: - 获取 object 描述
public extension NSObjectProtocol {
    var describedProperty: String {
        let mirror = Mirror(reflecting: self)
        return mirror.children.map { element -> String in
            let key = element.label ?? "Unknown"
            let value = element.value
            return "\(key): \(value)"
            }
            .joined(separator: "\n")
    }
}

private var lgf_NameKey: String = "lgf_NameKey"

public extension NSObject {
    // MARK: - 给 object 定义一个字符串名字(类似 view 的 tag)
    var lgf_Name: String? {
        get {
            return (objc_getAssociatedObject(self, &lgf_NameKey) as? String)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &lgf_NameKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
}
