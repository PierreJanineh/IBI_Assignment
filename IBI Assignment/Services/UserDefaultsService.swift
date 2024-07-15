//
//  UserDefaultsService.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation

class UserDefaultsService {
    static let language: String = "AppleLanguages"
    static let scheme: String = "colorScheme"
    static let appState: String = "appState"
    
    func setLanguage(_ language: Language) {
        UserDefaults.standard.set([language.code], forKey: Self.language)
    }
    
    var language: Language {
        guard let codes: [String] = UserDefaults.standard.array(forKey: Self.language) as? [String],
              let code = codes.first
        else { return .english }
        
        return Language.from(code: code)
    }
    
    func setScheme(_ scheme: ColorScheme) {
        UserDefaults.standard.set(scheme.code, forKey: Self.scheme)
    }
    
    var colorScheme: ColorScheme {
        guard let code: String = UserDefaults.standard.string(forKey: Self.scheme)
        else { return .system }
        
        return ColorScheme.from(code: code)
    }
    
    func setAppState(_ appState: AppState) {
        UserDefaults.standard.set(appState.rawValue, forKey: Self.appState)
    }
    
    var appState: AppState {
        AppState(rawValue: UserDefaults.standard.integer(forKey: Self.appState)) ?? .loggedOut
    }
}
