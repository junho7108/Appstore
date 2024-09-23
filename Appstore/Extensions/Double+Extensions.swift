//
//  Double+Extensions.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import Foundation

extension Double {
    func truncateToOneDecimalPlace() -> Double {
        let factor = pow(10.0, 1.0) 
        return floor(self * factor) / factor
    }
}
