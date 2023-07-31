//
//  WWSourceVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWSourceVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var navContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topPageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomPageControl: UIPageControl!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var sourceTop: NSLayoutConstraint!
    
    // Properties
    private(set) var viewModel: WWSourceVM!
    private let navBar: WWNavBarView = .fromNib()
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setNavBar()
        setupScreenContent()
        setupCollectionView()
    }
}

// MARK: - WWControllerType
extension WWSourceVC: WWControllerType {

    static func create(with viewModel: WWSourceVM) -> UIViewController {
        let sourceScene = WWSourceVC.instantiate(fromAppStoryboard: .Source)
        sourceScene.viewModel = viewModel
        return sourceScene
    }

    func configure(with viewModel: WWSourceVM){

    }
}

// MARK: - ViewController life cycle methods
extension WWSourceVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        navBar.frame = navContainerView.bounds
        if viewModel.viewType == .notSubscribed, WWDeviceDetail.model == .Regular {
            navHeight.constant = 44
            sourceTop.constant = 0
        }
    }
}

private extension WWSourceVC {
    func setupScreenContent() {
        switch viewModel.viewType {
        case .notSubscribed:
            titleLabel.text = "SELECT YOUR WATR SOURCE"
            bottomPageControl.isHidden = true
        case .subscribed:
            titleLabel.text = "YOUR WATR SOURCE"
            topPageControl.isHidden = false

        }
    }
    
    func setNavBar(){
        navContainerView.addSubview(navBar)
        navBar.shouldHideLogoImage(viewModel.viewType == .notSubscribed)
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
        collectionView.registerCell(with: WWSelectSourceCVC.self)
        collectionView.registerCell(with: WWSelectedSourceCVC.self)
    }
    
    func showMenu() {
        let menuScene = WWMenuVC.create(with: WWMenuVM())
        tabBarController?.present(menuScene, animated: true)
    }
}

