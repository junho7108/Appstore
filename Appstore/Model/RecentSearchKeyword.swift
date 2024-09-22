//
//  SearchKeyword.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import Foundation

struct RecentSearchKeyword: SearchKeywordType {
    var keyword: String
}

extension RecentSearchKeyword: CellModelConvertible {
    typealias classType = RecentKeywordCell
}
