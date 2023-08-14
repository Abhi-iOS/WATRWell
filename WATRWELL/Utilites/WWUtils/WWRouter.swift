//
//  WWRouter.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit

struct WWRouter {
    static let shared = WWRouter()
    
    private init() {}
    
    func setRootScene() {
        if WWUserDefaults.value(forKey: .isLoggedIn).boolValue {
            setTabbarAsRoot(initialItem: .source, sourceType: .notSubscribed)
        } else {
            setLandingScene()
        }
    }
    
    func setSplashScene() {
        let splashVideoScene = WWSplashVC.instantiate(fromAppStoryboard: .AppLanding)
        let navigationController = UINavigationController(rootViewController: splashVideoScene)
        setRoot(viewController: navigationController)
    }
    
    func setLandingScene() {
        let splashVideoScene = WWLandingVC.create(with: WWLandingVM())
        let navigationController = UINavigationController(rootViewController: splashVideoScene)
        setRoot(viewController: navigationController)
    }
    
    func setTabbarAsRoot(initialItem: WWTabBarVC.SceneType = .source, sourceType: WWSourceVM.IncomingCase? = nil) {
        let tabbarScene = WWTabBarVC(with: initialItem, sourceType: sourceType)
        let navigationController = UINavigationController(rootViewController: tabbarScene)
        navigationController.isNavigationBarHidden = true
        setRoot(viewController: navigationController)
    }
}

private extension WWRouter {
    func setRoot(viewController: UIViewController?){
          sharedAppDelegate.window?.rootViewController = viewController
          sharedAppDelegate.window?.makeKeyAndVisible()
    }
}
