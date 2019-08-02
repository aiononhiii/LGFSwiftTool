//
//  LGFAutoBigSmallView.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019 来国锋. All rights reserved.
//

import UIKit

let lgf_AutoBigSmallView = LGFAutoBigSmallView()

class LGFAutoBigSmallView: UIView {
    
    // 小屏 frame
    fileprivate var lgf_SmallFrame: CGRect!
    
    fileprivate var lgf_SmallCornerRadius: CGFloat!
    
    // 小屏触摸起始点
    var lgf_PanStartPoint: CGPoint!
    
    // 是否是小屏状态
    var lgf_IsSmall: Bool! {
        didSet {
            if lgf_IsSmall {
                self.lgf_ToBig()
            } else {
                self.lgf_ToSmall()
            }
        }
    }
    
    // 放大后是否横屏
    var lgf_IsBigHorizontal: Bool!
    
    // 是否横屏
    var lgf_IsHorizontal: Bool! {
        didSet {
            if lgf_IsHorizontal {
                if self.lgf_IsBigHorizontal {
                    UIDevice.lgf_SwitchNewOrientation(.landscapeRight, animated: false)
                    self.frame = UIApplication.shared.keyWindow!.bounds
                }
            } else {
                if lgf_IsBigHorizontal {
                    UIDevice.lgf_SwitchNewOrientation(.portrait, animated: false)
                }
            }
        }
    }
    
    // 放大缩小是否完毕
    var lgf_FrameFinish: ((_ isSmall: Bool) -> Void)?
    
    // 展示放大缩小 view
    func lgf_Show(smallF: CGRect, smaleCR: CGFloat, isBigHorizontal: Bool, _ frameFinish: @escaping (_ isSmall: Bool) -> Void) -> Void {
        self.lgf_AddPan(target: self, action: #selector(lgf_PanEvent(sender:)))
        self.lgf_AddTap(target: self, action: #selector(lgf_TapEvent(sender:)))
        frame = UIApplication.shared.keyWindow!.bounds
        backgroundColor = UIColor.black
        lgf_SmallCornerRadius = smaleCR
        lgf_SmallFrame = smallF
        lgf_IsBigHorizontal = isBigHorizontal
        lgf_FrameFinish = frameFinish
        UIApplication.shared.keyWindow?.addSubview(self)
        transform = CGAffineTransform.init(translationX: UIApplication.shared.keyWindow!.bounds.width, y: 0.0)
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform.identity
        }) { (finish) in
            self.lgf_IsHorizontal = true
            DispatchQueue.main.asyncAfter(deadline: .now() + (self.lgf_IsBigHorizontal ? 0.03 : 0.0)) {
                self.lgf_FrameFinish?(false)
            }
        }
    }
    
    
    
    // 变小
    fileprivate func lgf_ToSmall() -> Void {
        self.lgf_IsHorizontal = false
        lgf_AutoBigSmallView.subviews.forEach { $0.removeFromSuperview() }
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = self.lgf_SmallFrame
            self.layer.cornerRadius = self.lgf_SmallCornerRadius
        }) { (finish) in
            self.lgf_FrameFinish?(true)
        }
    }
    
    
    // 变大
    fileprivate func lgf_ToBig() -> Void {
        lgf_AutoBigSmallView.subviews.forEach { $0.removeFromSuperview() }
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = UIApplication.shared.keyWindow!.bounds
            self.layer.cornerRadius = 0.0
        }) { (finish) in
            self.lgf_IsHorizontal = true
            DispatchQueue.main.asyncAfter(deadline: .now() + (self.lgf_IsBigHorizontal ? 0.03 : 0.0)) {
                self.lgf_FrameFinish?(false)
            }
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
        self.lgf_IsSmall = self.frame == self.lgf_SmallFrame
    }
    
    func lgf_Remove() -> Void {
        lgf_AutoBigSmallView.subviews.forEach { $0.removeFromSuperview() }
        self.removeFromSuperview()
    }
    
}
