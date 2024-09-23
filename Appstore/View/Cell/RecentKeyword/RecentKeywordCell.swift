//
//  RecentKeywordCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import UIKit
import SnapKit
import Kingfisher

struct RecentSearchKeyword: SearchKeywordType, CellModelProtocol {
    var keyword: String
    typealias classType = RecentKeywordCell
}

final class RecentKeywordCell: BaseCell<RecentSearchKeyword>,
                         ConfigurableUI,
                         ActionAttachable {
    
    enum ActionType {
        case didSelectKeyword(keyword: RecentSearchKeyword)
    }
   
    var completableAction: ((ActionType) -> Void)?
    var baseView: RecentKeywordCellContentView = RecentKeywordCellContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBaseView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func measuredSize(model: RecentSearchKeyword?, indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width - 32, height: 40)
    }

    override func update(model: RecentSearchKeyword) {
        baseView.keywordLabel.text = model.keyword
    }
    
    override func didSelect(model: RecentSearchKeyword, indexPath: IndexPath) {
        completableAction?(.didSelectKeyword(keyword: model))
    }
}
