//
//  TestView.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019 来国锋. All rights reserved.
//

import UIKit

class TestView: UIView {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        congifUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func congifUI() -> Void {
        label = UILabel.init(frame: CGRect.zero)
        label.text = "init(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implemented"
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.numberOfLines = 0
        self.addSubview(label)
        label.lgf_AddTap(target: self, action: #selector(click))
        label.lgf_FillSuperview()
        lgf_After(S: 2.0) {
            let alertVC = UIAlertController.init(title: "提示", message: "视频通话已结束,如有需要请重新连接", preferredStyle: .alert)
            let confirmAction1 = UIAlertAction.init(title: "否", style: .default) { (action) in
            }
            let confirmAction2 = UIAlertAction.init(title: "是", style: .default) { (action) in
            }
            alertVC.addAction(confirmAction1)
            alertVC.addAction(confirmAction2)
            UIApplication.shared.lgf_TopViewController!.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @objc func click() -> Void {
        lgf_AutoBigSmallView.lgf_IsSmall = true
    }
}
