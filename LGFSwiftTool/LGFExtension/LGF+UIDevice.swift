//
//  LGF+UIDevice.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public class LGF: UIDevice {}

extension LGF {
    
    // MARK: -  屏幕宽度
    static let ScreenW = UIScreen.main.bounds.width
    
    // MARK: -  屏幕高度
    static let ScreenH = UIScreen.main.bounds.height
    
    // MARK: -  判断是否是 IphoneX 刘海机型
    class func IsIphoneX() -> Bool {
        if (ScreenW == 375 && ScreenH == 812) || (ScreenW == 812 && ScreenH == 375) {
            return true// MARK: -  iphoneX/iphoneXS
        } else if (ScreenW == 414 && ScreenH == 896) || (ScreenW == 896 && ScreenH == 414) {
            return true// MARK: -  iphoneXR/iphoneXSMax
        } else {
            return false
        }
    }
    
    // MARK: -  判断是否是 Iphone4
    class func IsIphone4() -> Bool {
        if (ScreenW == 640 || ScreenH == 960) && (ScreenW == 960 || ScreenH == 640) {
            return true// MARK: -  iphone4
        } else {
            return false
        }
    }
    
    // MARK: -  NavigationBar 高度
    class func RealNavigationBarH() -> CGFloat {
        return IsIphoneX() ? 88.0 : 64.0
    }
    
    // MARK: -  TabBar 高度
    class func RealTabBarH() -> CGFloat {
        return IsIphoneX() ? 83.0 : 49.0
    }
    
    // MARK: -  顶部的安全距离
    class func TopSafeAreaH() -> CGFloat {
        return IsIphoneX() ? 20.0 : 0.0
    }
    
    // MARK: -  底部的安全距离
    class func BottomSafeAreaH() -> CGFloat {
        return IsIphoneX() ? 34.0 : 0.0
    }
    
    // MARK: -  375 自动 Cell 高度
    class func Iphone6Height(_ height: CGFloat) -> CGFloat {
        return (ScreenW / 375.0) * height
    }
    
    // MARK: -  电池栏小菊花
    static let NWA = UIApplication.shared.isNetworkActivityIndicatorVisible
    
    // MARK: -  uuidString
    class func UUID() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    // MARK: - systemName
    class func SystemName() -> String {
        return UIDevice.current.systemName
    }
    
    // MARK: - systemVersion
    class func SystemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    // MARK: - systemVersion(float)
    class func SystemFloatVersion() -> Float {
        return (SystemVersion() as NSString).floatValue
    }
    
    // MARK: - deviceName
    class func DeviceName() -> String {
        return UIDevice.current.name
    }
    
    // MARK: - device语言
    class func DeviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }
    
    // MARK: - 是否是iphone
    class func IsPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    // MARK: - 是否是ipad
    class func IsPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    // MARK: - 屏幕旋转 是否需要动画
    static func SwitchNewOrientation(_ interfaceOrientation: UIInterfaceOrientation, animated: Bool) {
        if animated {
            self.SwitchNewOrientation(interfaceOrientation)
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.SwitchNewOrientation(interfaceOrientation)
            CATransaction.commit()
        }
    }
    
    // MARK: - 屏幕旋转
    static func SwitchNewOrientation(_ interfaceOrientation: UIInterfaceOrientation) {
        let resetOrientationTarget = NSNumber.init(value: Int8(UIInterfaceOrientation.unknown.rawValue))
        UIDevice.current.setValue(resetOrientationTarget, forKey: "orientation")
        let orientationTarget = NSNumber.init(value: Int8(interfaceOrientation.rawValue))
        UIDevice.current.setValue(orientationTarget, forKey: "orientation")
    }
    
}

#endif // canImport(UIKit)
