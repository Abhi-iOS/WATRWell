//
//  WWSourceVC + CollectionView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 01/08/23.
//

import UIKit

extension WWSourceVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.viewType == .subscribed {
            return 3
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.viewType {
        case .notSubscribed:
            return getSelectSourceCell(for: collectionView, cellForItemAt: indexPath)
        case .subscribed:
            return getSelectedSourceCell(for: collectionView, cellForItemAt: indexPath)
        }
    }
    
    private func getSelectSourceCell(for collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> WWSelectSourceCVC {
        let cell = collectionView.dequeueCell(with: WWSelectSourceCVC.self, indexPath: indexPath)
        cell.setData(indexPath.item)
        cell.paymentSlider.completion = { [weak self] in
            self?.makePayment()
        }
        return cell
    }
    
    private func getSelectedSourceCell(for collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> WWSelectedSourceCVC {
        let cell = collectionView.dequeueCell(with: WWSelectedSourceCVC.self, indexPath: indexPath)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / UIScreen.main.bounds.size.width
        switch viewModel.viewType {
        case .notSubscribed:
            topPageControl.currentPage = Int(currentPage)
        case .subscribed:
            bottomPageControl.currentPage = Int(currentPage)
        }
    }
}

private extension WWSourceVC {
    func makePayment() {
        
    }
}
