//
//  TwoViewController.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/7/29.
//  Copyright © 2019 来国锋. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let vc = ChildViewController()
        //        vc.view.frame = self.view.bounds
        //        self.view.addSubview(vc.view)
        //        self.addChild(vc)
        //
        //        let vc2 = ChildViewController()
        //        vc2.view.frame = self.view.bounds
        //        self.view.addSubview(vc2.view)
        //        self.addChild(vc2)
        //
        //        let vc3 = ChildViewController()
        //        vc3.view.frame = self.view.bounds
        //        self.view.addSubview(vc3.view)
        //        self.addChild(vc3)
        lgf_RunTimer(self, S: 0.7) { (timer) in
//            debugPrint(123123)
        }
        
        lgf_After(S: 7.0) {
            lgf_AutoBigSmallView.lgf_Dismiss()
        }
    }
    
    deinit {
        debugPrint("\(type(of: self)) 控制器已经走 deinit 释放了")
    }
    
    @IBAction func showHView(_ sender: UIButton) {
        lgf_AutoBigSmallView.lgf_Show(smallF: CGRect.init(x: 20, y: 20, width: 100, height: 150), smaleCR: 5, isBigHorizontal: true) { (type) in
            if type == .small {
                debugPrint("准备缩小")
            } else if type == .smallFinish {
                debugPrint("缩小完毕")
            } else if type == .smallRemove {
                debugPrint("缩小删除")
            } else if type == .big {
                debugPrint("准备变大")
            } else if type == .bigFinish {
                let view = TestView.init(frame: lgf_AutoBigSmallView.bounds)
                lgf_AutoBigSmallView.addSubview(view)
                debugPrint("变大完毕")
            } else if type == .bigRemove {
                debugPrint("变大删除")
            }
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
