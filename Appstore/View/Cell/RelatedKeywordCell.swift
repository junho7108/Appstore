//
//  RelatedKeywordCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import Foundation
import UIKit
import Kingfisher

final class RelatedKeywordCell: BaseCell<RelatedSearchKeyword>,
                          ConfigurableUI,
                          ActionAttachable {
    
    enum ActionType {
        case didSelectKeyword(keyword: RelatedSearchKeyword)
    }
    
    var completableAction: ((ActionType) -> Void)?
    
    var baseView: RelatedSearchKeywordCellContentView = RelatedSearchKeywordCellContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBaseView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func measuredSize(model: RelatedSearchKeyword?, indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width - 32, height: 40)
    }

    override func update(model: RelatedSearchKeyword) {
        baseView.keywordLabel.text = model.keyword
        baseView.keywordLabel.textColor = .black
    }
    
    override func didSelect(model: RelatedSearchKeyword, indexPath: IndexPath) {
        completableAction?(.didSelectKeyword(keyword: model))
    }
}
