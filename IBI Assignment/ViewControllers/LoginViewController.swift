//
//  LoginViewController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 09/07/2024.
//

import UIKit
import Combine
import Lottie

class LoginViewController: UIViewController {
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var animationView: LottieAnimationView!
    @IBOutlet private weak var biometricButton: UIButton!
    
    private let viewModel: LoginViewModel = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setupAnimation()
        setupBiometricButton()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        viewModel.login(usernameField.text, passwordField.text)
    }
    
    @IBAction func biometricTapped(_ sender: Any) {
        viewModel.authenticateBiometrically()
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: String(localized: "ok"), style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func bindViewModel() {
        viewModel.$authResponse
            .compactMap { $0 }
            .sink { [weak self] authResponse in
                let message: String? = {
                    guard let success = authResponse.success else { return nil }
                    if let error = authResponse.error,
                       !success {
                        return error
                    } else {
                        return String(localized: "login successful")
                    }
                }()
                guard let message else { return }
                self?.showAlert(message: message)
            }
            .store(in: &cancellables)
    }
    
    func setupAnimation() {
        let animation = LottieAnimation.named("Login")
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    
    func setupBiometricButton() {
        guard let systemName = viewModel.biometricSystemName
        else {
            biometricButton.isHidden = true
            return
        }
        
        biometricButton.setImage(UIImage(systemName: systemName), for: .normal)
    }
}
