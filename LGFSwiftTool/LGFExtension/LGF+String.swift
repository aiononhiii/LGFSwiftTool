//
//  LGF+String.swift
//  LGFFreePTDemo-swift
//
//  Created by apple on 2019/7/1.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#if canImport(UIKit)
import UIKit

public enum lgf_UnitStrType {
    case lgf_SmallPinyin// 小写拼音 (q w y)
    case lgf_BigPinyin// 大写拼音 (Q W Y)
    case lgf_CCharacter// 汉字 (千 万 亿)
}

public enum lgf_UnitType {
    case lgf_OnlyQian// 只带 千 (5千 100千 100000千）
    case lgf_OnlyWan// 只带 万（0.5万 10万 10000万）
    case lgf_QianAndWan// 带 千和万 (5千 10万 10000万）
    case lgf_WanAndYi// 带 万和亿 (0.5万 10万 10000万）
    case lgf_QianAndWanAndYi// 带 千和万和亿 (5千 10万 1亿）
}

public enum lgf_TimeFormatType {
    case lgf_MS// 00:00
    case lgf_HMS// 00:00:00
    case lgf_CCharacterMS// 00分00秒
    case lgf_CCharacterHMS// 00点00分00秒
}

public extension String {
    
    // MARK: - 根据数字返回带单位字符串
    static func lgf_GetNumStrWithNum(num: Int, unitType: lgf_UnitType, unitStrType: lgf_UnitStrType) -> String {
        var str: String = ""
        if unitType == lgf_UnitType.lgf_OnlyQian {
            if num < 1000 {
                str = String.init(format: "%ld", num)
            } else {
                str = String.init(format: "%.1f%@", Float(num / 1000), unitStrType == lgf_UnitStrType.lgf_SmallPinyin ? "q" : unitStrType == lgf_UnitStrType.lgf_BigPinyin ? "Q" : "千")
            }
        } else if unitType == lgf_UnitType.lgf_OnlyWan {
            if num < 10000 {
                str = String.init(format: "%ld", num)
            } else {
                str = String.init(format: "%.1f%@", Float(num / 10000), unitStrType == lgf_UnitStrType.lgf_SmallPinyin ? "w" : unitStrType == lgf_UnitStrType.lgf_BigPinyin ? "W" : "万")
            }
        } else if unitType == lgf_UnitType.lgf_QianAndWan {
            if num < 1000 {
                str = String.init(format: "%ld", num)
            } else if num < 10000 {
                str = String.init(format: "%.1f%@", Float(num / 1000), unitStrType == lgf_UnitStrType.lgf_SmallPinyin ? "q" : unitStrType == lgf_UnitStrType.lgf_BigPinyin ? "Q" : "千")
            } else {
                str = String.init(format: "%.1f%@", Float(num / 10000), unitStrType == lgf_UnitStrType.lgf_SmallPinyin ? "w" : unitStrType == lgf_UnitStrType.lgf_BigPinyin ? "W" : "万")
            }
        } else if unitType == lgf_UnitType.lgf_WanAndYi {
            if num < 10000 {
                str = String.init(format: "%ld", num)
            } else if num < 100000000 {
                str = String.init(format: "%.1f%@", Float(num / 10000), unitStrType == lgf_UnitStrType.lgf_SmallPinyin ? "w" : unitStrType == lgf_UnitStrType.lgf_BigPinyin ? "W" : "万")
            } else {
                str = String.init(format: "%.1f%@", Float(num / 100000000), unitStrType == lgf_UnitStrType.lgf_SmallPinyin ? "y" : unitStrType == lgf_UnitStrType.lgf_BigPinyin ? "Y" : "亿")
            }
        } else if unitType == lgf_UnitType.lgf_QianAndWanAndYi {
            if num < 1000 {
                str = String.init(format: "%ld", num)
            } else if num < 10000 {
                str = String.init(format: "%.1f%@", Float(num / 1000), unitStrType == lgf_UnitStrType.lgf_SmallPinyin ? "q" : unitStrType == lgf_UnitStrType.lgf_BigPinyin ? "Q" : "千")
            } else if num < 100000000 {
                str = String.init(format: "%.1f%@", Float(num / 10000), unitStrType == lgf_UnitStrType.lgf_SmallPinyin ? "w" : unitStrType == lgf_UnitStrType.lgf_BigPinyin ? "W" : "万")
            } else {
                str = String.init(format: "%.1f%@", Float(num / 100000000), unitStrType == lgf_UnitStrType.lgf_SmallPinyin ? "y" : unitStrType == lgf_UnitStrType.lgf_BigPinyin ? "Y" : "亿")
            }
        }
        return str
    }
    
    // MARK: - 自复还是否为空
    func lgf_IsBlank() -> Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    // MARK: - 删除空字符串
    mutating func lgf_RemoveBlank() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    // MARK: -  String 是否是 number
    func lgf_IsNumber() -> Bool {
        return NumberFormatter().number(from: self) != nil ? true : false
    }
    
    // MARK: - 获取当前时间的 时间戳
    func lgf_GetNowTimeStamp() -> TimeInterval {
        let timeSp: TimeInterval = NSDate.init().timeIntervalSince1970
        debugPrint("获取当前时间的 时间戳----timeSp:", timeSp)
        return timeSp;
    }
    
