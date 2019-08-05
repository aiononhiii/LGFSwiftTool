//
//  LGFPCHTool.swift
//  LGFFreePTDemo-swift
//
//  Created by apple on 2019/6/28.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#if canImport(UIKit)
import UIKit

// MARK: -  当前系统版本
let lgf_Version = (UIDevice.current.systemVersion as NSString).floatValue

// MARK: -  屏幕宽度
let lgf_ScreenW = UIScreen.main.bounds.width

// MARK: -  屏幕高度
let lgf_ScreenH = UIScreen.main.bounds.height

// MARK: -  UUID
let lgf_UUID = UIDevice.current.identifierForVendor?.uuidString

// MARK: -  电池栏小菊花
let lgf_NWA = UIApplication.shared.isNetworkActivityIndicatorVisible

// MARK: -  获取控件相对于屏幕 Rect
func lgf_GetWindowRect(_ view: UIView) -> CGRect {
    return view.convert(view.bounds, to: UIApplication.shared.windows.first)
}

// MARK: -  NavigationBar 高度
func lgf_RealNavigationBarH() -> CGFloat {
    return lgf_IsIphoneX() ? 88.0 : 64.0
}

// MARK: -  TabBar 高度
func lgf_RealTabBarH() -> CGFloat {
    return lgf_IsIphoneX() ? 83.0 : 49.0
}

// MARK: -  顶部的安全距离
func lgf_TopSafeAreaH() -> CGFloat {
    return lgf_IsIphoneX() ? 20.0 : 0.0
}

// MARK: -  底部的安全距离
func lgf_BottomSafeAreaH() -> CGFloat {
    return lgf_IsIphoneX() ? 34.0 : 0.0
}

// MARK: -  返回 size 的 UIFont
func lgf_Font(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

// MARK: -  返回 size 的 粗体UIFont
func lgf_BoldFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

// MARK: -  获取横向滚动index
func lgf_ScrollHorizontalIndex(_ scrollView: UIScrollView) -> Int {
    return Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
}

// MARK: -  获取竖向滚动index
func lgf_ScrollVerticalIndex(_ scrollView: UIScrollView) -> Int {
    return Int(scrollView.contentOffset.y / scrollView.bounds.size.height)
}

// MARK: -  判断是否是 IphoneX 刘海机型
func lgf_IsIphoneX() -> Bool {
    if (lgf_ScreenW == 375 && lgf_ScreenH == 812) || (lgf_ScreenW == 812 && lgf_ScreenH == 375) {
        return true// MARK: -  iphoneX/iphoneXS
    } else if (lgf_ScreenW == 414 && lgf_ScreenH == 896) || (lgf_ScreenW == 896 && lgf_ScreenH == 414) {
        return true// MARK: -  iphoneXR/iphoneXSMax
    } else {
        return false
    }
}

// MARK: -  判断是否是 Iphone4
func lgf_IsIphone4() -> Bool {
    if (lgf_ScreenW == 640 || lgf_ScreenH == 960) && (lgf_ScreenW == 960 || lgf_ScreenH == 640) {
        return true// MARK: -  iphone4
    } else {
        return false
    }
}

// MARK: -  375 自动 Cell 高度
func lgf_Iphone6Height(_ height: CGFloat) -> CGFloat {
    return (lgf_ScreenW / 375.0) * height
}

// MARK: -  随机颜色
func lgf_RandomColor() -> UIColor {
    return UIColor.init(Int(arc4random() % 256 / 255), Int(arc4random() % 256 / 255), Int(arc4random() % 256 / 255))
}

// MARK: -  随机灰度颜色
func lgf_RandomGrayColor() -> UIColor {
    let randomNumber = (Int(arc4random() % 200) + 55) / 255
    return UIColor.init(randomNumber, randomNumber, randomNumber)
}

// MARK: -  log 输出封装
func lgf_Log(_ items: Any){
    debugPrint(items)
}

#endif // canImport(UIKit)

#endif // canImport(Foundation)
