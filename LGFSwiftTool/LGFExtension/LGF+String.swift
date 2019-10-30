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
    
    // MARK: - 对象 转 json
    static func lgf_JsonFrom(_ obj: Any) -> String {
        if (!JSONSerialization.isValidJSONObject(obj)) {
            print("无法解析出JSONString")
            return ""
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: [])
            return String(data: jsonData, encoding: .utf8) ?? ""
        } catch { }
        return ""
    }
    
    // MARK: - json 转字典
    func lgf_ToDictionary() -> [String: Any] {
        let result = [String: Any]()
        if let jsonData = self.data(using: String.Encoding.utf8) {
            do {
                if let jsonDic = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
                    return jsonDic
                }
            } catch {
                debugPrint("ERROR: Invalid json!")
            }
        }
        return result
    }
    
    // MARK: - json 转数组
    func lgf_ToDictionaryArray() -> [[String: Any]] {
        let result = [[String: Any]]()
        if let jsonData = self.data(using: String.Encoding.utf8) {
            do {
                if let jsonDic = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]] {
                    return jsonDic
                }
            } catch {
                debugPrint("ERROR: Invalid json!")
            }
        }
        return result
    }
    
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
        if timeStamp.count == 0 || Int(timeStamp) == nil {
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

// MARK: - 正则表达式
public extension String {
    /**
     1、匹配中文:[\u4e00-\u9fa5]
     
     2、英文字母:[a-zA-Z]
     
     3、数字:[0-9]
     
     4、匹配中文，英文字母和数字及下划线：^[\u4e00-\u9fa5_a-zA-Z0-9]+$
     同时判断输入长度：
     [\u4e00-\u9fa5_a-zA-Z0-9_]{4,10}
     
     5、
     (?!_)　　不能以_开头
     (?!.*?_$)　　不能以_结尾
     [a-zA-Z0-9_\u4e00-\u9fa5]+　　至少一个汉字、数字、字母、下划线
     $　　与字符串结束的地方匹配
     
     6、只含有汉字、数字、字母、下划线，下划线位置不限：
     ^[a-zA-Z0-9_\u4e00-\u9fa5]+$
     
     7、由数字、26个英文字母或者下划线组成的字符串
     ^\w+$
     
     8、2~4个汉字
     "^[\u4E00-\u9FA5]{2,4}$";
     
     9、最长不得超过7个汉字，或14个字节(数字，字母和下划线)正则表达式
     ^[\u4e00-\u9fa5]{1,7}$|^[\dA-Za-z_]{1,14}$
     
     
     10、匹配双字节字符(包括汉字在内)：[^x00-xff]
     评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）
     
     11、匹配空白行的正则表达式：ns*r
     评注：可以用来删除空白行
     
     12、匹配HTML标记的正则表达式：<(S*?)[^>]*>.*?|<.*? />
     评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧无能为力
     
     13、匹配首尾空白字符的正则表达式：^s*|s*$
     评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
     
     14、匹配Email地址的正则表达式：^[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$
     
     评注：表单验证时很实用
     
     15、手机号：^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\d{8}$
     
     16、身份证：(^\d{15}$)|(^\d{17}([0-9]|X|x)$)
     
     17、匹配网址URL的正则表达式：[a-zA-z]+://[^s]*
     评注：网上流传的版本功能很有限，上面这个基本可以满足需求
     
     18、匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
     评注：表单验证时很实用
     
     
     19、匹配国内电话号码：d{3}-d{8}|d{4}-d{7}
     评注：匹配形式如 0511-4405222 或 021-87888822
     
     20、匹配腾讯QQ号：[1-9][0-9]{4,}
     评注：腾讯QQ号从10000开始
     
     21、匹配中国邮政编码：[1-9]d{5}(?!d)
     评注：中国邮政编码为6位数字
     
     22、匹配身份证：d{15}|d{18}
     评注：中国的身份证为15位或18位
     
     23、匹配ip地址：d+.d+.d+.d+
     评注：提取ip地址时有用
     
     
     24、匹配特定数字：
     ^[1-9]d*$　 　 //匹配正整数
     ^-[1-9]d*$ 　 //匹配负整数
     ^-?[1-9]d*$　　 //匹配整数
     ^[1-9]d*|0$　 //匹配非负整数（正整数 + 0）
     ^-[1-9]d*|0$　　 //匹配非正整数（负整数 + 0）
     ^[1-9]d*.d*|0.d*[1-9]d*$　　 //匹配正浮点数
     ^-([1-9]d*.d*|0.d*[1-9]d*)$　 //匹配负浮点数
     ^-?([1-9]d*.d*|0.d*[1-9]d*|0?.0+|0)$　 //匹配浮点数
     ^[1-9]d*.d*|0.d*[1-9]d*|0?.0+|0$　　 //匹配非负浮点数（正浮点数 + 0）
     ^(-([1-9]d*.d*|0.d*[1-9]d*))|0?.0+|0$　　//匹配非正浮点数（负浮点数 + 0）
     评注：处理大量数据时有用，具体应用时注意修正
     
     
     25、匹配特定字符串：
     ^[A-Za-z]+$　　//匹配由26个英文字母组成的字符串
     ^[A-Z]+$　　//匹配由26个英文字母的大写组成的字符串
     ^[a-z]+$　　//匹配由26个英文字母的小写组成的字符串
     ^[A-Za-z0-9]+$　　//匹配由数字和26个英文字母组成的字符串
     ^w+$　　//匹配由数字、26个英文字母或者下划线组成的字符串
     
     26、
     在使用RegularExpressionValidator验证控件时的验证功能及其验证表达式介绍如下:
     只能输入数字：“^[0-9]*$”
     只能输入n位的数字：“^d{n}$”
     只能输入至少n位数字：“^d{n,}$”
     只能输入m-n位的数字：“^d{m,n}$”
     只能输入零和非零开头的数字：“^(0|[1-9][0-9]*)$”
     只能输入有两位小数的正实数：“^[0-9]+(.[0-9]{2})?$”
     只能输入有1-3位小数的正实数：“^[0-9]+(.[0-9]{1,3})?$”
     只能输入非零的正整数：“^+?[1-9][0-9]*$”
     只能输入非零的负整数：“^-[1-9][0-9]*$”
     只能输入长度为3的字符：“^.{3}$”
     只能输入由26个英文字母组成的字符串：“^[A-Za-z]+$”
     只能输入由26个大写英文字母组成的字符串：“^[A-Z]+$”
     只能输入由26个小写英文字母组成的字符串：“^[a-z]+$”
     只能输入由数字和26个英文字母组成的字符串：“^[A-Za-z0-9]+$”
     只能输入由数字、26个英文字母或者下划线组成的字符串：“^w+$”
     验证用户密码:“^[a-zA-Z]w{5,17}$”正确格式为：以字母开头，长度在6-18之间，
     只能包含字符、数字和下划线。
     验证是否含有^%&',;=?$"等字符：“[^%&',;=?$x22]+”
     只能输入汉字：“^[u4e00-u9fa5],{0,}$”
     验证Email地址：“^w+[-+.]w+)*@w+([-.]w+)*.w+([-.]w+)*$”
     验证InternetURL：“^http://([w-]+.)+[w-]+(/[w-./?%&=]*)?$”
     验证身份证号（15位或18位数字）：“^d{15}|d{}18$”
     验证一年的12个月：“^(0?[1-9]|1[0-2])$”正确格式为：“01”-“09”和“1”“12”
     验证一个月的31天：“^((0?[1-9])|((1|2)[0-9])|30|31)$”
     正确格式为：“01”“09”和“1”“31”。
     匹配中文字符的正则表达式： [u4e00-u9fa5]
     匹配双字节字符(包括汉字在内)：[^x00-xff]
     匹配空行的正则表达式：n[s| ]*r
     匹配HTML标记的正则表达式：/<(.*)>.*|<(.*) />/
     匹配首尾空格的正则表达式：(^s*)|(s*$)
     匹配Email地址的正则表达式：w+([-+.]w+)*@w+([-.]w+)*.w+([-.]w+)*
     匹配网址URL的正则表达式：http://([w-]+.)+[w-]+(/[w- ./?%&=]*)?
     */
    func lgf_NSPredicate(_ reg: String) -> Bool {
        let pre = NSPredicate(format: "SELF MATCHES %@", reg)
        if pre.evaluate(with: self) {
            return true
        } else {
            return false
        }
    }
}

#endif // canImport(UIKit)
#endif // canImport(Foundation)
