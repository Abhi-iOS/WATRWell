//
//  Webservice+Consumption.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 18/09/23.
//

import Foundation
extension WebServices {
    static func getConsumption(response : @escaping ((Result<WWDailyConsumptionDataModel, Error>) ->())) {
        commonGetAPI(parameters: ["comsumption_date":Date().currentFormattedDate()], endPoint: .myConsumption, loader: false) { result in
            switch result {
            case .success(let data):
                if let json = data["data"].arrayValue.first, let data = try? json.rawData() {
                    let consumption = try! JSONDecoder().decode(WWDailyConsumptionDataModel.self, from: data)
                    response(.success(consumption))
                } else {
                    response(.failure(NSError(localizedDescription: "Something Went Wrong")))
                }
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
}
