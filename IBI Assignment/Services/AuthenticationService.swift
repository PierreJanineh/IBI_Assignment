//
//  AuthenticationService.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 09/07/2024.
//

import Foundation
import LocalAuthentication
import Combine

class AuthenticationService {
    private static let biometricEvaluationReason: LocalizedStringResource = "biometric evaluation reason"
    private static let biometricNotAvailable: LocalizedStringResource = "biometric not available"
    private static let invalidCredentials: LocalizedStringResource = "invalid credentials"
    
    private let appManager: AppManager = .shared
    private let laContext: LAContext = .init()
    private var error: NSError?
    
    func authenticate(username: String,
                      password: String) -> Future<Bool, Error> {
        return Future { [weak self] promise in
            // Dummy implementation
            if username == "admin" && password == "password" {
                self?.appManager.setAppState(.loggedIn)
                promise(.success(true))
            } else {
                let error = NSError(domain: "",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey : Self.invalidCredentials.localized])
                promise(.failure(error))
            }
        }
    }
    
    func authenticateBiometrically() -> Future<Bool, Error> {
        return Future { [weak self] promise in
            guard let self else { return }
            
            guard laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                              error: &error)
            else {
                let error = NSError(domain: "",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey : Self.biometricNotAvailable.localized])
                promise(.failure(error))
                return
            }
            
            let reason = Self.biometricEvaluationReason.localized
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.appManager.setAppState(.loggedIn)
                        promise(.success(success))
                    } else {
                        let error = NSError(domain: "",
                                            code: 0,
                                            userInfo: [NSLocalizedDescriptionKey : authenticationError?.localizedDescription as Any])
                        promise(.failure(error))
                    }
                }
            }
        }
    }
    
    var biometryType: LABiometryType? {
        guard laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                       error: &error)
        else { return nil }
        
        return laContext.biometryType
    }
}
