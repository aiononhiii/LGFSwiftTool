//
//  LGF+Array.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

import Foundation

public extension Array {
    
    // MARK: - 数组转 json
    func lgf_ToJSON() -> String {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: self, options: []) as NSData
        let JSONString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
}

public extension Array where Element: Equatable {
    
    // MARK: - 便捷删除某个对象
    @discardableResult
    mutating func lgf_Remove(_ element: Element) -> Index? {
        guard let index = firstIndex(of: element) else { return nil }
        remove(at: index)
        return index
    }
    
    // MARK: - 便捷删除多个对象
    @discardableResult
    mutating func lgf_Remove(_ elements: [Element]) -> [Index] {
        return elements.compactMap { lgf_Remove($0) }
    }
    
    // MARK: - 获取某个对象下标
    func lgf_IndexOfObject(_ element: Element) -> Int {
        return self.firstIndex(where: { $0 == element }) ?? 0
    }
}

// MARK: - 便捷数组去除重复
public extension Array where Element: Hashable {
    mutating func lgf_Unify() {
        self = lgf_Unified()
    }
}

public extension Collection where Element: Hashable {
    func lgf_Unified() -> [Element] {
        return reduce(into: []) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}

// MARK: - 该下标 index 是否在数组中安全（可有效防止数组越界）
public extension Collection {
    subscript(safe index: Index) -> Element? {
        return startIndex <= index && index < endIndex ? self[index] : nil
    }
}
