//
//  AppManager.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import UIKit

class AppManager {
    static let shared: AppManager = .init()
    private init() { }
    
    private let userDefaultsService: UserDefaultsService = .init()
    
    var appState: AppState {
        userDefaultsService.appState
    }
    
    var language: Language {
        userDefaultsService.language
    }
    
    func setLanguage(_ language: Language) {
        userDefaultsService.setLanguage(language)
    }
    
    var colorScheme: ColorScheme {
        userDefaultsService.colorScheme
    }
    
    func setColorScheme(_ colorScheme: ColorScheme) {
        userDefaultsService.setColorScheme(colorScheme)
    }
    
    func setAppState(_ appState: AppState) {
        userDefaultsService.setAppState(appState)
    }
}
