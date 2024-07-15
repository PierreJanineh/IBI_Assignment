//
//  UIViewController+UIAlertController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 11/07/2024.
//

import UIKit

extension UIViewController {
    /// Show alert with message.
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: LocalizedStringResource(stringLiteral: "ok").localized,
                                                style: .default) {_ in completion?() } )
        present(alertController, animated: true, completion: nil)
    }
}
