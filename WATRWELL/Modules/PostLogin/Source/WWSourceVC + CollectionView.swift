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
            return viewModel.dataSource.endIndex
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.viewType {
        case .notSubscribed, .modifySubscription:
            return getSelectSourceCell(for: collectionView, cellForItemAt: indexPath)
        case .subscribed:
            return getSelectedSourceCell(for: collectionView, cellForItemAt: indexPath)
        }
    }
    
    private func getSelectSourceCell(for collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> WWSelectSourceCVC {
        let cell = collectionView.dequeueCell(with: WWSelectSourceCVC.self, indexPath: indexPath)
        cell.setData(indexPath.item, viewType: viewModel.viewType)
        cell.paymentSlider.completion = { [weak self, weak cell] in
            let subscriptionType: SubscriptionType = indexPath.item == 0 ? .everything : .onlyElectrolytes
            self?.makePayment(for: subscriptionType)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {[weak cell] in
                cell?.paymentSlider.value = 0
            })
        }
        cell.tapHandler = { [weak self] in
            self?.showDescription(for: indexPath.item)
        }
        
        cell.cancelHandler = { [weak self] in
            self?.showCancelPopUp()
        }
        return cell
    }
    
    private func getSelectedSourceCell(for collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> WWSelectedSourceCVC {
        let cell = collectionView.dequeueCell(with: WWSelectedSourceCVC.self, indexPath: indexPath)
        cell.setData(viewModel.dataSource[indexPath.row])
        cell.showUpdatePopup = { [weak self] in
            self?.showUpdateSubscription()
        }
        
        cell.didSelectHandler = { [weak self] in
            self?.setupTimer(for: indexPath.item)
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / UIScreen.main.bounds.size.width
        switch viewModel.viewType {
        case .notSubscribed, .modifySubscription:
            topPageControl.currentPage = Int(currentPage)
        case .subscribed:
            bottomPageControl.currentPage = Int(currentPage)
        }
    }
}

private extension WWSourceVC {
    func makePayment(for subscription: SubscriptionType) {
        switch viewModel.viewType {
        case .modifySubscription:
            switch WWUserModel.currentUser.subscriptionType {
            case .everything: viewModel.updateSubscription(with: .onlyElectrolytes)
            case .onlyElectrolytes: viewModel.updateSubscription(with: .everything)
            default: break
            }
        case .notSubscribed:
            viewModel.subscriptionType = subscription
            createSubscriptionSubject.onNext(())
        default: break
        }
    }
    
    func showDescription(for item: Int) {
        var incomingCase: WWSourcePopVM.IncomingCase
        if viewModel.viewType == .modifySubscription {
            if WWUserModel.currentUser.subscriptionType == .onlyElectrolytes {
                incomingCase = item == 0 ? .electrolyte : .all
            } else {
                incomingCase = item == 0 ? .all : .electrolyte
            }
        } else {
        incomingCase = item == 0 ? .all : .electrolyte
        }
        let scene = WWSourcePopupVC.create(with: WWSourcePopVM(incomingCase: incomingCase))
        tabBarController?.present(scene, animated: true)
    }
    
    func showCancelPopUp() {
        let cancelScene = WWCancelSubscriptionPopupVC.instantiate(fromAppStoryboard: .Source)
        cancelScene.modalTransitionStyle = .crossDissolve
        cancelScene.modalPresentationStyle = .overFullScreen
        tabBarController?.present(cancelScene, animated: true)
    }
    
    func showUpdateSubscription() {
        let scene = WWSubscriptionPopupVC.create(with: WWSubscriptionPopupVM())
        tabBarController?.present(scene, animated: true)
    }
    
    func setupTimer(for index: Int) {
        viewModel.dataSource[index].isSelected = true
        switch index {
        case 0:
            if timer0.isValid.not() {
                timer0 = Timer.scheduledTimer(timeInterval: 40, target: self, selector: #selector(setSelectedState(_:)), userInfo: nil, repeats: false)
            }
        case 1:
            if timer1.isValid.not() {
                timer1 = Timer.scheduledTimer(timeInterval: 40, target: self, selector: #selector(setSelectedState(_:)), userInfo: nil, repeats: false)
            }
        case 2:
            if timer2.isValid.not() {
                timer2 = Timer.scheduledTimer(timeInterval: 40, target: self, selector: #selector(setSelectedState(_:)), userInfo: nil, repeats: false)
            }
        default: break
        }
        collectionView.reloadData()
    }
    
    @objc func setSelectedState(_ sender: Timer) {
        switch sender {
        case timer0:
            timer0.invalidate()
            viewModel.dataSource[0].isSelected = false
        case timer1:
            timer1.invalidate()
            viewModel.dataSource[1].isSelected = false
        case timer2:
            timer2.invalidate()
            viewModel.dataSource[2].isSelected = false
        default: break
        }
        collectionView.reloadData()
    }

}
