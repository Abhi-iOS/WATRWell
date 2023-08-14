//
//  Webservices + Map.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 15/08/23.
//

import Foundation

extension WebServices {
    static func getAllOutlets(response : @escaping ((Result<[WWOutletData],Error>) ->())) {
        commonGetAPI(parameters: [:], endPoint: .outlets) { result in
            switch result {
            case .success(let json):
                let outletData = try! json["outlets"].rawData()
                let outletListing = try! JSONDecoder().decode([WWOutletData].self, from: outletData)
                response(.success((outletListing)))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    static func getOutletDetail(for id: Int, response : @escaping ((Result<[WWOutletWatrSource],Error>) ->())) {
        commonGetAPI(parameters: [:], endPoint: .outlets, toAppend: "\(id)") { result in
            switch result {
            case .success(let json):
                let outletData = try! json["data"]["outlet_water_sources"].rawData()
                let outletListing = try! JSONDecoder().decode([WWOutletWatrSource].self, from: outletData)
                response(.success((outletListing)))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
}
