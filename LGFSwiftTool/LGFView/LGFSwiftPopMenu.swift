//
//  LGFSwiftPopMenu.swift
//  MedicalUnionHybrid
//
//  Created by 来 on 2019/9/28.
//  Copyright © 2019 EWell. All rights reserved.
//

import UIKit

enum lgf_SwiftPopMenuDirection {
    case top
    case bottom
    case left
    case right
}
class LGFSwiftPopMenuStyle: NSObject {
    class func lgf() -> LGFSwiftPopMenuStyle {
        let style = LGFSwiftPopMenuStyle()
        style.lgf_SwiftPopFromView = UIApplication.shared.keyWindow
        style.lgf_SwiftPopMenuView = UIView()
        style.lgf_Arbitrarily = nil
        style.lgf_SwiftPopMenuDirection = .bottom
        style.lgf_SwiftPopArrowOffset = 0.0
        style.lgf_SwiftPopArrowCenter = 0.0
        style.lgf_SwiftPopMenuCenter = 0.0
        style.lgf_SwiftPopArrowSize = CGSize.init(width: 10.0, height: 10.0)
        style.lgf_SwiftPopMenuSize = CGSize.init(width: 100.0, height: 100.0)
        style.lgf_SwiftPopAbsoluteRect = .zero
        style.lgf_SwiftPopMenuViewbackColor = UIColor.white
        style.lgf_SwiftPopMenuViewShadowOpacity = 0.0
        return style
    }
    /**
     用于记录/传入/保存(tag,indexpath...)任意值 备注：该值会在 LGFSwiftPopMenu 走 DidDismiss 时回调出去
     */
    var lgf_Arbitrarily: AnyObject!
    /**
     菜单方向
     */
    var lgf_SwiftPopMenuDirection: lgf_SwiftPopMenuDirection = .bottom
    /**
     菜单 view
     */
    var lgf_SwiftPopMenuView: UIView!
    /**
     菜单弹出 view
     */
    weak var lgf_SwiftPopFromView: UIView! {
        didSet {
            lgf_SwiftPopAbsoluteRect = lgf_SwiftPopFromView.convert(lgf_SwiftPopFromView.bounds, to: UIApplication.shared.keyWindow)
        }
    }
    /**
     菜单大小
     */
    var lgf_SwiftPopMenuSize: CGSize!
    /**
     箭头大小
     */
    var lgf_SwiftPopArrowSize: CGSize!
    /**
     箭头相对于菜单 Center 位置
     */
    var lgf_SwiftPopArrowCenter: CGFloat!
    /**
     PopMenu相对于 PopFromView Center 位置
     */
    var lgf_SwiftPopMenuCenter: CGFloat!
    /**
     箭头尖尖相对于 lgf_SwiftPopFromView 的距离
     */
    var lgf_SwiftPopArrowOffset: CGFloat!
    /**
     绝对位置
     */
    var lgf_SwiftPopAbsoluteRect: CGRect!
    /**
     背景色
     */
    var lgf_SwiftPopMenuViewbackColor: UIColor!
    /**
     阴影透明度
     */
    var lgf_SwiftPopMenuViewShadowOpacity: Float!
}

class LGFSwiftPopArrow: UIView {
    weak var lgf_Style: LGFSwiftPopMenuStyle!
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath.init()
        switch lgf_Style.lgf_SwiftPopMenuDirection {
        case .top:
            path.move(to: CGPoint.init(x: 0.0, y: 0.0))
            path.addLine(to: CGPoint.init(x: rect.size.width / 2.0, y: rect.size.height))
            path.addLine(to: CGPoint.init(x: rect.size.width, y: 0.0))
        case .bottom:
            path.move(to: CGPoint.init(x: 0.0, y: rect.size.height))
            path.addLine(to: CGPoint.init(x: rect.size.width / 2.0, y: 0.0))
            path.addLine(to: CGPoint.init(x: rect.size.width, y: rect.size.height))
        case .left:
            path.move(to: CGPoint.init(x: 0.0, y: 0.0))
            path.addLine(to: CGPoint.init(x: rect.size.width, y: rect.size.height / 2.0))
            path.addLine(to: CGPoint.init(x: 0.0, y: rect.size.height))
        case .right:
            path.move(to: CGPoint.init(x: rect.size.width, y: 0.0))
            path.addLine(to: CGPoint.init(x: 0.0, y: rect.size.height / 2.0))
            path.addLine(to: CGPoint.init(x: rect.size.width, y: rect.size.height))
        }
        lgf_Style.lgf_SwiftPopMenuViewbackColor.setFill()
        path.fill()
    }
}


