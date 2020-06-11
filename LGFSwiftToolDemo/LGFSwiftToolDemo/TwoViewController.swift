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
        
        // 发起按钮
        let centerBtn = UIButton.init(type: .custom)
        
//        img.size = CGSize.init(width: 20, height: 20)
        if #available(iOS 10.0, *) {
            centerBtn.setImage(UIImage.init(color: UIColor.red, size: CGSize.init(width: 10, height: 10)), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        centerBtn.setTitle("业务", for: .normal)
        centerBtn.backgroundColor = UIColor.lightGray
        centerBtn.setTitleColor(UIColor.black, for: .normal)
        centerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(centerBtn)
        centerBtn.frame = CGRect.init(x: 300, y: 300, w: 50, h: 50)
        centerBtn.lgf_ImagePosition(at: .top, space: 5)
        
        
        let fff = "1591839235323".lgf_TimeStampToDate().lgf_TimeStampString()
        
        
    }
    
    deinit {
        debugPrint("\(type(of: self)) 控制器已经走 deinit 释放了")
    }
    
    @IBAction func showHView(_ sender: UIButton) {
        lgf_AutoBigSmallView.lgf_Show(smallF: CGRect.init(x: 20, y: 20, width: 100, height: 150), smaleCR: 5, isBigHorizontal: true, showType: .horizontal) { (type) in
            if type == .small {
                debugPrint("准备缩小")
            } else if type == .smallFinish {
                let smallview = TestViewTwo.init()
                lgf_AutoBigSmallView.addSubview(smallview)
                smallview.lgf_FillSuperview()
                debugPrint("缩小完毕")
            } else if type == .smallRemove {
                debugPrint("缩小删除")
            } else if type == .big {
                debugPrint("准备变大")
            } else if type == .bigFinish {
                let bigview = TestView.init()
                lgf_AutoBigSmallView.addSubview(bigview)
                bigview.lgf_FillSuperview()
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
