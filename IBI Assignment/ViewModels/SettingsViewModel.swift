//
//  SettingsViewModel.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import UIKit

class SettingsViewModel {
    private let appManager: AppManager = .shared
    
    var selectedLanguage: Language {
        appManager.language
    }
    var selectedScheme: ColorScheme {
        appManager.colorScheme
    }
    
    lazy var items: [TableSection] = [
        TableSection(title: "interface",
                     settings: [Setting(title: "enable dark mode",
                                        icon: UIImage(systemName: ""),
                                        kind: .coloScheme(onSelect: changeMode(_:))),
                                Setting(title: "language",
                                        icon: UIImage(systemName: ""),
                                        kind: .language(onSelect: changeLanguage(_:)))]),
        TableSection(title: "account",
                     settings: [Setting(title: "logout",
                                        icon: UIImage(systemName: ""),
                                        kind: .logout(onClick: logout))])
    ]
    
    func changeLanguage(_ i: Int) {
        guard let language = Language(rawValue: i)
        else { return }
        
        appManager.setLanguage(language)
        
        // Reload the root view controller
        sceneDelegate?.reloadRootViewController()
    }
    
    func changeMode(_ i: Int) {
        guard let scheme = ColorScheme(rawValue: i)
        else { return }
        
        appManager.setColorScheme(scheme)
        
        // Apply color scheme selection
        sceneDelegate?.setColorScheme(scheme)
    }
    
    func logout() {
        appManager.setAppState(.loggedOut)
        
        // Reload the root view controller
        sceneDelegate?.reloadRootViewController()
    }
    
    private var sceneDelegate: SceneDelegate? {
        UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }
}
