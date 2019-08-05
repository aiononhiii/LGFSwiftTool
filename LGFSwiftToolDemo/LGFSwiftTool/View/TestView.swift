//
//  TestView.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019 来国锋. All rights reserved.
//

import UIKit

class TestView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        congifUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func congifUI() -> Void {
        let label = UILabel.init(frame: CGRect.init(x: 40, y: 40, width: self.bounds.width - 80, height: self.bounds.height - 80))
        label.text = "init(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implemented"
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.numberOfLines = 0
        self.addSubview(label)
        label.lgf_AddTap(target: self, action: #selector(click))
    }
    
    @objc func click() -> Void {
        lgf_AutoBigSmallView.lgf_IsSmall = true
    }
}
