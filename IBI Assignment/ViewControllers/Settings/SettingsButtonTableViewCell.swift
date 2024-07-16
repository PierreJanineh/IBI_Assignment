//
//  SettingsButtonTableViewCell.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import UIKit

class SettingsButtonTableViewCell: UITableViewCell, ConfigurableCell {
    static let identifier = "buttonReuseIdentifier"
    
    @IBOutlet weak var button: UIButton!
    
    func configure(kind: SettingKind) {
        button.tag = kind.rawValue
        button.setTitle(kind.description, for: .normal)
        
        guard let action = kind.action else { return }
        button.addAction(.init(handler: { _ in
            action()
        }), for: .touchUpInside)
    }
}
