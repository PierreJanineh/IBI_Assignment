//
//  Language.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation

enum Language: Int, SettingEnum {
    case english, hebrew
    
    static func from(code: String) -> Language {
        Language
            .allCases
            .filter { $0.code == code }
            .first ?? .english
    }
    
    var code: String {
        switch self {
        case .english:
            "en"
        case .hebrew:
            "he"
        }
    }
    
    var description: String {
        LocalizedStringResource(stringLiteral: code)
            .localized
    }
}
