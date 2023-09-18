//
//  WWConsumptionOnboardingVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWConsumptionOnboardingVM {
    private let disposeBag = DisposeBag()
    private let weightUpdateSubject = PublishSubject<String>()
    private let goNextSubject = PublishSubject<Void>()
    var pickerType = PickerType.day
    
    var selectedDay: String?
    var selectedMonth: String?
    var selectedYear: String?
    
    private let datesArray: [String] = {
        var datesArray: [String] = ["-"]
        for date in 1...31 {
            let formattedDate = String(format: "%02d", date)
            datesArray.append(formattedDate)
        }
        return datesArray
    }()
    
    private let monthsArray: [String] = {
        var monthsArray: [String] = ["-","January","Febrary","March","April","May","June","July","August","September","October","November","December"]

        for month in monthsArray {
            monthsArray.append(month.uppercased())
        }
        return monthsArray
    }()
    private let yearsArray: [String] = {
        var yearsArray: [String] = ["-"]
        var startYear = Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year ?? 0
        var endYear = startYear - 80
        for year in stride(from: startYear, to: endYear, by: -1) {
            yearsArray.append("\(year)")
        }
        return yearsArray
    }()
    
    var dataSource: [String] {
        switch pickerType {
        case .year: return yearsArray
        case .month: return monthsArray
        case .day: return datesArray
        }
    }
}

extension WWConsumptionOnboardingVM: WWViewModelProtocol {
    enum PickerType {
        case day
        case month
        case year
    }
    
    struct Input {
        let weightUpdate: Observable<Float>
        let completeTap: Observable<Void>
    }
    
    struct Output {
        let weightLabelText: Observable<String>
        let goToNext: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        input.weightUpdate.subscribe(onNext: { [weak self] weight in
            guard let self else { return }
            let weight = Int(ceilf(weight))
            self.weightUpdateSubject.onNext("\(weight) LBS")
        }).disposed(by: disposeBag)
        
        input.completeTap.subscribe(onNext: { [weak self] in
            self?.saveOnboardingInfo()
        }).disposed(by: disposeBag)
        
        return Output(weightLabelText: weightUpdateSubject.asObservable(),
                      goToNext: input.completeTap.asDriverOnErrorJustComplete())
    }
    
    func updatePickerData(_ string: String) {
        switch pickerType {
        case .year: selectedYear = string
        case .month: selectedMonth = string
        case .day: selectedDay = string
        }
    }
}

private extension WWConsumptionOnboardingVM {
    func saveOnboardingInfo() {
        WebServices.enlistUserData(parameters: WWUserModel.currentUser.parameters, userId: WWUserModel.currentUser.id) { response in
            switch response {
            case .success(_): break
            case .failure(_): break
            }
        }
    }
}

