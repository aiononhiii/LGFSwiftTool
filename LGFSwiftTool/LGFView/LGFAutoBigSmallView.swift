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
    case small// 准备缩小
    case smallFinish// 缩小完成
    case smallRemove// 缩小删除
    case big// 准备放大
    case bigFinish// 放大完成
    case bigRemove// 放大删除
}

public class LGFAutoBigSmallView: UIView {
    
    // 小屏 frame
    fileprivate var lgf_SmallFrame: CGRect!
    
    fileprivate var lgf_SmallCornerRadius: CGFloat!
    
    // 小屏触摸起始点
    var lgf_PanStartPoint: CGPoint!
    
    // 是否是小屏状态
    var lgf_IsSmall: Bool! {
        didSet {
            if lgf_IsSmall {
                self.lgf_ToSmall()
            } else {
                self.lgf_ToBig()
            }
        }
    }
    
    // 放大后是否横屏
    var lgf_IsBigHorizontal: Bool!
    
    // 是否横屏
    var lgf_IsHorizontal: Bool! {
        didSet {
            if lgf_IsHorizontal {
                if lgf_IsBigHorizontal {
                    UIDevice.lgf_SwitchNewOrientation(.landscapeRight, animated: false)
                    self.frame = UIApplication.shared.keyWindow!.bounds
                }
                lgf_FrameFinish?(.big)
                DispatchQueue.main.asyncAfter(deadline: .now() + (self.lgf_IsBigHorizontal ? 0.05 : 0.0)) {
                    self.lgf_FrameFinish?(.bigFinish)
                }
            } else {
                if lgf_IsBigHorizontal {
                    UIDevice.lgf_SwitchNewOrientation(.portrait, animated: false)
                    self.frame = UIApplication.shared.keyWindow!.bounds
                }
            }
        }
    }
    
    // 放大缩小是否完毕
    var lgf_FrameFinish: ((_ type: lgf_BigSmallViewType) -> Void)?
    
    // 展示放大缩小 view
    func lgf_Show(smallF: CGRect, smaleCR: CGFloat, isBigHorizontal: Bool, _ frameFinish: @escaping (_ type: lgf_BigSmallViewType) -> Void) -> Void {
        self.lgf_AddPan(target: self, action: #selector(lgf_PanEvent(sender:)))
        self.lgf_AddTap(target: self, action: #selector(lgf_TapEvent(sender:)))
        frame = UIApplication.shared.keyWindow!.bounds
        backgroundColor = UIColor.black
        lgf_SmallCornerRadius = smaleCR
        lgf_SmallFrame = smallF
        lgf_IsBigHorizontal = isBigHorizontal
        lgf_FrameFinish = frameFinish
        UIApplication.shared.keyWindow?.addSubview(self)
        lgf_Present()
    }
    
    func lgf_Present() -> Void {
        transform = CGAffineTransform.init(translationX: UIApplication.shared.keyWindow!.bounds.width, y: 0.0)
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform.identity
        }) { (finish) in
            self.lgf_IsHorizontal = true
        }
    }
    
    func lgf_Dismiss() -> Void {
        if self.frame == self.lgf_SmallFrame {
            lgf_FrameFinish?(.smallRemove)
            lgf_Remove()
        } else {
            self.lgf_IsHorizontal = false
            self.subviews.forEach { $0.removeFromSuperview() }
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CGAffineTransform.init(translationX: UIApplication.shared.keyWindow!.bounds.width, y: 0.0)
            }) { (finish) in
                self.transform = CGAffineTransform.identity
                self.lgf_FrameFinish?(.bigRemove)
                self.lgf_Remove()
            }
        }
    }
    
    // 变小
    fileprivate func lgf_ToSmall() -> Void {
        self.lgf_IsHorizontal = false
        lgf_FrameFinish?(.small)
        self.subviews.forEach { $0.removeFromSuperview() }
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = self.lgf_SmallFrame
            self.layer.cornerRadius = self.lgf_SmallCornerRadius
        }) { (finish) in
            self.lgf_FrameFinish?(.smallFinish)
        }
    }
    
    // 变大
    fileprivate func lgf_ToBig() -> Void {
        self.subviews.forEach { $0.removeFromSuperview() }
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = UIApplication.shared.keyWindow!.bounds
            self.layer.cornerRadius = 0.0
        }) { (finish) in
            self.lgf_IsHorizontal = true
        }
    }
    
    // 变小后拖动
    @objc func lgf_PanEvent(sender: UIPanGestureRecognizer) {
        if self.frame == self.lgf_SmallFrame {
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
        if self.frame == self.lgf_SmallFrame {
            self.lgf_IsSmall = false
        }
    }
    
    func lgf_Remove() -> Void {
        if self.superview != nil {
            self.subviews.forEach { $0.removeFromSuperview() }
            self.removeFromSuperview()
        }
    }
    
}

#endif // canImport(UIKit)
