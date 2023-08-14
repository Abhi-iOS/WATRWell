//
//  Double + Extension.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 15/08/23.
//

import Foundation

extension Double {
    func getDistance() -> String {
        let feet = convert(from: .meters, to: .feet)
        if feet <= 700 {
            return String("\(Int(feet)) FEET")
        } else {
            let miles = String(format: "%.2f", convert(from: .meters, to: .miles))
            return miles + " MILES"
        }
    }
    
  func convert(from originalUnit: UnitLength, to convertedUnit: UnitLength) -> Double {
    return Measurement(value: self, unit: originalUnit).converted(to: convertedUnit).value
  }
}
