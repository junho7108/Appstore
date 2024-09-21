//
//  String+Extensions.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import Foundation

extension String {
    func getClassType() -> AnyClass? {
        let name = Bundle.main.infoDictionary!["CFBundleName"] as! String
        return NSClassFromString("\(name).\(self)")
    }
}
