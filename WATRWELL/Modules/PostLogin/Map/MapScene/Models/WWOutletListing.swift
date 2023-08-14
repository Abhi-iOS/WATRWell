//
//  WWOutletListing.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 15/08/23.
//

import Foundation
import CoreLocation

struct WWOutletData: Decodable {
    enum SourceType: String {
        case CACTUS
        case WILLO
        
        var title: String {
            switch self {
            case .WILLO: return "WILLŌ"
            case .CACTUS: return rawValue
            }
        }
    }
    
    let id: Int
    let title: String
    let subTitle: String
    let logo: String
    let address: String
    private let latitude: Double
    private let longitude: Double
    private let source: String
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var sourceType: SourceType {
        return SourceType(rawValue: self.source) ?? .WILLO
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subTitle = "sub_title"
        case logo
        case address
        case latitude
        case longitude
        case source = "source_name"
    }
}

struct WWOutletWatrSource: Decodable {
    enum SourceType: String {
        case electrolyte = "ELECTROLYTES"
        case immunity = "IMMUNITY"
        case antiAging = "ANTI-AGING"
        case none
    }
    private let name: String
    private let storage: Double
    let id: String?
    
    var percent: String {
        return "\(Int(storage))%"
    }
    
    var displayName: String {
        return "+\(name)"
    }
    
    var sourceType: SourceType {
        return SourceType(rawValue: name) ?? .none
    }
}
