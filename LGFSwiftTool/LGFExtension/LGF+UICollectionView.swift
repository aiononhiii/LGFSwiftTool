//
//  LGF+UICollectionView.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UICollectionView {
    // MARK: - 快捷注册 Xib cell
    /// cellIdentifier == 类名.self
    /// 使用：self.lgf_Register(cellType: LaiGuoFengCell.self)
    func lgf_RegisterXib(cellType: UICollectionViewCell.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType.classForCoder())
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    // MARK: - 批量注册 Xib cell
    /// [cellIdentifier] == [类名.self]
    /// 使用：collectionView.lgf_Registers(cellTypes: [LaiGuoFengCell.self, LaiGuoFengCell.self, LaiGuoFengCell.self])
    func lgf_RegisterXibs(cellTypes: [UICollectionViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { lgf_RegisterXib(cellType: $0, bundle: bundle) }
    }
    
    // MARK: - 快捷注册 cell
    /// cellIdentifier == 类名.self
    /// 使用：self.lgf_Register(cellType: LaiGuoFengCell.self)
    func lgf_Register(cellType: UICollectionViewCell.Type) {
        let className = String(describing: cellType.classForCoder())
        register(cellType, forCellWithReuseIdentifier: className)
    }
    
    // MARK: - 批量注册 cell
    /// [cellIdentifier] == [类名.self]
    /// 使用：collectionView.lgf_Registers(cellTypes: [LaiGuoFengCell.self, LaiGuoFengCell.self, LaiGuoFengCell.self])
    func lgf_Registers(cellTypes: [UICollectionViewCell.Type]) {
        cellTypes.forEach { lgf_Register(cellType: $0) }
    }
    
    // MARK: - 初始化自定义 cell 的时候就不用加上 as! LaiGuoFengCell 这句话了
    /// 使用： let cell = collectionView.lgf_DequeueReusableCell(with: LaiGuoFengCell.self, for: indexPath)
    func lgf_DequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                          for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type.classForCoder()), for: indexPath) as! T
    }
    
    // MARK: - 快捷注册 ReusableView
    /// reusableViewIdentifier == 类名.self
    /// 使用：self.lgf_Register(reusableViewType: LaiGuoFengReusableView.self)
    func lgf_Register(reusableViewType: UICollectionReusableView.Type,
                      ofKind kind: String = UICollectionView.elementKindSectionHeader,
                      bundle: Bundle? = nil) {
        let className = String(describing: reusableViewType.classForCoder())
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    // MARK: - 批量注册 ReusableView
    /// [reusableViewIdentifier] == [类名.self]
    /// 使用：collectionView.lgf_Registers(reusableViewTypes: [LaiGuoFengReusableView.self, LaiGuoFengReusableView.self, LaiGuoFengReusableView.self])
    func lgf_Registers(reusableViewTypes: [UICollectionReusableView.Type],
                       ofKind kind: String = UICollectionView.elementKindSectionHeader,
                       bundle: Bundle? = nil) {
        reusableViewTypes.forEach { lgf_Register(reusableViewType: $0, ofKind: kind, bundle: bundle) }
    }
    
    // MARK: - 初始化自定义 ReusableView 的时候就不用加上 as! LaiGuoFengReusableView 这句话了
    /// 使用： let cell = collectionView.lgf_DequeueReusableView(with: LaiGuoFengReusableView.self, for: indexPath)
    func lgf_DequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                              for indexPath: IndexPath,
                                                              ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: type.classForCoder()), for: indexPath) as! T
    }
}
#endif // canImport(UIKit)
