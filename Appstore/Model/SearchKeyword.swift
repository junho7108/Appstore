//
//  SearchKeyword.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import Foundation

struct SearchKeyword: Codable, Hashable {
    var keyword: String
}

extension SearchKeyword: CellModelConvertible {
    typealias classType = RecentKeywordCell
}
