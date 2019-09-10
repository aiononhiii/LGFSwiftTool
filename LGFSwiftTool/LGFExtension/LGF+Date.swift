//
//  LGF+Date.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/9/10.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(Foundation)
import Foundation

public extension Date {
    
    // MARK: - 返回格式化字符串
    func lgf_TimeStr(_ format: String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format ?? "yyyyMMdd"
        let time = formatter.string(from: self)
        return time
    }
    
    // MARK: - 获取加减 ?年 ?月 ?天 时间
    static func lgf_CurrentDateToWantDate(year:Int, month:Int, day:Int)-> Date {
        let current = Date()
        let calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents?
        comps = calendar.dateComponents([.year,.month,.day], from: current)
        comps?.year = year
        comps?.month = month
        comps?.day = day
        return calendar.date(byAdding: comps!, to: current) ?? Date()
    }
}

#endif // canImport(Foundation)
