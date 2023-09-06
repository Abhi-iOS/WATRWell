//
//  WWMenuVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 28/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWMenuVM {
    private let disposeBag = DisposeBag()
    private(set) var dataSourceItems = DataSourceElements.allCases
}

extension WWMenuVM: WWViewModelProtocol {
    enum DataSourceElements: String, CaseIterable {
        case logo
        case tutorial = "HOW IT WORKS"
        case dailyBenifits = "DAILY BENEFITS"
        case watrGuide = "WATR GUIDE"
        case conusmption = "CONSUMPTION"
        case sourceSubscription = "SOURCE SUBSCRIPTION"
        case support = "CARE TEAM"
        case exit = "EXIT"
        case instagram
        
        var elementValue: (text: String?, image: UIImage?) {
            switch self {
            case .logo: return (nil, UIImage(named: "logo-latest 1"))
            case .instagram: return (nil, UIImage(named: "Instagram"))
            case .exit: return (rawValue, UIImage(named: "Cancel"))
            default: return (rawValue, nil)
            }
        }
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}

