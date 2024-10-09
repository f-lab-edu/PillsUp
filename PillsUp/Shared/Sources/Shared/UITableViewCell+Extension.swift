//
//  UITableViewCell+Extension.swift
//
//
//  Created by Junyoung on 9/23/24.
//

import UIKit

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
