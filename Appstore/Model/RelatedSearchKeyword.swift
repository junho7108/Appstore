//
//  RelatedSearchKeyword.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import Foundation

struct RelatedSearchKeyword: SearchKeywordType {
    var keyword: String
}

extension RelatedSearchKeyword: CellModelConvertible {
    typealias classType = RelatedKeywordCell
}
