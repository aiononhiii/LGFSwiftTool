//
//  LGFAutoBigSmallView.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public let lgf_AutoBigSmallView = LGFAutoBigSmallView()

public enum lgf_BigSmallViewType {
    case allocFinish// 第一次初始化完成
    case small// 准备缩小
    case smallFinish// 缩小完成
    case smallRemove// 缩小删除
    case big// 准备放大
    case bigFinish// 放大完成
    case bigRemove// 放大删除
}

public enum lgf_BigSmallViewSubViewType {
    case smallView// 需要缩小的子控制器设置
    case bigView// 需要放大的子控制器设置
}

public enum lgf_BigSmallViewShowType {
    case vertical// 竖着进入
    case horizontal// 横着进入
}

public class LGFAutoBigSmallView: UIView {
    
    // 小屏 frame
    fileprivate var lgf_SmallFrame: CGRect!
    
    fileprivate var lgf_SmallCornerRadius: CGFloat!
    
    fileprivate var lgf_ShowType: lgf_BigSmallViewShowType = .vertical
    
    // 小屏触摸起始点
    var lgf_PanStartPoint: CGPoint!
    
    // 是否是小屏状态
    public var lgf_IsSmall: Bool! {
        didSet {
            if lgf_IsSmall {
                self.lgf_ToSmall()
            } else {
                self.lgf_ToBig()
            }
        }
    }
    
    // 放大后是否横屏
    public var lgf_IsBigHorizontal: Bool!
    
    // 是否横屏
    var lgf_IsHorizontal: Bool! {
        didSet {
            if lgf_IsHorizontal {
                if lgf_IsBigHorizontal {
                    UIDevice.lgf_SwitchNewOrientation(.landscapeRight, animated: false)
                    self.frame = UIApplication.shared.keyWindow!.bounds
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + (self.lgf_IsBigHorizontal ? 0.05 : 0.0)) {
                    self.lgf_FrameFinish?(.bigFinish)
                }
            } else {
                if lgf_IsBigHorizontal {
                    UIDevice.lgf_SwitchNewOrientation(.portrait, animated: false)
                    self.frame = UIApplication.shared.keyWindow!.bounds
                    self.lgf_FrameFinish?(.bigFinish)
                }
            }
        }
    }
    
    // 放大缩小是否完毕
    var lgf_FrameFinish: ((_ type: lgf_BigSmallViewType) -> Void)?
    
