//
// LGF+UIView.swift
// LGFFreePTDemo-swift
//
// Created by apple on 2019/7/8.
// Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
    // MARK: - .x
    public var lgf_X: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    // MARK: - .y
    public var lgf_Y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    // MARK: - .maxX
    public var lgf_MaxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    // MARK: - .maxY
    public var lgf_MaxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    // MARK: - .centerX
    public var lgf_CenterX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    // MARK: - .centerY
    public var lgf_CenterY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    // MARK: - .width
    public var lgf_Width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    // MARK: - .height
    public var lgf_Height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    
    // MARK: - .size
    public var lgf_Size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
    }
    
    // MARK: - 添加单击手势
    func lgf_AddTap(target: Any?, action: Selector?) -> Void {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: target, action: action)
        self.addGestureRecognizer(tap)
    }
    
    // MARK: - 添加长按手势
    func lgf_AddLong(target: Any?, action: Selector?, duration: TimeInterval) -> Void {
        self.isUserInteractionEnabled = true
        let long = UILongPressGestureRecognizer.init(target: target, action: action)
        long.minimumPressDuration = duration
        self.addGestureRecognizer(long)
    }
    
    // MARK: - 添加轻扫手势
    func lgf_AddSwipe(target: Any?, action: Selector?, direction: UISwipeGestureRecognizer.Direction) -> Void {
        self.isUserInteractionEnabled = true
        let swipe = UISwipeGestureRecognizer.init(target: target, action: action)
        swipe.direction = direction
        self.addGestureRecognizer(swipe)
    }
    
    // MARK: -  添加拖拽手势
    func lgf_AddPan(target: Any?, action: Selector?) -> Void {
        self.isUserInteractionEnabled = true
        let pan = UIPanGestureRecognizer.init(target: target, action: action)
        self.addGestureRecognizer(pan)
    }
    
    // MARK: - 设置右边框
    public func lgf_AddRightBorder(_ width: CGFloat,_ borderColor: UIColor){
        let rect = CGRect(x: 0, y: self.frame.size.width - width, width: width, height: self.frame.size.height)
        lgf_DrawBorder(rect: rect, color: borderColor)
    }
    
    // MARK: - 设置左边框
    public func lgf_AddLeftBorder(_ width: CGFloat,_ borderColor: UIColor){
        let rect = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        lgf_DrawBorder(rect: rect, color: borderColor)
    }
    
    // MARK: - 设置上边框
    public func lgf_AddTopBorder(_ width: CGFloat,_ borderColor: UIColor){
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        lgf_DrawBorder(rect: rect, color: borderColor)
    }
    
    
    // MARK: - 设置底边框
    public func lgf_AddBottomBorder(_ width: CGFloat,_ borderColor: UIColor){
        let rect = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        lgf_DrawBorder(rect: rect, color: borderColor)
    }
    
    // MARK: - 画线
    private func lgf_DrawBorder(rect: CGRect, color: UIColor){
        let line = UIBezierPath(rect: rect)
        let lineShape = CAShapeLayer()
        lineShape.path = line.cgPath
        lineShape.fillColor = color.cgColor
        self.layer.addSublayer(lineShape)
    }
    
    // MARK: - 获取当前所在的控制器
    var lgf_ViewController: UIViewController? {
        var parent: UIResponder? = self
        while parent != nil {
            parent = parent?.next
            if let viewController = parent as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    // MARK: - 当前 view 截图
    func lgf_TakeScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: - 添加约束当前 view 占满父view
    func lgf_FillSuperview() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = superview.translatesAutoresizingMaskIntoConstraints
        if translatesAutoresizingMaskIntoConstraints {
            autoresizingMask = [.flexibleWidth, .flexibleHeight]
            frame = superview.bounds
        } else {
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        }
    }
    
}

#endif // canImport(UIKit)