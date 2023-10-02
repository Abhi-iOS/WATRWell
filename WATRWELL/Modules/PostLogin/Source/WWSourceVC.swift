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
    let createSubscriptionSubject = PublishSubject<Void>()
    var timer0 = Timer()
    var timer1 = Timer()
    var timer2 = Timer()
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setNavBar()
        setupScreenContent()
        setupCollectionView()
    }
    
    deinit {
        timer0.invalidate()
        timer1.invalidate()
        timer2.invalidate()
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
        let input = WWSourceVM.Input(createSubscription: createSubscriptionSubject.asObserver())
        
        let output = viewModel.transform(input: input)
        
        output.reloadOnSubscription.drive(onNext: { [weak self] in
            self?.reloadOnSubscriptionComplete()
        }).disposed(by: rx.disposeBag)
        
        output.resetTabbar.drive(onNext: { _ in
            WWRouter.shared.setTabbarAsRoot(sourceType: .subscribed)
        }).disposed(by: rx.disposeBag)
        
        output.showPopup.drive(onNext: { [weak self] _ in
            self?.showPopup()
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWSourceVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        navBar.frame = navContainerView.bounds
    }
}

private extension WWSourceVC {
    func setupScreenContent() {
        switch viewModel.viewType {
        case .notSubscribed:
            titleLabel.text = "SELECT YOUR SOURCE SUBSCRIPTION"
            bottomPageControl.isHidden = true
            topPageControl.isHidden = false
        case .subscribed:
            titleLabel.text = "YOUR SOURCE"
            topPageControl.isHidden = true
            bottomPageControl.isHidden = viewModel.dataSource.endIndex < 2
        case .modifySubscription:
            titleLabel.text = "Manage\nYour Current Source Subscriptions".uppercased()
            bottomPageControl.isHidden = true
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
    
    func showPopup() {
        let popupScene = WWPreSourcePopUpVC.instantiate(fromAppStoryboard: .Source)
        popupScene.modalTransitionStyle = .crossDissolve
        popupScene.modalPresentationStyle = .overFullScreen
        tabBarController?.present(popupScene, animated: true)
    }
    
    func reloadOnSubscriptionComplete() {
        setupScreenContent()
        collectionView.reloadData()
    }
}

