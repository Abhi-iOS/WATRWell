//
//  WWDailyConsumptionVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWDailyConsumptionVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var navBarContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // Properties
    private(set) var viewModel: WWDailyConsumptionVM!
    private let navBar: WWNavBarView = .fromNib()
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setNavBar()
        setupCollectionView()
        pageControl.numberOfPages = viewModel.dataSource.endIndex
    }
}

// MARK: - WWControllerType
extension WWDailyConsumptionVC: WWControllerType {
    
    static func create(with viewModel: WWDailyConsumptionVM) -> UIViewController {
        let dailyConsumptionScene = WWDailyConsumptionVC.instantiate(fromAppStoryboard: .Misc)
        dailyConsumptionScene.viewModel = viewModel
        return dailyConsumptionScene
    }
    
    func configure(with viewModel: WWDailyConsumptionVM){
        
    }
}

// MARK: - ViewController life cycle methods
extension WWDailyConsumptionVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        navBar.frame = navBarContainerView.bounds
    }
}

private extension WWDailyConsumptionVC {
    func setNavBar(){
        navBarContainerView.addSubview(navBar)
        view.layoutIfNeeded()
        navBar.shareDidTap = { [weak self] in
            self?.showMenu()
        }
    }
    
    func showMenu() {
        let menuScene = WWMenuVC.create(with: WWMenuVM())
        tabBarController?.present(menuScene, animated: true)
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = .zero
        collectionViewLayout.minimumInteritemSpacing = .zero
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.registerCell(with: WWDailyConsumptionCVC.self)
    }
}

