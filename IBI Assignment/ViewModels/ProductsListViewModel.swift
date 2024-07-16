//
//  ProductsListViewModel.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import UIKit
import Combine

class ProductsListViewModel {
    private let dataManager: ProductsDataManager = .shared
    private var cancellables: Set<AnyCancellable> = .init()
    
    private(set) var data: [ProductEntity] = []
    
    var delegate: ChangeableViewModelDelegate? {
        didSet {
            bindChanges()
        }
    }
    
    func bindChanges() {
        dataManager.$products
            .compactMap { $0 }
            .sink {  [weak self] products in
                guard let self else { return }
                
                data = products
                delegate?.dataChanged()
            }
            .store(in: &cancellables)
        
        dataManager.$error
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.delegate?.failedWith(error)
            }
            .store(in: &cancellables)
    }
    
    // TODO: Not implemented in UI
    func add(_ product: ProductEntity) {
        dataManager.add(product)
    }
    
    func remove(at: Int) {
        dataManager.remove(data[at])
        data.remove(at: at)
    }
    
    func reloadFromServer() {
        dataManager.fetchFromProductsService()
    }
}
