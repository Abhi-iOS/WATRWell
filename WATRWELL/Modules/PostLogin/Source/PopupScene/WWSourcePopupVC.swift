//
//  WWSourcePopupVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 04/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWSourcePopupVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var closeButton: WWVerticalImageTextButton!
    
    // Properties
    private(set) var viewModel: WWSourcePopVM!
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setupCollectionView()
        pageControl.numberOfPages = viewModel.dataModel.endIndex
    }
}

// MARK: - WWControllerType
extension WWSourcePopupVC: WWControllerType {
    
    static func create(with viewModel: WWSourcePopVM) -> UIViewController {
        let sourcePopUpScene = WWSourcePopupVC.instantiate(fromAppStoryboard: .Source)
        sourcePopUpScene.viewModel = viewModel
        sourcePopUpScene.modalTransitionStyle = .crossDissolve
        sourcePopUpScene.modalPresentationStyle = .overFullScreen
        return sourcePopUpScene
    }
    
    func configure(with viewModel: WWSourcePopVM){
        closeButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWSourcePopupVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

private extension WWSourcePopupVC {
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = .zero
        collectionViewLayout.minimumInteritemSpacing = .zero
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.registerCell(with: WWSourcePopupCVC.self)
    }
}

