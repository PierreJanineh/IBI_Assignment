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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet private weak var biometricButton: UIButton!
    @IBOutlet weak var overlayProgress: UIView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    private let viewModel: LoginViewModel = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setupView()
        setupAnimation()
        setupBiometricButton()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        if viewModel.appState == .loggedIn {
            performSegue(withIdentifier: Self.toNavigationController, sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        overlayProgress.isHidden = true
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        progressView.isHidden = false
        viewModel.login(usernameField.text, passwordField.text)
    }
    
    @IBAction func biometricTapped(_ sender: Any) {
        progressView.isHidden = false
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
                        self?.progressView.isHidden = true
                    }
                    return
                }
                
                self?.progressView.isHidden = true
                self?.performSegue(withIdentifier: Self.toNavigationController, sender: self)
            }
            .store(in: &cancellables)
    }
    
    func setupView() {
        view.bringSubviewToFront(overlayProgress)
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        usernameField.placeholder = Self.username.localized
        passwordField.placeholder = Self.password.localized
        passwordField.isSecureTextEntry = true
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

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
