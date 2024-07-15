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
    private static var lottieAnimation: String = "Login"
    private static var toNavigationController: String = "navigationController"
    private static var loginSuccessful: LocalizedStringResource = "login successful"
    private static var username: LocalizedStringResource = "username"
    private static var password: LocalizedStringResource = "password"
    private static var login: LocalizedStringResource = "login"
    
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
    
    func bindViewModel() {
        viewModel.$authResponse
            .compactMap { $0 }
            .sink { [weak self] authResponse in
                guard let success = authResponse.success
                else { return }
                
                guard success
                else {
                    guard let error = authResponse.error else { return }
                    self?.showAlert(message: error) {
                    }
                    return
                }
            }
            .store(in: &cancellables)
    }
    
    func setupView() {
        usernameField.placeholder = Self.username.localized
        passwordField.placeholder = Self.password.localized
        loginButton.setTitle(Self.login.localized, for: .normal)
    }
    
    func setupAnimation() {
        let animation = LottieAnimation.named(Self.lottieAnimation)
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
