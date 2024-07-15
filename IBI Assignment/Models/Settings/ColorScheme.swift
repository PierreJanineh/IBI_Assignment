//
//  ColorScheme.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation

enum ColorScheme: Int, SettingEnum {
    case system, dark, light
    
    var code: String {
        switch self {
        case .system:
            "system"
        case .dark:
            "dark"
        case .light:
            "light"
        }
    }
    
    var description: String {
        LocalizedStringResource(stringLiteral: code)
            .localized
    }
    
    static func from(code: String) -> ColorScheme {
        ColorScheme
            .allCases
            .filter { $0.code == code }
            .first ?? .system
    }
}
