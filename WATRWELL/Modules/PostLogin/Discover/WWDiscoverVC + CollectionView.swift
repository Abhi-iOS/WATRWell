//
//  WWDiscoverVC + CollectionView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import UIKit

extension WWDiscoverVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.endIndex + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueCell(with: WWDiscoverIntentCVC.self, indexPath: indexPath)
            return cell
        default:
            let item = viewModel.dataSource[indexPath.item - 1]
            let cell = collectionView.dequeueCell(with: WWDiscoverInfoTextCVC.self, indexPath: indexPath)
            cell.setData(with: item)
            cell.clickTapHandler = { [weak self] in
                self?.goToDetailView(for: indexPath.item)
            }
            return cell

        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / UIScreen.main.bounds.size.width
        pageControl.currentPage = Int(currentPage)
    }
}

private extension WWDiscoverVC {
    func goToDetailView(for index: Int) {
        var image: UIImage?
        switch index {
        case 1: image = UIImage(named: "willo_poupup")
        case 2: image = UIImage(named: "cactus_popup")
        default: break
        }
        let popUpScene = WWDiscoverPopupVC.create(with: image)
        tabBarController?.present(popUpScene, animated: true)
    }
}

