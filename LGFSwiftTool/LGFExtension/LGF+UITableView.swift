//
//  LGF+UITableView.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/7/31.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UITableView {
    // MARK: - 快捷注册 cell
    /// cellIdentifier == 类名.self
    /// 使用：tableView.lgf_Register(cellType: LaiGuoFengCell.self)
    func lgf_Register(cellType: UITableViewCell.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType.classForCoder())
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    // MARK: - 批量注册 cell
    /// [cellIdentifier] == [类名.self]
    /// 使用：tableView.lgf_Registers(cellTypes: [LaiGuoFengCell.self, LaiGuoFengCell.self, LaiGuoFengCell.self])
    func lgf_Registers(cellTypes: [UITableViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { lgf_Register(cellType: $0, bundle: bundle) }
    }
    
    // MARK: - 初始化自定义 cell 的时候就不用加上 as! LaiGuoFengCell 这句话了
    /// 使用： let cell = tableView.lgf_DequeueReusableCell(with: LaiGuoFengCell.self, for: indexPath)
    func lgf_DequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type.classForCoder()), for: indexPath) as! T
    }
}
#endif // canImport(UIKit)
