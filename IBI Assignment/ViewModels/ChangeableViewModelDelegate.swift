//
//  ChangeableViewModelDelegate.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import UIKit

protocol ChangeableViewModelDelegate {
    func dataChanged()
    func failedWith(_ error: Error?)
}

extension ChangeableViewModelDelegate {
    func failedWith(_ error: Error?) {
        guard let error,
              let self = self as? UIViewController
        else { return }
        
        self.showAlert(message: error.localizedDescription)
    }
}
