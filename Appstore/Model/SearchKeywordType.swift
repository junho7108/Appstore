//
//  SearchKeywordType.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import Foundation

protocol SearchKeywordType: Codable, Hashable {
    var keyword: String { get set }
}
