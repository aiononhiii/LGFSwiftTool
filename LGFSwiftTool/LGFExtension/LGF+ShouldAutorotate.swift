//
//  LGF+ShouldAutorotate.swift
//  LGFSwiftTool
//
//  Created by 来 on 2019/10/8.
//  Copyright © 2019 来国锋. All rights reserved.
//

import UIKit

class LGF_ShouldAutorotate: NSObject {
    // true 可旋转, false 不可旋转
    var lgf_IsShouldAutorotate: Bool!
    
    var lgf_IsCanLandscapeRight: Bool!
    
    static let lgf = LGF_ShouldAutorotate()
    private override init() {
        lgf_IsShouldAutorotate = lgf_IsShouldAutorotate ?? false
        lgf_IsCanLandscapeRight = lgf_IsCanLandscapeRight ?? false
    }
    
    // 全局屏幕旋转设置在 MainVC 的 shouldAutorotate 方法里体现
    // 在需要屏幕旋转的 VC 里面改变其值，View 同理
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        LGF_ShouldAutorotate.lgf.lgf_IsShouldAutorotate = true
    //    }
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        LGF_ShouldAutorotate.lgf.lgf_IsShouldAutorotate = false
    //    }
    //    // 在 tabbarvc 添加横竖屏控制
    //    override var shouldAutorotate: Bool {
    //        return true
    //    }
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        if LGF_ShouldAutorotate.lgf.lgf_IsShouldAutorotate {
    //            return .landscapeRight
    //        } else {
    //            return .portrait
    //        }
    //    }
}
