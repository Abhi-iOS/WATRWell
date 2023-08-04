//
//  WWEnterOTPVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWEnterOTPVM {
    private let disposeBag = DisposeBag()
    private var otp: String = ""
    private let id: String
    private let verificationSuccessSubject = PublishSubject<Void>()
    
    // Timer Setup
    private var timer = Timer()
    private var counter = 30 // in seconds, timer counter for resend otp
    private let updatedTimeSubject = PublishSubject<String>()
    private let hideResendSubject = PublishSubject<Bool>()
    let incomingCase: IncomingCase
    var isOnce: Bool = false
    init(id: String, incomingCase: IncomingCase) {
        self.id = id
        self.incomingCase = incomingCase
        setupTimer()
    }
}

extension WWEnterOTPVM: WWViewModelProtocol {
    enum IncomingCase {
        case access
        case enlist
    }
    
    struct Input {
        let otpTextInput: Observable<String>
        let resendDidTap: Observable<Void>
        let exitDidTap: Observable<Void>
    }
    
    struct Output {
        let updatedTimerValue: Observable<String>
        let hideResendButton: Observable<Bool>
        let otpVerificationSuccess: Driver<Void>
        let editMobileNumber: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        input.otpTextInput.subscribe(onNext: { [weak self] otp in
            guard let self else { return }
            self.otp = otp
            if otp.count == 6, self.isOnce.not() {
                self.isOnce = true
                self.verifyOTP()
            } else {
                self.isOnce = false
            }
        }).disposed(by: disposeBag)
        
        input.resendDidTap.subscribe(onNext: { [weak self] in
            self?.resendOTP()
        }).disposed(by: disposeBag)
        
        return Output(updatedTimerValue: updatedTimeSubject.asObservable(),
                      hideResendButton: hideResendSubject.asObservable(),
                      otpVerificationSuccess: verificationSuccessSubject.asDriverOnErrorJustComplete(),
                      editMobileNumber: input.exitDidTap.asDriverOnErrorJustComplete())
    }
}

private extension WWEnterOTPVM {
    //MARK: - Timer Setup
    func setupTimer(){
        counter = 30
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)
        hideResendSubject.onNext(true)
    }
    
    @objc private func countDownTimer(){
        if counter > 1 {
            counter -= 1
            if counter > 9 {
                let string = "resend verification code (00:\(counter))"
                updatedTimeSubject.onNext(string)
            }else {
                let string = "resend verification code (00:0\(counter))"
                updatedTimeSubject.onNext(string)
            }
        } else {
            timer.invalidate()
            let string = "resend verification code"
            updatedTimeSubject.onNext(string)
            hideResendSubject.onNext(false)
        }
    }

    //MARK: - API call
    func resendOTP() {
        WebServices.resendOTP(parameters: ["id": id]) { response in
            switch response {
            case .success(_): break
            case .failure(_): break
            }
        }
        setupTimer()
    }
    
    func verifyOTP() {
        WebServices.validateUserOTP(parameters: ["otp": otp, "id": id]) { [weak self] response in
            switch response {
            case .success(let data):
                self?.verificationSuccessSubject.onNext(())
                print(data)
            case .failure(_): break
            }
        }
    }
}
