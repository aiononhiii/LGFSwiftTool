//
//  TestViewTwo.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/5.
//  Copyright © 2019 来国锋. All rights reserved.
//

import UIKit

class TestViewTwo: UIView {

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
        label.text = "111232534554512325345545123253455451"
        label.backgroundColor = UIColor.blue
        label.textColor = UIColor.white
        label.numberOfLines = 0
        self.addSubview(label)
        label.lgf_AddTap(target: self, action: #selector(click))
        label.lgf_FillSuperview()
    }
    
    @objc func click() -> Void {
        lgf_AutoBigSmallView.lgf_IsSmall = false
    }

}
