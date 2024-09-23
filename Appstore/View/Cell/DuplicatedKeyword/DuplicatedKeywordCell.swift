//
//  DuplicatedKeywordCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/23/24.
//

import UIKit

struct DuplicatedKeywordCellModel: SearchKeywordType, CellModelProtocol {
    var keyword: String
    typealias classType = DuplicatedKeywordCell
}

final class DuplicatedKeywordCell: BaseCell<DuplicatedKeywordCellModel>,
                                   ConfigurableUI,
                                   ActionAttachable {
    
    enum ActionType {
        case didSelectKeyword(keyword: any SearchKeywordType)
    }
    
    var completableAction: ((ActionType) -> Void)?
    
    var baseView: DuplicatedKeywordCellContentView = DuplicatedKeywordCellContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBaseView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func measuredSize(model: DuplicatedKeywordCellModel?, indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width - 32, height: 40)
    }
    
    override func update(model: DuplicatedKeywordCellModel) {
        baseView.keywordLabel.text = model.keyword
    }
    
    override func didSelect(model: DuplicatedKeywordCellModel, indexPath: IndexPath) {
        completableAction?(.didSelectKeyword(keyword: model))
    }
}


