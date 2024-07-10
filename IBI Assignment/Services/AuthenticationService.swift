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
    private let laContext: LAContext = .init()
    private var error: NSError?
    
    func authenticate(username: String,
                      password: String) -> Future<Bool, Error> {
        return Future { promise in
            // Dummy implementation
            if username == "admin" && password == "password" {
                promise(.success(true))
            } else {
                let error = NSError(domain: "",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey : String(localized: "invalid credentials")])
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
                                    userInfo: [NSLocalizedDescriptionKey : String(localized: "biometric not available")])
                promise(.failure(error))
                return
            }
            
            let reason = String(localized: "biometric evaluation reason")
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
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
