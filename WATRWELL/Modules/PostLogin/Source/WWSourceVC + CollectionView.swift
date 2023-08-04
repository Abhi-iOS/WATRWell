//
//  WWSourceVC + CollectionView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 01/08/23.
//

import UIKit
import BraintreeDropIn
import Braintree

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
        cell.paymentSlider.completion = { [weak self, weak cell] in
            self?.makePayment()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {[weak cell] in
                cell?.paymentSlider.value = 0
            })
        }
        cell.tapHandler = { [weak self] in
            self?.showDescription(for: indexPath.item)
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
        showDropIn(clientTokenOrTokenizationKey: WWGlobals.brainTreeAuthorization)
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                // result.<SDKMatcher sdk="ios:v4">paymentOptionType</SDKMatcher><SDKMatcher sdk="ios:v5">paymentMethodType</SDKMatcher>
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    func showDescription(for item: Int) {
        let incomingCase: WWSourcePopVM.IncomingCase = item == 0 ? .all : .electrolyte
        let scene = WWSourcePopupVC.create(with: WWSourcePopVM(incomingCase: incomingCase))
        tabBarController?.present(scene, animated: true)
    }

}
