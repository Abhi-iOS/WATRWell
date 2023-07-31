//
//  DailyBenifitsMasterVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class DailyBenifitsMasterVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var navContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // Properties
    private(set) var viewModel: DailyBenifitsMasterVM!
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
extension DailyBenifitsMasterVC: WWControllerType {
    
    static func create(with viewModel: DailyBenifitsMasterVM) -> UIViewController {
        let dailyBenifitsMasterScene = DailyBenifitsMasterVC.instantiate(fromAppStoryboard: .Misc)
        dailyBenifitsMasterScene.viewModel = viewModel
        return dailyBenifitsMasterScene
    }
    
    func configure(with viewModel: DailyBenifitsMasterVM){
        let input = DailyBenifitsMasterVM.Input()
        
        let output = viewModel.transform(input: input)
    }
}

//MARK: - View life cycle
extension DailyBenifitsMasterVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        navBar.frame = navContainerView.bounds
    }
}

//MARK: - Private functions
private extension DailyBenifitsMasterVC {
    func setNavBar(){
        navContainerView.addSubview(navBar)
        view.layoutIfNeeded()
        navBar.shouldHideBackButton(viewModel.sceneType == .master)
        navBar.shareDidTap = { [weak self] in
            self?.showMenu()
        }
        
        navBar.backDidTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
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
        collectionView.registerCell(with: WWDailyBenifitsCVC.self)
    }
    
    func showMenu() {
        let menuScene = WWMenuVC.create(with: WWMenuVM())
        tabBarController?.present(menuScene, animated: true)
    }
}
