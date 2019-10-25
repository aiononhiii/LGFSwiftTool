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
    func lgf_CurrentDateToWantDate(year:Int, month:Int, day:Int)-> Date {
        let calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents?
        comps = calendar.dateComponents([.year,.month,.day], from: self)
        comps?.year = year
        comps?.month = month
        comps?.day = day
        return calendar.date(byAdding: comps!, to: self) ?? Date()
    }
    
    // MARK: - 计算年龄 NSInteger
    func lgf_AgeWithDateOfBirth() -> NSInteger {
        let components1 = Calendar.current.dateComponents([.day, .month, .year], from: self)
        let brithDateYear: Int = components1.year!
        let brithDateDay: Int   = components1.day!
        let brithDateMonth: Int = components1.month!
        let components2 = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        let currentDateYear: Int  = components2.year!
        let currentDateDay: Int   = components2.day!
        let currentDateMonth: Int = components2.month!
        var iAge = currentDateYear - brithDateYear - 1
        if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
            iAge =  iAge + 1
        }
        return iAge
    }
    
    // MARK: - 计算年龄 xx岁xx月xx天
    func getAgeStr() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        var date: DateComponents = calendar.dateComponents([.year, .month, .day], from: self, to: currentDate)
        return  "\(date.year ?? 0)岁\(date.month ?? 0)月\(date.day ?? 0)天"
    }
    
    // MARK: - 计算年龄 "3000" 天数
    func getAgeDayStr() -> String {
        let b = Date().timeIntervalSince(self)
        let age: Int = Int(b / (24 * 60 * 60))
        return String(age)
    }
}

#endif // canImport(Foundation)
