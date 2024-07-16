//
//  PaginableTableView.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 14/07/2024.
//

import UIKit

class PaginableProductsTableViewController: UIViewController {
    private(set) var currentPage: Int = 1
    private(set) var totalPageCount: Int = 0
    
    private var currentlyDisplayedProducts: [ProductEntity] = []
    private var tableView: UITableView?
    
    var paginationDelegate: PaginableDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Disable selection after dismissing ProductDetailViewController
        tableView?.selectRow(at: nil,
                            animated: true,
                            scrollPosition: .none)
        setupTableView()
    }
    
    func reloadData() {
        tableView?.reloadData()
        loadMoreData()
    }
    
    private func setupTableView() {
        // Reinitialize UITableView to adapt to selected ColoScheme
        if let _ = tableView {
            tableView?.removeFromSuperview()
        }
        tableView = .init()
        
        guard let tableView else { return }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ProductTableViewCell.self,
                           forCellReuseIdentifier: ProductTableViewCell.identifier)
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadMoreData() {
        guard let paginationDelegate,
              paginationDelegate.productsForTableView().count != currentlyDisplayedProducts.count
        else { return }
        let data = paginationDelegate.productsForTableView()
        let maxItems = paginationDelegate.maxItemsPerPage()
        
        let startIndex = (currentPage - 1) * maxItems
        let endIndex = min(startIndex + maxItems, data.count)
        
        guard startIndex < endIndex
        else {
            if endIndex != currentlyDisplayedProducts.count {
                currentlyDisplayedProducts = data
                tableView?.reloadData()
            }
            return
        }
        
        currentlyDisplayedProducts.append(contentsOf: data[startIndex..<endIndex])
        tableView?.reloadData()
        currentPage += 1
    }
}

extension PaginableProductsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.window?.windowScene?.screen.bounds.width ?? 0 * 0.8
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(
            ProductDetailViewController(product: currentlyDisplayedProducts[indexPath.row]),
            animated: true
        )
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - (scrollView.frame.height * 2) {
            loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentlyDisplayedProducts.remove(at: indexPath.row)
            paginationDelegate?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension PaginableProductsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.currentlyDisplayedProducts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier,
                                                       for: indexPath) as? ProductTableViewCell,
              let product = paginationDelegate?.productsForTableView()[safe: indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(with: product)
        return cell
    }
}