    // 展示放大缩小 view
    public func lgf_Show(smallF: CGRect, smaleCR: CGFloat, isBigHorizontal: Bool, showType: lgf_BigSmallViewShowType, _ frameFinish: @escaping (_ type: lgf_BigSmallViewType) -> Void) -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(lgf_ReceivedRotation), name: UIDevice.orientationDidChangeNotification, object: nil)
        self.lgf_AddPan(target: self, action: #selector(lgf_PanEvent(sender:)))
        self.lgf_AddTap(target: self, action: #selector(lgf_TapEvent(sender:)))
        frame = UIScreen.main.bounds
        backgroundColor = UIColor.black
        clipsToBounds = true
        lgf_ShowType = showType
        lgf_SmallCornerRadius = smaleCR
        lgf_SmallFrame = smallF
        lgf_IsBigHorizontal = isBigHorizontal
        lgf_FrameFinish = frameFinish
        UIApplication.shared.lgf_TopViewController?.view.addSubview(self)
        self.lgf_FillSuperview()
        self.lgf_FrameFinish?(.allocFinish)
        self.lgf_Present()
    }
    
    public func lgf_Present() -> Void {
        self.lgf_FrameFinish?(.big)
        self.lgf_SubviewsHidden(.big)
        if lgf_ShowType == .vertical {
            self.transform = CGAffineTransform.init(translationX: 0.0, y: UIApplication.shared.keyWindow!.bounds.height)
        } else {
            self.transform = CGAffineTransform.init(translationX: UIApplication.shared.keyWindow!.bounds.width, y: 0.0)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform.identity
        }) { (finish) in
            self.lgf_IsHorizontal = true
        }
    }
    
    public func addSubview(_ view: UIView, _ type: lgf_BigSmallViewSubViewType) {
        view.alpha = 0.0
        if type == .bigView {
            view.tag = 99999
        } else {
            view.tag = 11111
        }
        self.addSubview(view)
    }
    
    public func lgf_Dismiss() -> Void {
        if lgf_IsBigHorizontal != nil {
            if self.frame == UIScreen.main.bounds {
                self.lgf_FrameFinish?(.bigRemove)
                self.lgf_IsHorizontal = false
                self.lgf_Remove()
            } else {
                lgf_FrameFinish?(.smallRemove)
                lgf_Remove()
            }
        }
    }
    
    // 变小
    fileprivate func lgf_ToSmall() -> Void {
        self.lgf_FrameFinish?(.small)
        self.lgf_SubviewsHidden(.small)
        self.lgf_ShowTabBar()
        self.lgf_IsHorizontal = false
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = self.lgf_SmallFrame
            self.layer.cornerRadius = self.lgf_SmallCornerRadius
        }) { (finish) in
            self.lgf_FrameFinish?(.smallFinish)
        }
    }
    
    // 变大
    fileprivate func lgf_ToBig() -> Void {
        self.lgf_FrameFinish?(.big)
        self.lgf_SubviewsHidden(.big)
        self.lgf_HideTabBar()
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = UIApplication.shared.keyWindow!.bounds
            self.layer.cornerRadius = 0.0
        }) { (finish) in
            self.lgf_IsHorizontal = true
        }
    }
    
    // 变小后拖动
    @objc func lgf_PanEvent(sender: UIPanGestureRecognizer) {
        if self.frame != UIScreen.main.bounds {
            let translation = sender.translation(in: self)
            if sender.state == .began {
                self.superview?.bringSubviewToFront(self)
                lgf_PanStartPoint = self.center
            } else if (sender.state == .ended) || (sender.state == .cancelled) {
                let screenW = UIScreen.main.bounds.size.width
                let screenH = UIScreen.main.bounds.size.height
                let sp: CGFloat = 5.0
                UIView.animate(withDuration: 0.3, animations: {
                    if self.center.x <= screenW / 2.0 {
                        if self.center.y <= screenH / 2.0 {
                            if self.lgf_Y <= self.lgf_X {
                                self.lgf_Y = sp
                            } else {
                                self.lgf_X = sp
                            }
                        } else {
                            if (screenH - self.lgf_Height - self.lgf_Y) <= self.lgf_X {
                                self.lgf_Y = screenH - self.lgf_Height - sp
                            } else {
                                self.lgf_X = sp
                            }
                        }
                    } else {
                        if self.center.y <= screenH / 2.0 {
                            if self.lgf_Y <= (screenW - self.lgf_Width - self.lgf_X) {
                                self.lgf_Y = sp
                            } else {
                                self.lgf_X = screenW - self.lgf_Width - sp
                            }
                        } else {
                            if (screenH - self.lgf_Height - self.lgf_Y) <= (screenW - self.lgf_Width - self.lgf_X) {
                                self.lgf_Y = screenH - self.lgf_Height - sp
                            } else {
                                self.lgf_X = screenW - self.lgf_Width - sp
                            }
                        }
                    }
                    if self.lgf_X < sp {
                        self.lgf_X = sp
                    }
                    if self.lgf_Y < sp {
                        self.lgf_Y = sp
                    }
                    if screenW - self.lgf_X - self.lgf_Width < sp {
                        self.lgf_X = screenW - self.lgf_Width - sp
                    }
                    if screenH - self.lgf_Y - self.lgf_Height < sp {
                        self.lgf_Y = screenH - self.lgf_Height - sp
                    }
                }) { (finish) in
                    self.lgf_SmallFrame = self.frame
                }
            } else {
                let centerX = lgf_PanStartPoint.x + translation.x
                let centerY = lgf_PanStartPoint.y + translation.y
                self.center = CGPoint.init(x: centerX, y: centerY)
                self.lgf_SmallFrame = self.frame
            }
        }
    }
    
    @objc func lgf_TapEvent(sender:UITapGestureRecognizer) {
        if self.frame != UIScreen.main.bounds {
            self.lgf_IsSmall = false
        }
    }
    
    public func lgf_SubviewsRemove() -> Void {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    public func lgf_SubviewsHidden(_ type: lgf_BigSmallViewType) -> Void {
        self.subviews.forEach({ (view) in
            if view.tag == 99999 {
                view.alpha = type == .big ? 0.0 : 1.0
                view.alpha = type == .small ? 1.0 : 0.0
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = type == .big ? 1.0 : 0.0
                    view.alpha = type == .small ? 0.0 : 1.0
                })
            } else if view.tag == 11111 {
                view.alpha = type == .big ? 1.0 : 0.0
                view.alpha = type == .small ? 0.0 : 1.0
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = type == .big ? 0.0 : 1.0
                    view.alpha = type == .small ? 1.0 : 0.0
                })
            }
        })
    }
    
    func lgf_Remove() -> Void {
        if self.superview != nil {
            if self.frame == UIScreen.main.bounds && !self.lgf_IsBigHorizontal {
                UIView.animate(withDuration: 0.3, animations: {
                    if self.lgf_ShowType == .vertical {
                        self.transform = CGAffineTransform.init(translationX: 0.0, y: UIApplication.shared.keyWindow!.bounds.height)
                    } else {
                        self.transform = CGAffineTransform.init(translationX: UIApplication.shared.keyWindow!.bounds.width, y: 0.0)
                    }
                }) { (finish) in
                    self.transform = CGAffineTransform.identity
                    self.lgf_SubviewsRemove()
                    self.removeFromSuperview()
                    self.lgf_ShowTabBar()
                }
            } else {
                self.lgf_SubviewsRemove()
                self.removeFromSuperview()
                self.lgf_ShowTabBar()
            }
        }
    }
    
    func lgf_ShowTabBar() -> Void {
        let vc = UIViewController.lgf_GetTopVC()
        if !vc!.hidesBottomBarWhenPushed {
            (UIApplication.shared.lgf_TopViewController! as? UITabBarController)?.tabBar.isHidden = false
        }
    }
    
    func lgf_HideTabBar() -> Void {
        let vc = UIViewController.lgf_GetTopVC()
        if !vc!.hidesBottomBarWhenPushed {
            (UIApplication.shared.lgf_TopViewController! as? UITabBarController)?.tabBar.isHidden = true
        }
    }
    
    // 屏幕旋转监听
    @objc func lgf_ReceivedRotation() {
        if self.frame != UIScreen.main.bounds {
            self.frame = lgf_SmallFrame
        } else {
            self.frame = UIScreen.main.bounds
        }
    }
}

#endif // canImport(UIKit)
