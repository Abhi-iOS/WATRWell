//
//  WWWatrGuideVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWWatrGuideVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var navContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // Properties
    private(set) var viewModel: WWWatrGuideVM!
    let navBar: WWNavBarView = .fromNib()
    var lastContentOffset: CGPoint = .zero
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setupCollectionView()
        setNavBar()
        pageControl.numberOfPages = viewModel.dataSource.endIndex
    }
}

// MARK: - WWControllerType
extension WWWatrGuideVC: WWControllerType {
    
    static func create(with viewModel: WWWatrGuideVM) -> UIViewController {
        let watrGuideScene = WWWatrGuideVC.instantiate(fromAppStoryboard: .Misc)
        watrGuideScene.viewModel = viewModel
        return watrGuideScene
    }
    
    func configure(with viewModel: WWWatrGuideVM){
        
    }
}

// MARK: - ViewController life cycle methods
extension WWWatrGuideVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        navBar.frame = navContainerView.bounds
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

private extension WWWatrGuideVC {
    func setNavBar(){
        navContainerView.addSubview(navBar)
        navBar.logoImageView.tintColor = WWColors.hex203D75.color
        view.layoutIfNeeded()
        navBar.shareDidTap = { [weak self] in
            self?.showMenu()
        }
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = .zero
        collectionViewLayout.minimumInteritemSpacing = .zero
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.registerCell(with: WWWatrGuideCVC.self)
    }
    
    func showMenu() {
        let menuScene = WWMenuVC.create(with: WWMenuVM())
        tabBarController?.present(menuScene, animated: true)
    }
}

