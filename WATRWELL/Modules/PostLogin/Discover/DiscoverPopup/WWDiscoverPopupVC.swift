//
//  WWDiscoverPopupVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWDiscoverPopupVC: WWBaseVC {
    
    enum IncomingCase {
        case willo
        case cactus
        
        var contentImages: [UIImage?] {
            switch self {
            case .cactus: return [UIImage(named: "willo_1"),
                                  UIImage(named: "willo_2")]
                
            case .willo: return [UIImage(named: "cactus_2"),
                                  UIImage(named: "cactus_1")]
            }
        }
        
        var outletTitleImage: UIImage? {
            switch self {
            case .willo: return UIImage(named: "willo_title")
            case .cactus: return UIImage(named: "cactus_title")
            }
        }
        
        var outletBottomImage: UIImage? {
            switch self {
            case .willo: return UIImage(named: "discover_willo")
            case .cactus: return UIImage(named: "discover_cactus")
            }
        }
    }
    
    // Outlets
    @IBOutlet weak var outletTypeImageView: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var outletTypeBottomImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var popupCloseButton: UIButton!
    
    // Properties
    private var incomingCase: IncomingCase!
    
    // Overriden functions
    override func setupViews() {
        outletTypeImageView.image = incomingCase.outletTitleImage
        outletTypeBottomImageView.image = incomingCase.outletBottomImage
        pageControl.numberOfPages = incomingCase.contentImages.endIndex
        setupCollectionView()
    }
    
    @IBAction private func closePopupTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - WWControllerType
extension WWDiscoverPopupVC {
    static func create(with incomingCase: IncomingCase) -> UIViewController {
        let discoverPopup = WWDiscoverPopupVC.instantiate(fromAppStoryboard: .Discover)
        discoverPopup.modalPresentationStyle = .overFullScreen
        discoverPopup.modalTransitionStyle = .crossDissolve
        discoverPopup.incomingCase = incomingCase
        return discoverPopup
    }
}

// MARK: - ViewController life cycle methods
extension WWDiscoverPopupVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

private extension WWDiscoverPopupVC {
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = .zero
        collectionViewLayout.minimumInteritemSpacing = .zero
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = .zero
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.registerCell(with: WWDiscoverPopUpCVC.self)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension WWDiscoverPopupVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return incomingCase.contentImages.endIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: WWDiscoverPopUpCVC.self, indexPath: indexPath)
        cell.discoverImageView.image = incomingCase.contentImages[indexPath.item]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width
        pageControl.currentPage = Int(currentPage)
    }
}
