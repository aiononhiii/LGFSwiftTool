//
//  LGF+UICollectionViewFlowLayout.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/22.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UICollectionViewFlowLayout {
    
    // MARK: - 0 UICollectionViewFlowLayout
    class func lgf_ZeroSpacLayout(_ direction: UICollectionView.ScrollDirection) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = direction
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    // MARK: - 编辑 UICollectionViewFlowLayout
    class func lgf_Layout(_ minimumLineSpacing: CGFloat, _ minimumInteritemSpacing: CGFloat, _ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
}

#endif // canImport(UIKit)
