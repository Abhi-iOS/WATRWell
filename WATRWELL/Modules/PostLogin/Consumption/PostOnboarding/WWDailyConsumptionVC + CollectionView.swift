//
//  WWDailyConsumptionVC + CollectionView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import UIKit

extension WWDailyConsumptionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.endIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: WWDailyConsumptionCVC.self, indexPath: indexPath)
        cell.setData(viewModel.dataSource[indexPath.item])
        cell.infoButtonTap = { [weak self] in
            self?.showDailyConsumptionPopUP()
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(currentPage)
    }
}

private extension WWDailyConsumptionVC {
    func showDailyConsumptionPopUP() {
        let scene = DailyConsumptionPopUpVC.create()
        tabBarController?.present(scene, animated: true)
    }
}
