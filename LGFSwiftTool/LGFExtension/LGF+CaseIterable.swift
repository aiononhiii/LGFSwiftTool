//
//  LGF+CaseIterable.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

import Foundation

public extension Hashable where Self: CaseIterable {
    // MARK: - 获取枚举下标
    /// enum LGF: CaseIterable {
    ///     case 🐶
    ///     case 🐱
    ///     case 🐭
    /// }
    /// LGF.🐶.caseIndex == 0
    /// LGF.🐱.caseIndex == 1
    /// LGF.🐭.caseIndex == 2
    var lgf_CaseIndex: AllCases.Index {
        return type(of: self).allCases.firstIndex(of: self)!
    }
}