protocol LGFSwiftPopMenuDelegate: class {
    func lgf_SwiftPopMenuWillDismiss(_ pop: LGFSwiftPopMenu)
    func lgf_SwiftPopMenuWillShow(_ pop: LGFSwiftPopMenu)
    func lgf_SwiftPopMenuDidDismiss(_ pop: LGFSwiftPopMenu)
    func lgf_SwiftPopMenuDidShow(_ pop: LGFSwiftPopMenu)
}
class LGFSwiftPopMenu: UIView {
    
    weak var delegate: LGFSwiftPopMenuDelegate?
    
    static let lgf = LGFSwiftPopMenu.init(frame: UIApplication.shared.keyWindow!.bounds)
    private override init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.init(width: 0.0, height: -0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var lgf_SwiftPopMenuWillDismiss: ((LGFSwiftPopMenu) -> Void)?
    var lgf_SwiftPopMenuWillShow: ((LGFSwiftPopMenu) -> Void)?
    var lgf_SwiftPopMenuDidDismiss: ((LGFSwiftPopMenu) -> Void)?
    var lgf_SwiftPopMenuDidShow: ((LGFSwiftPopMenu) -> Void)?
    
    weak var lgf_Style: LGFSwiftPopMenuStyle!
    var lgf_ArrowView: LGFSwiftPopArrow = {
        let view = LGFSwiftPopArrow.init()
        view.backgroundColor = UIColor.clear
        return view
    }()
    lazy var lgf_MenuBackView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    /**
     显示 pop 菜单
     style LGFSwiftPopMenu 配置信息 / willShow 将要显示 didShow 已经显示 willDismiss 将要隐藏 didDismiss 已经隐藏
     */
    func lgf_ShowMenu(_ style: LGFSwiftPopMenuStyle) {
        lgf_Style = style
        lgf_ArrowView.lgf_Style = style
        lgf_Style.lgf_SwiftPopMenuView.backgroundColor = lgf_Style.lgf_SwiftPopMenuViewbackColor
        layer.shadowOpacity = lgf_Style.lgf_SwiftPopMenuViewShadowOpacity
        UIApplication.shared.keyWindow?.addSubview(self)
        self.delegate?.lgf_SwiftPopMenuWillShow(self)
        if lgf_Style.lgf_SwiftPopMenuDirection == .top {
            lgf_MenuBackView.frame = CGRect.init(x: lgf_Style.lgf_SwiftPopAbsoluteRect.origin.x - ((lgf_Style.lgf_SwiftPopMenuSize.width - lgf_Style.lgf_SwiftPopAbsoluteRect.size.width) / 2.0) + lgf_Style.lgf_SwiftPopMenuCenter, y: lgf_Style.lgf_SwiftPopAbsoluteRect.origin.y - lgf_Style.lgf_SwiftPopArrowSize.height - lgf_Style.lgf_SwiftPopMenuSize.height - lgf_Style.lgf_SwiftPopArrowOffset, w: lgf_Style.lgf_SwiftPopMenuSize.width, h: lgf_Style.lgf_SwiftPopMenuSize.height + lgf_Style.lgf_SwiftPopArrowSize.height)
            
            lgf_Style.lgf_SwiftPopMenuView.frame = CGRect.init(x: 0.0, y: 0.0, w: lgf_Style.lgf_SwiftPopMenuSize.width, h: lgf_Style.lgf_SwiftPopMenuSize.height)
            
            lgf_ArrowView.frame = CGRect.init(x: (lgf_Style.lgf_SwiftPopMenuView.frame.size.width / 2.0) - (lgf_Style.lgf_SwiftPopArrowSize.width / 2) - lgf_Style.lgf_SwiftPopArrowCenter, y: lgf_Style.lgf_SwiftPopMenuSize.height - 0.5, w: lgf_Style.lgf_SwiftPopArrowSize.width, h: lgf_Style.lgf_SwiftPopArrowSize.height)
        } else if lgf_Style.lgf_SwiftPopMenuDirection == .bottom {
            lgf_MenuBackView.frame = CGRect.init(x: lgf_Style.lgf_SwiftPopAbsoluteRect.origin.x - ((lgf_Style.lgf_SwiftPopMenuSize.width - lgf_Style.lgf_SwiftPopAbsoluteRect.size.width) / 2.0) + lgf_Style.lgf_SwiftPopMenuCenter, y: lgf_Style.lgf_SwiftPopAbsoluteRect.origin.y + lgf_Style.lgf_SwiftPopAbsoluteRect.size.height + lgf_Style.lgf_SwiftPopArrowOffset, w: lgf_Style.lgf_SwiftPopMenuSize.width, h: lgf_Style.lgf_SwiftPopMenuSize.height + lgf_Style.lgf_SwiftPopArrowSize.height)
            
            lgf_Style.lgf_SwiftPopMenuView.frame = CGRect.init(x: 0.0, y: lgf_Style.lgf_SwiftPopArrowSize.height, w: lgf_Style.lgf_SwiftPopMenuSize.width, h: lgf_Style.lgf_SwiftPopMenuSize.height)
            
            lgf_ArrowView.frame = CGRect.init(x: (lgf_Style.lgf_SwiftPopMenuView.frame.size.width / 2.0) - (lgf_Style.lgf_SwiftPopArrowSize.width / 2.0) + lgf_Style.lgf_SwiftPopArrowCenter, y: 0.0, w: lgf_Style.lgf_SwiftPopArrowSize.width, h: lgf_Style.lgf_SwiftPopArrowSize.height + 0.5)
        } else if lgf_Style.lgf_SwiftPopMenuDirection == .left {
            lgf_MenuBackView.frame = CGRect.init(x: lgf_Style.lgf_SwiftPopAbsoluteRect.origin.x - lgf_Style.lgf_SwiftPopArrowSize.height - lgf_Style.lgf_SwiftPopMenuSize.width - lgf_Style.lgf_SwiftPopArrowOffset, y: lgf_Style.lgf_SwiftPopAbsoluteRect.origin.y - ((lgf_Style.lgf_SwiftPopMenuSize.height - lgf_Style.lgf_SwiftPopAbsoluteRect.size.height) / 2.0) - lgf_Style.lgf_SwiftPopMenuCenter, w: lgf_Style.lgf_SwiftPopMenuSize.width + lgf_Style.lgf_SwiftPopArrowSize.height, h: lgf_Style.lgf_SwiftPopMenuSize.height)
            
            lgf_Style.lgf_SwiftPopMenuView.frame = CGRect.init(x: 0.0, y: 0.0, w: lgf_Style.lgf_SwiftPopMenuSize.width, h: lgf_Style.lgf_SwiftPopMenuSize.height)
            
            lgf_ArrowView.frame = CGRect.init(x: lgf_Style.lgf_SwiftPopMenuSize.width - 0.5, y: (lgf_Style.lgf_SwiftPopMenuView.frame.size.height / 2.0) - (lgf_Style.lgf_SwiftPopArrowSize.width / 2.0) + lgf_Style.lgf_SwiftPopArrowCenter, w: lgf_Style.lgf_SwiftPopArrowSize.height, h: lgf_Style.lgf_SwiftPopArrowSize.width)
        } else if lgf_Style.lgf_SwiftPopMenuDirection == .right {
            lgf_MenuBackView.frame = CGRect.init(x: lgf_Style.lgf_SwiftPopAbsoluteRect.origin.x + lgf_Style.lgf_SwiftPopAbsoluteRect.size.width, y: lgf_Style.lgf_SwiftPopAbsoluteRect.origin.y - ((lgf_Style.lgf_SwiftPopMenuSize.height - lgf_Style.lgf_SwiftPopAbsoluteRect.size.height) / 2.0) - lgf_Style.lgf_SwiftPopMenuCenter, w: lgf_Style.lgf_SwiftPopMenuSize.width + lgf_Style.lgf_SwiftPopMenuSize.height, h: lgf_Style.lgf_SwiftPopMenuSize.height)
            
            lgf_Style.lgf_SwiftPopMenuView.frame = CGRect.init(x: lgf_Style.lgf_SwiftPopArrowOffset + lgf_Style.lgf_SwiftPopArrowSize.height, y: 0.0, w: lgf_Style.lgf_SwiftPopMenuSize.width, h: lgf_Style.lgf_SwiftPopMenuSize.height)
            
            lgf_ArrowView.frame = CGRect.init(x: lgf_Style.lgf_SwiftPopArrowOffset, y: (lgf_Style.lgf_SwiftPopMenuView.frame.size.height / 2.0) - (lgf_Style.lgf_SwiftPopArrowSize.width / 2.0) + lgf_Style.lgf_SwiftPopArrowCenter, w: lgf_Style.lgf_SwiftPopArrowSize.height + 0.5, h: lgf_Style.lgf_SwiftPopArrowSize.width)
        }
        
        lgf_MenuBackView.alpha = lgf_Style.lgf_SwiftPopMenuViewbackColor.lgf_Hsba.alpha
        addSubview(lgf_MenuBackView)
        lgf_MenuBackView.addSubview(lgf_ArrowView)
        lgf_MenuBackView.addSubview(lgf_Style.lgf_SwiftPopMenuView)
        self.delegate?.lgf_SwiftPopMenuDidShow(self)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        self.lgf_AutoTransform()
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.lgf_MenuBackView.transform = CGAffineTransform.identity
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == self {
            lgf_Dismiss()
        }
    }
    
    /**
     隐藏 pop 菜单
     */
    func lgf_Dismiss() {
        lgf_Dismiss(nil)
    }
    /**
     隐藏 pop 菜单
     lgf_Arbitrarily 之前由 LGFSwiftPopMenuStyle 保存的任意值
     */
    func lgf_Dismiss(_ lgf_Arbitrarily: ((AnyObject) -> Void)?) {
        self.delegate?.lgf_SwiftPopMenuDidDismiss(self)
        lgf_MenuBackView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.lgf_MenuBackView.alpha = 0.0
            self.lgf_AutoTransform()
        }) { (finish) in
            self.delegate?.lgf_SwiftPopMenuDidDismiss(self)
            lgf_Arbitrarily?(self.lgf_Style.lgf_Arbitrarily)
            self.removeFromSuperview()
        }
    }
    
    func lgf_AutoTransform() {
        if self.lgf_Style.lgf_SwiftPopMenuDirection == .top {
            self.lgf_MenuBackView.transform = CGAffineTransform.init(translationX: 0.0, y: 4.0)
        } else if self.lgf_Style.lgf_SwiftPopMenuDirection == .bottom {
            self.lgf_MenuBackView.transform = CGAffineTransform.init(translationX: 0.0, y: -4.0)
        } else if self.lgf_Style.lgf_SwiftPopMenuDirection == .left {
            self.lgf_MenuBackView.transform = CGAffineTransform.init(translationX: 4.0, y: 0.0)
        } else if self.lgf_Style.lgf_SwiftPopMenuDirection == .right {
            self.lgf_MenuBackView.transform = CGAffineTransform.init(translationX: -4.0, y: 0.0)
        }
    }
}
