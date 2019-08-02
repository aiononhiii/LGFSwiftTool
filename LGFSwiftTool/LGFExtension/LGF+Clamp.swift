//
//  LGF+Clamp.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

import Foundation

// MARK: - value 3 不小于 2 或不大于 5 那么 value == 3，value 3 小于 2 那么 value == 2，value 3 大于 5 那么 value == 5
// let num = lgf_Clamp(3, min: 2, max: 5) -> num == 3
// let num = lgf_Clamp(1, min: 2, max: 5) -> num == 2
// let num = lgf_Clamp(888, min: 2, max: 5) -> num == 5
public func lgf_Clamp<T: Comparable>(_ value: T, min minValue: T, max maxValue: T) -> T {
    return max(min(value, maxValue), minValue)
}

// MARK: - 本体 3 不小于 2 或不大于 5 那么 本体 == 3，本体 3 小于 2 那么 本体 == 2，本体 3 大于 5 那么 本体 == 5
// let num = 3.lgf_Clamped(min: 2, max: 5) -> num == 3
// let num = 1.lgf_Clamped(min: 2, max: 5) -> num == 2
// let num = 888.lgf_Clamped(min: 2, max: 5) -> num == 5
public extension Comparable {
    func lgf_Clamped(min: Self, max: Self) -> Self {
        if self < min { return min }
        if self > max { return max }
        return self
    }
}
