//
//  WWStep1VM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWStep1VM {
    private let disposeBag = DisposeBag()
    let itemRenderer: [ItemType] = ItemType.allCases
    private(set) var dataModel: WWEnlistUserModel = WWEnlistUserModel()
    private let moveToNextSceneSubject = PublishSubject<String>()
    private(set) var isNumberVerified: Bool
    
    init(mobile: String? = nil, isNumberVerified: Bool = false) {
        self.dataModel.mobile = mobile
        self.isNumberVerified = isNumberVerified
    }
}

extension WWStep1VM: WWViewModelProtocol {
    enum ItemType: CaseIterable {
        case logo
        case firstName
        case lastName
        case mobile
        case email
        case next
        case exit
        
        var placeHolder: String {
            switch self{
            case .firstName: return "FIRST NAME"
            case .lastName: return "LAST NAME"
            case .mobile: return "MOBILE NUMBER"
            case .email: return "EMAIL"
            default: return ""
            }
        }
    }
    
    struct Input {
        let shouldInitiateOTPVerification: Observable<Void>
    }
    
    struct Output {
        let moveToNextScene: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        input.shouldInitiateOTPVerification.subscribe(onNext: { [weak self] in
            self?.requestOTP()
        }).disposed(by: disposeBag)
        return Output(moveToNextScene: moveToNextSceneSubject.asDriverOnErrorJustComplete())
    }
    
    func updateData(_ text: String, for item: ItemType) {
        switch item {
        case .firstName:
            dataModel.firstName = text
        case .lastName:
            dataModel.lastName = text
        case .mobile:
            dataModel.mobile = text
        case .email:
            dataModel.email = text
        default: break
        }
    }
}

private extension WWStep1VM {
    func requestOTP() {
        guard verifyDataValidity() else { return }
        requestOTPService()
    }
    
    private func verifyDataValidity() -> Bool {
        if dataModel.firstName == nil {
            SKToast.show(withMessage: "Enter First Name")
            return false
        } else if let fName = dataModel.firstName, fName.checkInvalidity(.Name) {
            SKToast.show(withMessage: "Enter valid First Name")
            return false
        } else if dataModel.lastName == nil {
            SKToast.show(withMessage: "Enter Last Name")
            return false
        } else if let lName = dataModel.lastName, lName.checkInvalidity(.Name) {
            SKToast.show(withMessage: "Enter valid Last Name")
            return false
        } else if dataModel.mobile == nil {
            SKToast.show(withMessage: "Enter Mobile Number")
            return false
        } else if let mobile = dataModel.mobile, mobile.checkInvalidity(.MobileNumber) {
            SKToast.show(withMessage: "Enter valid Mobile Number")
            return false
        } else if dataModel.email == nil {
            SKToast.show(withMessage: "Enter Email Address")
            return false
        } else if let email = dataModel.email, email.checkInvalidity(.Email) {
            SKToast.show(withMessage: "Enter valid Email Address")
            return false
        }
        return true
    }
    
    func requestOTPService() {
        guard let mobile = dataModel.mobile?.simplifyPhoneNumber() else { return }
        WebServices.loginUser(parameters: ["users[phone_number]": mobile], response: { [weak self] response in
            switch response {
            case .success(let id):
                self?.moveToNextSceneSubject.onNext((id))
            case .failure(let err):
                SKToast.show(withMessage: err.localizedDescription)
            }
        })
    }
}


//{
//    addresses =     (
//                {
//            "address_type" = "Shipping-Address";
//            city = asdfasdf;
//            id = 23;
//            state = sdfasdf;
//            street1 = asfadsfasdf;
//            street2 = asdfadsdsf;
//            "zip_code" = 123123;
//        },
//                {
//            "address_type" = "Billing-Address";
//            city = asdf;
//            id = 24;
//            state = arwer;
//            street1 = abcded;
//            street2 = dafasdf;
//            "zip_code" = 123123;
//        }
//    );
//    "payment_informations" =     (
//                {
//            "card_type" = UnionPay;
//            "default_card" = 1;
//            "expiration_month" = 11;
//            "expiration_year" = 2089;
//            id = 4;
//            "last_4" = 7766;
//            "name_on_card" = cardName;
//        }
//    );
//    user =     {
//        "bt_customer_id" = 51765761771;
//        "created_at" = "2023-08-29T08:49:17.103Z";
//        email = "sahil.pruthi@techqware.com";
//        "first_name" = Sahil;
//        id = 14;
//        "last_name" = Pruthi;
//        otp = "<null>";
//        "phone_number" = 1234567899;
//        "profile_picture" = "<null>";
//        status = Active;
//        "updated_at" = "2023-08-30T15:54:24.652Z";
//        weight = 10;
//    };
//}
