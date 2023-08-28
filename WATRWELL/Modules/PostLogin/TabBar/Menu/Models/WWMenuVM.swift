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
//        case source = "SOURCE"
//        case map = "MAP"
//        case discover = "DISCOVER"
        case dailyBenifits = "DAILY BENIFITS"
        case watrGuide = "WATR GUIDE"
        case conusmption = "CONSUMPTION"
//        case profile = "PROFILE"
        case sourceSubscription = "SOURCE SUBSCRIPTION"
        case support = "SUPPORT"
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

