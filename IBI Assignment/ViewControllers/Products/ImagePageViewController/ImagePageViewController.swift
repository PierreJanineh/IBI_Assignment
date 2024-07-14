//
//  ImagePageViewController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 14/07/2024.
//

import UIKit

class ImagePageViewController: UIPageViewController {
    private var images: [UIImageView] = []
    
    init(images: [UIImageView]) {
        self.images = images
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        setupPageControl()
        
        if let firstViewController = viewControllerAtIndex(0) {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private func setupPageControl() {
        let pageControl = UIPageControl
            .appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
    }
}

extension ImagePageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return images.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first as? SingleImageViewController
        else { return 0 }
        
        return firstViewController.pageIndex
    }
}

extension ImagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? SingleImageViewController
        else { return nil }
        
        var index = viewController.pageIndex
        if index == 0 || index == NSNotFound {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? SingleImageViewController
        else { return nil }
        
        var index = viewController.pageIndex
        if index == NSNotFound {
            return nil
        }
        index += 1
        if index == images.count {
            return nil
        }
        return viewControllerAtIndex(index)
    }
    
    private func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        guard index >= 0 && index < images.count 
        else { return nil }
        
        return SingleImageViewController(imageView: images[index], i: index)
    }
}
