//
//  LGF+UIDevice.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIDevice {
    
    // MARK: -  屏幕宽度
    static let lgf_ScreenW = UIScreen.main.bounds.width
    
    // MARK: -  屏幕高度
    static let lgf_ScreenH = UIScreen.main.bounds.height
    
    // MARK: -  判断是否是 IphoneX 刘海机型
    class func lgf_IsIphoneX() -> Bool {
        if (lgf_ScreenW == 375 && lgf_ScreenH == 812) || (lgf_ScreenW == 812 && lgf_ScreenH == 375) {
            return true// MARK: -  iphoneX/iphoneXS
        } else if (lgf_ScreenW == 414 && lgf_ScreenH == 896) || (lgf_ScreenW == 896 && lgf_ScreenH == 414) {
            return true// MARK: -  iphoneXR/iphoneXSMax
        } else {
            return false
        }
    }
    
    // MARK: -  判断是否是 Iphone4
    class func lgf_IsIphone4() -> Bool {
        if (lgf_ScreenW == 640 || lgf_ScreenH == 960) && (lgf_ScreenW == 960 || lgf_ScreenH == 640) {
            return true// MARK: -  iphone4
        } else {
            return false
        }
    }
    
    // MARK: -  NavigationBar 高度
    class func lgf_RealNavigationBarH() -> CGFloat {
        return lgf_IsIphoneX() ? 88.0 : 64.0
    }
    
    // MARK: -  TabBar 高度
    class func lgf_RealTabBarH() -> CGFloat {
        return lgf_IsIphoneX() ? 83.0 : 49.0
    }
    
    // MARK: -  顶部的安全距离
    class func lgf_TopSafeAreaH() -> CGFloat {
        return lgf_IsIphoneX() ? 20.0 : 0.0
    }
    
    // MARK: -  底部的安全距离
    class func lgf_BottomSafeAreaH() -> CGFloat {
        return lgf_IsIphoneX() ? 34.0 : 0.0
    }
    
    // MARK: -  375 自动 Cell 高度
    class func lgf_Iphone6Height(_ height: CGFloat) -> CGFloat {
        return (lgf_ScreenW / 375.0) * height
    }
    
    // MARK: -  电池栏小菊花
    static let lgf_NWA = UIApplication.shared.isNetworkActivityIndicatorVisible
    
    // MARK: -  uuidString
    class func lgf_UUID() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    // MARK: - systemName
    class func lgf_SystemName() -> String {
        return UIDevice.current.systemName
    }
    
    // MARK: - systemVersion
    class func lgf_SystemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    // MARK: - systemVersion(float)
    class func lgf_SystemFloatVersion() -> Float {
        return (lgf_SystemVersion() as NSString).floatValue
    }
    
    // MARK: - deviceName
    class func lgf_DeviceName() -> String {
        return UIDevice.current.name
    }
    
    // MARK: - device语言
    class func lgf_DeviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }
    
    // MARK: - 是否是iphone
    class func lgf_IsPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    // MARK: - 是否是ipad
    class func lgf_IsPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    // MARK: - 屏幕旋转 是否需要动画
    static func lgf_SwitchNewOrientation(_ interfaceOrientation: UIInterfaceOrientation, animated: Bool) {
        if animated {
            self.lgf_SwitchNewOrientation(interfaceOrientation)
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.lgf_SwitchNewOrientation(interfaceOrientation)
            CATransaction.commit()
        }
    }
    
    // MARK: - 屏幕旋转
    static func lgf_SwitchNewOrientation(_ interfaceOrientation: UIInterfaceOrientation) {
        let resetOrientationTarget = NSNumber.init(value: Int8(UIInterfaceOrientation.unknown.rawValue))
        UIDevice.current.setValue(resetOrientationTarget, forKey: "orientation")
        let orientationTarget = NSNumber.init(value: Int8(interfaceOrientation.rawValue))
        UIDevice.current.setValue(orientationTarget, forKey: "orientation")
    }
    
}

#endif // canImport(UIKit)
