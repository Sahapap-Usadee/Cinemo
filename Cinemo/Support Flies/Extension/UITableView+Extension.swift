//
//  UITableView+Extension.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import Foundation
import UIKit

extension UITableView {
    func setThemeTableView(
        background: UIColor = .clear,
        separator: UITableViewCell.SeparatorStyle = .none,
        allowsRowSelection: Bool = true
    ) {
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = .zero
        }
        contentInsetAdjustmentBehavior = .never
        backgroundColor = background
        separatorStyle = separator
        allowsSelection = allowsRowSelection
        isScrollEnabled = true
        showsVerticalScrollIndicator = false
    }

    func register<Cell: UITableViewCell>(_ cellType: Cell.Type) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: Bundle(for: cellType.self))
        register(nib, forCellReuseIdentifier: className)
    }

    func register<HeaderFooter: UITableViewHeaderFooterView>(_ viewType: HeaderFooter.Type) {
        let className = String(describing: viewType)
        let nib = UINib(nibName: className, bundle: Bundle(for: viewType.self))
        register(nib, forHeaderFooterViewReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let className = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(className)")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        let className = String(describing: T.self)
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: className) as? T else {
            fatalError("Could not dequeue header/footer view with identifier: \(className)")
        }
        return view
    }
}
