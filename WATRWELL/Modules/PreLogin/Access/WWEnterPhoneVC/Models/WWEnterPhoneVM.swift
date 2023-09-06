//
//  WWEnterPhoneVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWEnterPhoneVM {
    enum IncomingCase {
        case access
        case updateNumber
        
        var title: String {
            switch self {
            case .access: return "Please enter your mobile phone #:".uppercased()
            case .updateNumber: return "Please enter your new mobile phone #:".uppercased()
            }
        }
    }
    
    private(set) var mobileNumber: String = ""
    private let proceedToOTPSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    let incomingCase: IncomingCase
    let id: String?
    
    init(incomingCase: IncomingCase = .access, userId: String? = nil) {
        self.incomingCase = incomingCase
        self.id = userId
    }
}

extension WWEnterPhoneVM: WWViewModelProtocol {
    struct Input {
        let userMobileNumber: Observable<String>
        let didTapAccess: Observable<Void>
        let didTapExit: Observable<Void>
    }
    
    struct Output {
        let accessGranted: Driver<String>
        let popScreen: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        input.userMobileNumber.subscribe(onNext: { [weak self] text in
            self?.mobileNumber = text
        }).disposed(by: disposeBag)
        
        input.didTapAccess.subscribe(onNext: { [weak self] in
            self?.validateNumber()
        }).disposed(by: disposeBag)
        
        return Output(accessGranted: proceedToOTPSubject.asDriverOnErrorJustComplete(),
               popScreen: input.didTapExit.asDriverOnErrorJustComplete())
    }
}

private extension WWEnterPhoneVM {
    func validateNumber() {
        guard mobileNumber.isEmpty.not() else {
            SKToast.show(withMessage: "Please enter mobile number")
            return
        }
        
        if mobileNumber.checkValidity(.MobileNumber) {
            if let id {
                requestOTPForNumberUpdate(with: id)
            } else {
                requestOTP()
            }
        } else {
            SKToast.show(withMessage: "Please enter valid mobile number")
        }
    }
    
    func requestOTP() {
        WebServices.loginUser(parameters: ["users[phone_number]": mobileNumber.simplifyPhoneNumber()], response: { [weak self] response in
            switch response {
            case .success(let id):
                self?.proceedToOTPSubject.onNext((id))
            case .failure(let err):
                SKToast.show(withMessage: err.localizedDescription)
            }
        })
    }
    
    func requestOTPForNumberUpdate(with id: String) {
        WebServices.resendOTP(parameters: ["id": id]) { [weak self] response in
            switch response {
            case .success(_):
                self?.proceedToOTPSubject.onNext(id)
            case .failure(let err):
                SKToast.show(withMessage: err.localizedDescription)
            }
        }
    }
}
