//
//  SettingsViewModel.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import UIKit

class SettingsViewModel {
    private let userDefaultsService: UserDefaultsService = .init()
    private let appManager: AppManager = .shared
    
    var selectedLanguage: Language {
        userDefaultsService.language
    }
    var selectedScheme: ColorScheme {
        userDefaultsService.colorScheme
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
        
        userDefaultsService.setLanguage(language)
        
        // Reload the root view controller
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.reloadRootViewController()
    }
    
    func changeMode(_ i: Int) {
        guard let scheme = ColorScheme(rawValue: i)
        else { return }
        
        userDefaultsService.setScheme(scheme)
        
        // Apply color scheme selection
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.setColorScheme(scheme)
    }
    
    func logout() {
        appManager.setAppState(.loggedOut)
        
        // Reload the root view controller
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.reloadRootViewController()
    }
}
