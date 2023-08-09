//
//  WWSourcePopupVC + CollectionView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 04/08/23.
//

import UIKit

extension WWSourcePopupVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataModel.endIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: WWSourcePopupCVC.self, indexPath: indexPath)
        cell.setupData(with: viewModel.dataModel[indexPath.item])
        cell.descLabel.textAlignmentOverride = indexPath.item == 0 ? .center : .justified
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(currentPage)
    }
}
