//
//  ConfigurableCell.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import UIKit

protocol ConfigurableCell: UITableViewCell {
    /**
     Configures the cell according to ``SettingKind``
     - Parameters:
        - kind: SettingKind of the element
        - action: action (such as `onClick()`)
     */
    func configure(kind: SettingKind)
}
