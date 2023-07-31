//
//  WWDiscoverVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWDiscoverVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var navBarContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // Properties
    private(set) var viewModel: WWDiscoverVM!
    private var navBar: WWNavBarView = .fromNib()
    
    // Overriden functions
    override func setupViews() {
        setNavBar()
        configure(with: viewModel)
        pageControl.numberOfPages = viewModel.dataSource.endIndex
        setupCollectionView()
    }
}

// MARK: - WWControllerType
extension WWDiscoverVC: WWControllerType {
    
    func configure(with viewModel: WWDiscoverVM) {
        
    }
    
    static func create(with viewModel: WWDiscoverVM) -> UIViewController {
        let dailyBenifitsMasterScene = WWDiscoverVC.instantiate(fromAppStoryboard: .Discover)
        dailyBenifitsMasterScene.viewModel = viewModel
        return dailyBenifitsMasterScene
    }
}

// MARK: - ViewController life cycle methods
extension WWDiscoverVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        navBar.frame = navBarContainer.bounds
    }
}

private extension WWDiscoverVC {
    func setNavBar(){
        navBarContainer.addSubview(navBar)
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
        collectionViewLayout.sectionInset = .zero
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.registerCell(with: WWDiscoverIntentCVC.self)
        collectionView.registerCell(with: WWDiscoverInfoTextCVC.self)
    }
    
    func showMenu() {
        let menuScene = WWMenuVC.create(with: WWMenuVM())
        tabBarController?.present(menuScene, animated: true)
    }
}

