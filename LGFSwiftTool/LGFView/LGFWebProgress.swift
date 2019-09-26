//
//  LGFWebProgress.swift
//  MedicalUnionHybrid
//
//  Created by 来 on 2019/9/23.
//  Copyright © 2019 EWell. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIViewController {
    func lgf_ShowWebProgress(_ top: CGFloat, _ height: CGFloat, _ hexColor: String) {
        self.view.subviews.forEach {
            if let view = $0 as? LGFWebProgress {
                view.removeFromSuperview()
            }
        }
        LGFWebProgress().lgf_Show(self.view, top, height, hexColor)
    }
    func lgf_HideWebProgress() {
        self.view.subviews.forEach {
            if let view = $0 as? LGFWebProgress {
                view.lgf_FinishLoad()
            }
        }
    }
}

class LGFWebProgress: UIView {
    var isFinishLoad: Bool!
    var progressLine: UIView!
    func lgf_Show(_ SV: UIView, _ top: CGFloat, _ height: CGFloat, _ hexColor: String) {
        DispatchQueue.main.async {
            self.frame = CGRect.init(x: 0, y: top, w: UIDevice.lgf_ScreenW, h: height)
            self.clipsToBounds = true
            self.isFinishLoad = false
            SV.addSubview(self)
            self.progressLine = UIView.init(frame: CGRect.init(x: 0, y: 0, w: 0, h: self.lgf_Height))
            self.progressLine.backgroundColor = UIColor.init(lgf_HexString: hexColor)
            self.addSubview(self.progressLine)
            self.doubleAnimate(0.8, UIDevice.lgf_ScreenW * 0.8)
        }
    }
    func doubleAnimate(_ duration: TimeInterval, _ width: CGFloat) {
        if width < UIDevice.lgf_ScreenW - 30 {
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                self.progressLine.lgf_Width = width
            }) { (finish) in
                if !self.isFinishLoad {
                    self.doubleAnimate(duration + 0.03, self.progressLine.lgf_Width + UIDevice.lgf_ScreenW * 0.005)
                }
            }
        }
    }
    func lgf_FinishLoad() {
        if !self.isFinishLoad {
            UIView.animate(withDuration: TimeInterval(0.2 + (0.8 * self.progressLine.lgf_Width / UIDevice.lgf_ScreenW)), delay: 0, options: .curveEaseInOut, animations: {
                self.progressLine.lgf_Width = UIDevice.lgf_ScreenW * 1.005
            }) { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.lgf_Height = 0.0
                }, completion: { (finish) in
                    self.removeFromSuperview()
                })
            }
        }
        self.isFinishLoad = true
    }
}

#endif // canImport(UIKit)
