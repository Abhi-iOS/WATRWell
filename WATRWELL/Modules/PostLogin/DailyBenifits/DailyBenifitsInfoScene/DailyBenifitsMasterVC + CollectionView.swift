//
//  DailyBenifitsMasterVC + CollectionView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import UIKit

extension DailyBenifitsMasterVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.endIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: WWDailyBenifitsCVC.self, indexPath: indexPath)
        cell.setData(with: viewModel.dataSource[indexPath.item])
        if viewModel.sceneType == .child {
            cell.stackView.spacing = 50
        }
        cell.centerPositionConstraint?.isActive = viewModel.sceneType == .child
        cell.goNexthandler = { [weak self] in
            self?.goToDetailView(for: indexPath.item)
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / UIScreen.main.bounds.size.width
        pageControl.currentPage = Int(currentPage)
    }
}

private extension DailyBenifitsMasterVC {
    func goToDetailView(for index: Int) {
        guard let category = DailyBenifitsMasterVM.BenifitsMasterCategory(rawValue: index) else { return }
        let detailScene = DailyBenifitsMasterVC.create(with: DailyBenifitsMasterVM(sceneType: .child, category: category))
        navigationController?.pushViewController(detailScene, animated: true)
    }
}
