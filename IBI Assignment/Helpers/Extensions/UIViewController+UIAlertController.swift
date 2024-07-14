//
//  UIViewController+UIAlertController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 11/07/2024.
//

import UIKit

extension UIViewController {
    /// Show alert with message.
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: String(localized: "ok"), style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
