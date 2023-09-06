//
//  WWTutorialVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 07/09/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWTutorialVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var navBarContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Properties
    private let navBar: WWNavBarView = .fromNib()
    let dataSourceImages: [UIImage?] = [UIImage(named: "tt1"),UIImage(named: "tt2"),UIImage(named: "tt3"),UIImage(named: "tt4"),UIImage(named: "tt5")]
    
    // Overriden functions
    override func setupViews() {
        setNavBar()
        setupCollectionView()
    }
}

// MARK: - ViewController life cycle methods
extension WWTutorialVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        navBar.frame = navBarContainerView.bounds
    }
}

private extension WWTutorialVC {
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
        collectionView.registerCell(with: WWTutorialCVC.self)
    }
}

