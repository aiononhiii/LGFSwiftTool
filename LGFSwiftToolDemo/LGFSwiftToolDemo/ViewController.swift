//
//  ViewController.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/7/29.
//  Copyright © 2019 来国锋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var lgf_Titles: [String] = ["111"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let (r, g, b, a) = UIColor.darkGray.components.rgba
        
        lgf_Titles = ["7", "8", "9"]
        debugPrint(String.init(format: "当前选中:%@(%tu), 当前未选中:%@(%tu)", "22", 555,  "33", 444))
    }
}

