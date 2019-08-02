//
//  LGF+URL.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    // MARK: - 利用 ExpressibleByStringLiteral 协议来使 URL 可以直接赋值字符串
    // 类似这样：let url: URL = "https://www.baidu.com"
    public init(stringLiteral value: String) {
        guard let url = URL(string: value) else {
            fatalError("\(value) is an invalid url")
        }
        self = url
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}
