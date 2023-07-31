//
//  WWMenuVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 28/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWMenuVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var copyWriteLabel: WWLabel!
    @IBOutlet weak var privacyButton: WWVerticalImageTextButton!
    @IBOutlet weak var legalButton: WWVerticalImageTextButton!
    @IBOutlet weak var appendingLabel: WWLabel!
    
    // Properties
    private(set) var viewModel: WWMenuVM!
    
    // Overriden functions
    override func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        registerTableCells()
        privacyButton.normalTitleColor = WWColors.hexFFFFFF.color
        legalButton.normalTitleColor = WWColors.hexFFFFFF.color
        privacyButton.font = WWFonts.europaLight.withSize(12)
        legalButton.font = WWFonts.europaLight.withSize(12)
        configure(with: viewModel)
    }
}

// MARK: - WWControllerType
extension WWMenuVC: WWControllerType {
    
    static func create(with viewModel: WWMenuVM) -> UIViewController {
        let menuScene = WWMenuVC.instantiate(fromAppStoryboard: .Tabbar)
        menuScene.modalPresentationStyle = .overFullScreen
        menuScene.modalTransitionStyle = .crossDissolve
        menuScene.viewModel = viewModel
        return menuScene
    }
    
    func configure(with viewModel: WWMenuVM){
        
    }
}

private extension WWMenuVC {
    func registerTableCells() {
        tableView.registerCell(with: WWLogoTVC.self)
        tableView.registerCell(with: WWSingleLabelTVC.self)
        tableView.registerCell(with: WWVerticalButtonTVC.self)
    }
}

