//
//  SettingKind.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation

enum SettingKind {
    case logout(onClick: () -> Void)
    case language(onSelect: (_ i: Int) -> Void)
    case coloScheme(onSelect: (_ i: Int) -> Void)
    
    var rawValue: Int {
        switch self {
        case .logout(_): 0
        case .language(_): 1
        case .coloScheme(_): 2
        }
    }
    
    var description: String {
        let key: LocalizedStringResource = switch self {
        case .logout(_): "logout"
        case .language(_): "language"
        case .coloScheme(_): "color scheme"
        }
        return key.localized
    }
    
    var action: (() -> Void)? {
        switch self {
        case .logout(let onClick): onClick
        default: nil
        }
    }
    
    var pickerAction: ((Int) -> Void)? {
        switch self {
        case .logout(_): nil
        case .language(let onSelect): onSelect
        case .coloScheme(let onSelect): onSelect
        }
    }
    
    var enumType: (any SettingEnum.Type)? {
        switch self {
        case .logout(_): return nil
        case .language(_): return Language.self
        case .coloScheme(_): return ColorScheme.self
        }
    }
    
    static func initialize(from rawValue: Int) -> SettingKind? {
        switch rawValue {
        case 0:
            .logout(onClick: { })
        case 1:
            .language(onSelect: { _ in })
        case 2:
            .coloScheme(onSelect: { _ in })
        default: nil
        }
    }
}
