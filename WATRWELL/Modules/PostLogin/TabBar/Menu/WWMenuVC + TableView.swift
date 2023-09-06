//
//  WWMenuVC + TableView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import UIKit

extension WWMenuVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceItems.endIndex
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.dataSourceItems[indexPath.row]
        switch item {
        case .logo:
            let cell = tableView.dequeueCell(with: WWLogoTVC.self, indexPath: indexPath)
            cell.setData(item.elementValue.image)
            return cell
        case .exit, .instagram:
            let cell = tableView.dequeueCell(with: WWVerticalButtonTVC.self, indexPath: indexPath)
            cell.setData(item.elementValue.text,
                         item.elementValue.image)
            cell.tapHandler = { [weak self] in
                guard let self else { return }
                self.cellTapAction(for: item)
            }
            return cell
        default:
            let cell = tableView.dequeueCell(with: WWSingleLabelTVC.self, indexPath: indexPath)
            cell.setData(item.elementValue.text)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.dataSourceItems[indexPath.row]
        switch item {
        case .exit, .instagram:
            break
        default:
            cellTapAction(for: item)
        }
    }
}

private extension WWMenuVC{
    func cellTapAction(for item: WWMenuVM.DataSourceElements) {
        if item != .exit || item != .instagram {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tabbarReset"), object: nil)
        }
        switch item {
        case .logo:
            return
        case .tutorial:
            showTutorial()

        case .dailyBenifits:
            showDailyBenifits()
            
        case .watrGuide:
            showWatrGuide()
            
        case .conusmption:
            showConsumption()

        case .sourceSubscription:
            showSourceSubscription()
            
        case .support:
            showSupport()
            
        case .exit:
            dismiss(animated: true)
            
        case .instagram:
            shareToIG()
        }
    }
    
    func shareToIG() {
        
    }
    
    func showConsumption() {
        dismiss(animated: true) {
            let consumptionOnboardingScene = WWConsumptionOnboardingVC.create(with: WWConsumptionOnboardingVM())
            sharedAppDelegate.window?.currentViewController?.navigationController?.pushViewController(consumptionOnboardingScene, animated: true)
        }
    }
    
    func showWatrGuide() {
        dismiss(animated: true) {
            let watrGuideScene = WWWatrGuideVC.create(with: WWWatrGuideVM())
            sharedAppDelegate.window?.currentViewController?.navigationController?.pushViewController(watrGuideScene, animated: true)
        }
    }
    
    func showDailyBenifits() {
        dismiss(animated: true) {
            let dailyBenefitsScene = DailyBenifitsMasterVC.create(with: DailyBenifitsMasterVM(sceneType: .master, category: nil))
            sharedAppDelegate.window?.currentViewController?.navigationController?.pushViewController(dailyBenefitsScene, animated: true)
        }
    }
    
    func showSupport() {
        dismiss(animated: true) {
            let dailyBenefitsScene = WWSupportVC.instantiate(fromAppStoryboard: .Misc)
            sharedAppDelegate.window?.currentViewController?.navigationController?.pushViewController(dailyBenefitsScene, animated: true)
        }
    }
    
    func showSourceSubscription() {
        dismiss(animated: true) {
            if let _ = WWUserDefaults.value(forKey: .subscriptionId).int {
                let sourceSubscriptionScene = WWSourceVC.create(with: WWSourceVM(viewType: .modifySubscription))
                sharedAppDelegate.window?.currentViewController?.navigationController?.pushViewController(sourceSubscriptionScene, animated: true)
            } else {
                SKToast.show(withMessage: "NO SUBSCRIPTIONS FOUND")
                return
            }
        }
    }
    
    func showTutorial() {
        dismiss(animated: true) {
            let tutorialScene = WWTutorialVC.instantiate(fromAppStoryboard: .Misc)
            sharedAppDelegate.window?.currentViewController?.navigationController?.pushViewController(tutorialScene, animated: true)
        }
    }
    
}
