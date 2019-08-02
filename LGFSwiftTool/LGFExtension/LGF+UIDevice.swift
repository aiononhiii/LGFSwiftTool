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
    
    // MARK: -  uuidString
    public class func uuidString() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    // MARK: - systemName
    public class func systemName() -> String {
        return UIDevice.current.systemName
    }
    
    // MARK: - systemVersion
    public class func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    // MARK: - systemVersion(float)
    public class func systemFloatVersion() -> Float {
        return (systemVersion() as NSString).floatValue
    }
    
    // MARK: - deviceName
    public class func deviceName() -> String {
        return UIDevice.current.name
    }
    
    // MARK: - device语言
    public class func deviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }
    
    // MARK: - 是否是iphone
    public class func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    // MARK: - 是否是ipad
    public class func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    // MARK: - 屏幕旋转 是否需要动画
    static public func lgf_SwitchNewOrientation(_ interfaceOrientation: UIInterfaceOrientation, animated: Bool) {
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
    static public func lgf_SwitchNewOrientation(_ interfaceOrientation: UIInterfaceOrientation) {
        let resetOrientationTarget = NSNumber.init(value: Int8(UIInterfaceOrientation.unknown.rawValue))
        UIDevice.current.setValue(resetOrientationTarget, forKey: "orientation")
        let orientationTarget = NSNumber.init(value: Int8(interfaceOrientation.rawValue))
        UIDevice.current.setValue(orientationTarget, forKey: "orientation")
    }
    
}

#endif // canImport(UIKit)
