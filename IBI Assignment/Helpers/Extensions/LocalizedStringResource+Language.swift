//
//  LocalizedStringResource+Language.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation

extension LocalizedStringResource {
    var localized: String {
        guard let path = Bundle.main.path(forResource: AppManager.shared.language.code,
                                          ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self.key
        }
        return NSLocalizedString(self.key, bundle: bundle, comment: "")
    }
}
