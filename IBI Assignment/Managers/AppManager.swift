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
    
    func setAppState(_ appState: AppState) {
        userDefaultsService.setAppState(appState)
    }
}