    // MARK: - 获取当前时间的 时间戳字符串
    static func lgf_GetNowTimeStampStr() -> String {
        let timeSp: TimeInterval = NSDate.init().timeIntervalSince1970 * 1000
        return String(Int(timeSp))
    }
    
    // MARK: - 将某个时间戳转化成 时间字符串
    ///
    /// - Parameters:
    ///   - timeStamp: 要转换的时间戳
    ///   - format: 格式化类型
    /// - Returns: 时间字符串
    static func lgf_TimeStampSwitchTimeStr(timeStamp: String, format: String) -> String {
        if timeStamp.count == 0 {
            return ""
        }
        let formatStr = format.lgf_IsNull() ? "YYYY-MM-dd HH:mm:ss" : format
        let formatter = DateFormatter.init()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = formatStr
        let timeZone = TimeZone.current
        formatter.timeZone = timeZone
        var newTimeStamp: Int = Int(timeStamp)!
        if newTimeStamp > 1000000000 {
            newTimeStamp = newTimeStamp / 1000
        }
        let confromTimesp = Date.init(timeIntervalSince1970: TimeInterval(newTimeStamp))
        let confromTimespStr = formatter.string(from: confromTimesp)
        debugPrint("将某个时间戳转化成 时间字符串----confromTimespStr:%@", confromTimespStr)
        return confromTimespStr
    }
    
    // MARK: - 是否为空
    func lgf_IsNull() -> Bool {
        let str: String = self.trimmingCharacters(in: .whitespaces)
        if str.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Range转换为NSRange
    func lgf_NsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from!),
                       length: utf16.distance(from: from!, to: to!))
    }
    
    // MARK: - Range转换为NSRange
    func lgf_Range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length,
                                   limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    // MARK: -  base64 转 string
    init ? (base64: String) {
        let pad = String(repeating: "=", count: base64.count % 4)
        let base64Padded = base64 + pad
        if let decodedData = Data(base64Encoded: base64Padded, options: NSData.Base64DecodingOptions(rawValue: 0)), let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
            self.init(decodedString)
            return
        }
        return nil
    }
    
    // MARK: -  string 转 base64
    var base64: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    
    // MARK: - 获取字符串宽度
    func lgf_Width(_ font: UIFont, _ height: CGFloat) -> CGFloat {
        return self.lgf_TextSizeWithFont(font: font, constrainedToSize:CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: height)).width + 1.0
    }
    
    // MARK: - 获取字符串高度
    func lgf_Height(_ font: UIFont, _ width: CGFloat) -> CGFloat {
        return self.lgf_TextSizeWithFont(font: font, constrainedToSize:CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude)).height + 1.0
    }
    
    // MARK: - 获取字符串 size
    func lgf_TextSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if size.equalTo(CGSize.zero) {
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            textSize = self.size(withAttributes: attributes as? [NSAttributedString.Key : Any])
        } else {
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            let stringRect = self.boundingRect(with: size, options: option, attributes: attributes as? [NSAttributedString.Key : Any], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}

// MARK: - 国际化/本地化
public extension String {
    var lgf_Localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    func lgf_Localized(withTableName tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: self)
    }
}

// MARK: - 字符串 转 Url 如果无法转换返回 nil
public extension String {
    var lgf_Url: URL? {
        return URL(string: self)
    }
}

// MARK: - 截取某段指定位置字符串(用法见注释)
public extension String {
    // "0123456789"[0...4]  // "01234"
    // "laiguofeng"[0...4]  // "laigu"
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    // "0123456789"[2..6]  // "23456"
    // "laiguofeng"[2..6]  // "iguof"
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    // "0123456789"[1..<3]  // "12"
    // "laiguofeng"[1..<3]  // "ai"
    subscript (bounds: PartialRangeUpTo<Int>) -> String {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[startIndex..<end])
    }
    // "0123456789"[...5]  // "012345"
    // "laiguofeng"[...5]  // "laiguo"
    subscript (bounds: PartialRangeThrough<Int>) -> String {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[startIndex...end])
    }
    // "0123456789"[2...]  // "23456789"
    // "laiguofeng"[2...]  // "iguofeng"
    subscript (bounds: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        return String(self[start..<endIndex])
    }
}

public extension String {
    // MARK: - 获取去除空格分隔每个字符的字符串 "l a i g u o f e n g" -> return "laiguofeng"
    var lgf_HalfWidth: String {
        return lgf_TransformFullWidthToHalfWidth(reverse: false)
    }
    
    // MARK: - 获取空格分隔每个字符的的字符串 "laiguofeng" -> return "l a i g u o f e n g"
    var lgf_FullWidth: String {
        return lgf_TransformFullWidthToHalfWidth(reverse: true)
    }
    
    private func lgf_TransformFullWidthToHalfWidth(reverse: Bool) -> String {
        let string = NSMutableString(string: self) as CFMutableString
        CFStringTransform(string, nil, kCFStringTransformFullwidthHalfwidth, reverse)
        return string as String
    }
}

#endif // canImport(UIKit)
#endif // canImport(Foundation)
