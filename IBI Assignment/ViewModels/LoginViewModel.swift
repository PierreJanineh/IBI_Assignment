//
//  LoginViewModel.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 09/07/2024.
//

import Foundation
import Combine

class LoginViewModel {
    private static let bothCredentialsNeeded: LocalizedStringResource = "both credentials needed"
    
    private let authenticationService: AuthenticationService = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    @Published var authResponse: AuthResponse?
    
    func login(_ username: String?,
               _ password: String?) {
        authResponse = .init()
        
        guard let username, !username.isEmpty,
              let password, !password.isEmpty
        else {
            self.authResponse = .init(success: false,
                                      error: Self.bothCredentialsNeeded.localized)
            return
        }
        
        authenticationService.authenticate(username: username,
                                           password: password)
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.authResponse = .init(success: false,
                                           error: error.localizedDescription)
            }
        } receiveValue: { [weak self] success in
            self?.authResponse?.success = success
        }
        .store(in: &cancellables)
    }
    
    func authenticateBiometrically() {
        authResponse = .init()
        
        authenticationService.authenticateBiometrically()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.authResponse = .init(success: false,
                                               error: error.localizedDescription)
                }
            } receiveValue: { [weak self] success in
                self?.authResponse?.success = success
            }
            .store(in: &cancellables)
    }
    
    var biometricSystemName: String? {
        switch authenticationService.biometryType {
        case .touchID:
            return "touchid"
        case .faceID:
            return "faceid"
        default:
            return nil
        }
    }
    
    var appState: AppState {
        AppManager.shared.appState
    }
}
