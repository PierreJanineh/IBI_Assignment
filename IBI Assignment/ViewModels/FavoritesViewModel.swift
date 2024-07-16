//
//  FavoritesViewModel.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 14/07/2024.
//

import Foundation
import Combine

class FavoritesViewModel {
    private let dataManager: ProductsDataManager = .shared
    private var cancellables: Set<AnyCancellable> = .init()
    
    private(set) var data: [ProductEntity] = []
    
    var delegate: ChangeableViewModelDelegate? {
        didSet {
            bindChanges()
        }
    }
    
    func bindChanges() {
        dataManager.$favProducts
            .compactMap { $0 }
            .sink { [weak self] favProducts in
                guard let self else { return }
                
                data = favProducts
                delegate?.dataChanged()
            }
            .store(in: &cancellables)
    }
    
    func fetchFavProducts() {
        dataManager.fetchFavProducts()
    }
    
    func remove(at: Int) {
        dataManager.favorite(data[at])
        data.remove(at: at)
    }
}
