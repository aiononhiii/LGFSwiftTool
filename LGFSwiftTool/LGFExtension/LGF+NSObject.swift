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
