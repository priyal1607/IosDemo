//
//  UITableView+Extension.swift
//  SharkID
//
//  Created by Hitesh on 26/03/19.
//  Copyright © 2019 sttl. All rights reserved.
//
//MARK:- Hitesh UITableview cell extension fo
//Extension is used for register and deque cell

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {
    
    private struct NSObject_Associated_Keys {
        static var any_Value_store_Key = "any_Value_store_Key_nsObject"
    }

    /**
     Any value store for hint.
     */
    @objc var any_value_store_property: Any? {
        get {
            return objc_getAssociatedObject(self, &NSObject_Associated_Keys.any_Value_store_Key)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &NSObject_Associated_Keys.any_Value_store_Key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}


public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
    func registerClass<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        self.register(cellType, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(HeaderFooterType: T.Type) {
        let className = HeaderFooterType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: className)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(HeaderFooterTypes: [T.Type]) {
        HeaderFooterTypes.forEach { registerHeaderFooter(HeaderFooterType: $0) }
    }
    
    func dynamicHeightTableHeaderViewCalling(_ complation: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self,
                  let headerView = self.tableHeaderView else {
                      complation?()
                      return
                  }
            var newFrame = headerView.frame
            let size = headerView.systemLayoutSizeFitting(.init(width: self.frame.width, height: 50), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            newFrame.size = size
            headerView.frame = newFrame
            self.tableHeaderView = headerView
            complation?()
        }
    }
    
    func dynamicHeightTableFooterViewCalling(_ complation: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self,
                  let headerView = self.tableFooterView else {
                      complation?()
                      return
                  }
            var newFrame = headerView.frame
            let size = headerView.systemLayoutSizeFitting(.init(width: self.frame.width, height: 50), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            newFrame.size = size
            headerView.frame = newFrame
            self.tableFooterView = headerView
            complation?()
        }
    }
    
    @objc func beginEndUpdates() {
        beginUpdates()
        endUpdates()
    }
}

