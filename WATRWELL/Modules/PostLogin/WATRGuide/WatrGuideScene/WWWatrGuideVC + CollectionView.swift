//
//  WWWatrGuideVC + CollectionView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import UIKit

extension WWWatrGuideVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.endIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: WWWatrGuideCVC.self, indexPath: indexPath)
        cell.setData(with: viewModel.dataSource[indexPath.item], index: indexPath.item)
        cell.viewDiscHandler = { [weak self] in
            self?.goToDetailView(for: indexPath.item)
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / UIScreen.main.bounds.size.width
        pageControl.currentPage = Int(currentPage)
    }
}

private extension WWWatrGuideVC {
    func goToDetailView(for index: Int) {
        let popupScene = WWWatrGuidePopUpVC.create(with: WWWatrGuidePopUpVM())
        tabBarController?.present(popupScene, animated: true)
    }
}
