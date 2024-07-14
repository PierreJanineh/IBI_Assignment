//
//  SingleImageViewController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 14/07/2024.
//

import UIKit

class SingleImageViewController: UIViewController {
    private(set) var imageView: UIImageView!
    private(set) var pageIndex: Int = 0
    
    init(imageView: UIImageView, i: Int) {
        self.imageView = imageView
        self.pageIndex = i
        super.init(nibName: nil, bundle: nil)
        
        self.imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
