//
//  LGF+Dictionary.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

import Foundation

public struct DictionaryTryValueError: Error {
    public init() {}
}

public extension Dictionary {
    // MARK: - 尝试着给 Dictionary 的 key 赋值 如果 key 不存在将抛出异常
    ///   var isError = false
    ///   do {
    ///   _ = try dictionary.tryValue(forKey: "foo")
    ///   } catch is DictionaryTryValueError {
    ///   isError = true
    ///   } catch {
    ///   }
    func tryValue(forKey key: Key, error: Error = DictionaryTryValueError()) throws -> Value {
        guard let value = self[key] else { throw error }
        return value
    }
}
