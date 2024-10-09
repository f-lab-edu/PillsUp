//
//  UITableViewCell+Extension.swift
//
//
//  Created by Junyoung on 9/23/24.
//

#if canImport(UIKit)
import UIKit
#endif

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
