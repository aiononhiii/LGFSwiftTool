//
//  LGFSwiftMethod.swift
//  MedicalUnion
//
//  Created by apple on 2019/7/29.
//  Copyright © 2019 William_Xue. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#if canImport(UIKit)
import UIKit

// MARK: -  UICollectionViewCell 长按拖动
///
/// - Parameters:
///   - sender: 初始化并添加在 collectionView 上的长按手势
///   - collectionView: 传入要作用的 collectionView
///   - fixedHorizontal: 固定横向边界
///   - fixedVertical: 固定竖向边界
public func lgf_SortCellWithGesture(sender: UILongPressGestureRecognizer, collectionView: UICollectionView, fixedHorizontal: Bool, fixedVertical: Bool) -> Void {
    let point = sender.location(in: collectionView)
    var lgf_MoveCell: UICollectionViewCell!
    let indexPath: IndexPath!
    switch sender.state {
    case .began:
        indexPath = collectionView.indexPathForItem(at: point)
        lgf_MoveCell = collectionView.cellForItem(at: indexPath)
        lgf_MoveCell.alpha = 0.7
        lgf_MoveCell.subviews.forEach { (view) in
            view.alpha = 0.7
        }
        if indexPath == nil {
            break
        }
        collectionView.beginInteractiveMovementForItem(at: indexPath)
        break
    case .changed:
        collectionView.updateInteractiveMovementTargetPosition(CGPoint.init(x: fixedHorizontal ? min(max((lgf_MoveCell.lgf_Width / 2), point.x), collectionView.contentSize.width - (lgf_MoveCell.lgf_Width / 2)) : point.x, y:  fixedVertical ? min(max((lgf_MoveCell.lgf_Height / 2), point.y), collectionView.contentSize.height - (lgf_MoveCell.lgf_Height / 2)) : point.y))
        break
    case .ended:
        lgf_MoveCell.alpha = 1.0
        lgf_MoveCell.subviews.forEach { (view) in
            view.alpha = 1.0
        }
        collectionView.endInteractiveMovement()
        break
    default:
        lgf_MoveCell.alpha = 1.0
        lgf_MoveCell.subviews.forEach { (view) in
            view.alpha = 1.0
        }
        collectionView.cancelInteractiveMovement()
    }
}


// MARK: -  UICollectionViewCell 长按拖动
///
/// - Parameter phoneNumber: 传入的手机号字符串
@available(iOS 10.0, *)
public func lgf_CallPhoneWithPhoneNumber(phoneNumber: String) -> Void {
    let number = "tel:" + phoneNumber
    let numberURL = URL.init(string: number)
    if numberURL != nil {
        UIApplication.shared.open(numberURL!, options: [:]) { (success) in
            if success {
                debugPrint("电话拨打成功")
            } else {
                debugPrint("电话拨打失败")
            }
        }
    } else {
        debugPrint("电话拨打失败")
    }
}

// MARK: - 获取相对于屏幕宽度
public func lgf_W(_ w: CGFloat) -> CGFloat {
    return CGFloat(w * UIDevice.lgf_ScreenW / 375.0)
}

// MARK: - 获取相对于屏幕高度
public func lgf_H(_ h: CGFloat) -> CGFloat {
    return CGFloat(h * UIDevice.lgf_ScreenH / 667.0)
}

func lgf_DecimalPointInputSpecificationWithTextField(textField: UITextField, string: String, range: NSRange) -> Bool {
//    var isHaveDian: Bool!
//    if textField.text!.contains(".") {
//        isHaveDian = true
//    } else {
//        isHaveDian = false
//    }
//    if string.count > 0 {
//        let single = string[string.index(string.startIndex, offsetBy: 0)]
//        if !((single >= "0" && single <= "9") || single == ".") {
//            return false;
//        }
//        // 只能有一个小数点
//        if isHaveDian && single == "." {
//            return false;
//        }
//        // 如果第一位是.则前面加上0.
//        if textField.text?.count == 0 && single == "." {
//            textField.text = "0";
//        }
//
//        // 如果第一位是0则后面必须输入点，否则不能输入。
//        if textField.text!.hasPrefix("0") {
//            if textField.text!.count > 1 {
//                let secondStr = textField.text?.substring(Range(1...2))
//                if secondStr != "." {
//                    return false;
//                }
//            } else {
//                if string != "." {
//                    return false;
//                }
//            }
//        }
        // 小数点后最多能输入两位
//        if isHaveDian {
//            let ran = textField.text?.range(of: ".")
//            if (textField.text.i > ran!.lowerBound) {
//                return false
//            }
//        }
//    }
    
    return false
}

#endif // canImport(UIKit)

#endif // canImport(Foundation)
