//
//  LGFSwiftTool.swift
//  LGFFreePTDemo-swift
//
//  Created by apple on 2019/6/28.
//  Copyright © 2019 来国锋. All rights reserved.
//

import Foundation
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

// MARK: -  返回 RGB 颜色
func lgf_RGBColor(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat) -> UIColor {
    return lgf_RGBAColor(red, green, blue, 1.0)
}

// MARK: -  透明度 RGB 颜色
func lgf_RGBAColor(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha:CGFloat) -> UIColor {
    return UIColor.init(red:red / 255.0, green:green / 255.0, blue:blue / 255.0, alpha: alpha)
}

// MARK: -  随机颜色
func lgf_RandomColor() -> UIColor {
    return UIColor.init(red:CGFloat(Int(arc4random() % 256)) / 255.0, green:CGFloat(Int(arc4random() % 256)) / 255.0, blue:CGFloat(Int(arc4random() % 256)) / 255.0, alpha: 1.0)
}

// MARK: -  随机灰度颜色
func lgf_RandomGrayColor() -> UIColor {
    let randomNumber: CGFloat = CGFloat(Int(arc4random() % 200) + 55)
    return UIColor.init(red:randomNumber / 255.0, green:randomNumber / 255.0, blue:randomNumber / 255.0, alpha: 1.0)
}

// MARK: -  获取对应 Xib View
func lgf_GetXibView(_ nibName: String,_ owner: Any) -> UIView {
    return lgf_GetXibViewWithName(nibName, nibName, owner)
}
func lgf_GetXibViewWithName(_ nibName: String,_ bundleStr: String,_ owner: Any) -> UIView {
    return lgf_GetXibIndexViewWithName(nibName, bundleStr, owner, 0)
}
func lgf_GetXibIndexViewWithName(_ nibName: String,_ bundleStr: String,_ owner: Any,_ objectIndex: Int) -> UIView {
    return lgf_Bundle(bundleStr).loadNibNamed(nibName, owner: owner, options: nil)?[objectIndex] as! UIView
}

// MARK: -  获取对应 StoryBoard 控制器
func lgf_GetSBVC(storyboardName: String) -> UIViewController {
    return lgf_GetSBVCWithName(storyboardName, storyboardName)
}
func lgf_GetSBVCWithName(_ storyboardName: String,_ bundleName: String) -> UIViewController {
    return lgf_GetSBWithName(storyboardName, bundleName).instantiateViewController(withIdentifier: storyboardName)
}
func lgf_GetSBWithName(_ storyboardName: String,_ bundleName: String) -> UIStoryboard {
    return UIStoryboard.init(name: storyboardName, bundle: lgf_Bundle(bundleName))
}
func lgf_Bundle(_ bundleName: String) -> Bundle {
    return Bundle.init(path: Bundle.main.path(forResource: bundleName, ofType: "bundle") ?? "") ?? Bundle.main
}

// MARK: -  注册 Nib CollectionViewCell
func lgf_RegisterNibCVCell(_ collectionView: UICollectionView,_ nibName: String,_ bundleName: String) -> Void {
    collectionView.register(UINib.init(nibName: nibName, bundle: lgf_Bundle(bundleName)), forCellWithReuseIdentifier: nibName)
}

// MARK: -  初始化 CollectionViewCell
func lgf_CVGetCell(_ collectionView: UICollectionView,_ identifier: String,_ indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
}

// MARK: -  注册 Nib CollectionViewReusableView
func lgf_RegisterNibCVReusableView(_ collectionView: UICollectionView,_ nibName: String,_ kind: String,_ bundleName: String) -> Void {
    collectionView.register(UINib.init(nibName: nibName, bundle: lgf_Bundle(bundleName)), forSupplementaryViewOfKind: kind, withReuseIdentifier: nibName)
}

// MARK: -  初始化 CollectionReusableView
func lgf_CVGetReusableView(_ collectionView: UICollectionView,_ kind: String,_ identifier: String,_ indexPath: IndexPath) -> UICollectionReusableView {
    return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
}

// MARK: -  log 输出封装
func lgf_Log(_ items: Any){
    debugPrint(items)
}
