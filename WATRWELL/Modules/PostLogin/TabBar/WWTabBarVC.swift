//
//  WWTabBarVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit

class WWTabBarVC: UITabBarController {
    
    enum SceneType: Int {
        case source = 0
        case map
        case discover
        case profile
    }
    
    private let initialScene: SceneType
    
    private let backgroundImageView: UIImageView = {
        let bgImageView = UIImageView(image: UIImage(named: "tabbarBG"))
        return bgImageView
    }()
    
    init(with initialScene: SceneType) {
        self.initialScene = initialScene
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Tabbar Item Controllers
    var sourceNavigationController: UINavigationController = {
        let sourceScene = WWSourceVC.instantiate(fromAppStoryboard: .Source)
        let nvc = UINavigationController(rootViewController: sourceScene)
        nvc.tabBarItem = UITabBarItem(title: "Source", image: nil, tag: 0)
        return nvc
    }()
    var mapNavigationController: UINavigationController = {
        let mapScene = WWMapVC.create(with: WWMapVM())
        let nvc = UINavigationController(rootViewController: mapScene)
        nvc.tabBarItem = UITabBarItem(title: "Map", image: nil, tag: 1)
        return nvc
    }()
    var discoverNavigationController: UINavigationController = {
        let discoverScene = WWDiscoverVC.create(with: WWDiscoverVM())
        let nvc = UINavigationController(rootViewController: discoverScene)
        nvc.tabBarItem = UITabBarItem(title: "Discover", image: nil, tag: 2)
        return nvc
    }()
    var profileNavigationController: UINavigationController = {
        let profileScene = WWProfileVC.instantiate(fromAppStoryboard: .Profile)
        let nvc = UINavigationController(rootViewController: profileScene)
        nvc.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 3)
        return nvc
    }()
    
    private let selectedNotifierView: UIView = {
        let dotSize: CGFloat = 8
        let dotView = UIView(frame: CGRect(x: 0, y: 0, width: dotSize, height: dotSize))
        dotView.backgroundColor = WWColors.hexDF5509.color
        dotView.layer.cornerRadius = dotSize / 2
        return dotView
    }()
    
    private var tabBarControllers: [UIViewController] {
        return [sourceNavigationController,
                mapNavigationController,
                discoverNavigationController,
                profileNavigationController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs(initial: initialScene.rawValue)
        tabBar.insertSubview(backgroundImageView, at: 0)
        tabBar.unselectedItemTintColor = WWColors.hexFFFFFF.color
        tabBar.clipsToBounds = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImageView.frame = tabBar.bounds
    }
    
    private func setupTabs(initial index: Int) {
        // Assign the view controllers to the tab bar
        self.viewControllers = tabBarControllers
        
        // Set the tab bar item appearance to show only text
        let tabBarAppearance = UITabBarItem.appearance()
        tabBarAppearance.setTitleTextAttributes([.foregroundColor: WWColors.hexDF5509.color,
                                                 .font: WWFonts.europaRegular.withSize(14)], for: .selected)
        tabBarAppearance.setTitleTextAttributes([.font: WWFonts.europaRegular.withSize(14)], for: .normal)
        
        // Adjust the vertical position of the title for each tab bar item
        for item in self.tabBar.items ?? [] {
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -14)
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        selectedIndex = index
        addDotViewToTabBarItem(atIndex: index)
    }
    
    private func addDotViewToTabBarItem(atIndex index: Int) {
        selectedNotifierView.removeFromSuperview()

        if let tabBarItems = tabBar.items, index < tabBarItems.count {
            // Find the frame of the selected tab bar item using subviews
            let tabWidth = tabBar.bounds.width / CGFloat(tabBarItems.count)
            let selectedFrame = CGRect(x: tabWidth * CGFloat(index), y: 0, width: tabWidth, height: tabBar.bounds.height - view.safeAreaInsets.bottom)
            
            // Position the dot view at the center of the selected tab bar item
            selectedNotifierView.center = CGPoint(x: selectedFrame.midX, y: selectedFrame.height - (selectedNotifierView.bounds.height / 2))
            tabBar.addSubview(selectedNotifierView)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        addDotViewToTabBarItem(atIndex: item.tag)
    }
}