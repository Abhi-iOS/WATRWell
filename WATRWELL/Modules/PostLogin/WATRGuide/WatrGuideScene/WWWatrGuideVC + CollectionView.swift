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
        if indexPath.item != 0 {
            cell.leftTitle1Label.textAlignmentOverride = .right
            cell.leftTitle2Label.textAlignmentOverride = .right
            cell.leftTitle3Label.textAlignmentOverride = .right
        } else {
            cell.leftTitle1Label.textAlignmentOverride = .natural
            cell.leftTitle2Label.textAlignmentOverride = .natural
            cell.leftTitle3Label.textAlignmentOverride = .natural
        }
        cell.viewDiscHandler = { [weak self] in
            self?.goToDetailView(for: indexPath.item)
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / UIScreen.main.bounds.size.width
        if self.lastContentOffset.x > scrollView.contentOffset.x {
            pageControl.currentPage = Int(ceil(currentPage))
        } else if self.lastContentOffset.x < scrollView.contentOffset.x {
            pageControl.currentPage = Int(floor(currentPage))
        }
        self.lastContentOffset.x = scrollView.contentOffset.x
        switch pageControl.currentPage {
        case 0: navBar.logoImageView.tintColor = WWColors.hex203D75.color
        case 1: navBar.logoImageView.tintColor = WWColors.hexDF5509.color
        case 2: navBar.logoImageView.tintColor = WWColors.hexB3E6B5.color
        default: break
        }
    }
}

private extension WWWatrGuideVC {
    func goToDetailView(for index: Int) {
        let popupScene = WWWatrGuidePopUpVC.create(with: WWWatrGuidePopUpVM(imageName: "popup\(index+1)"))
        tabBarController?.present(popupScene, animated: true)
    }
}
