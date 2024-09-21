//
//  RecentKeywordCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import UIKit
import SnapKit
import Kingfisher

class RecentKeywordCell: BaseCell<SearchKeyword>,
                         ConfigurableUI {
   
    var baseView: RecentKeywordCellContentView = RecentKeywordCellContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBaseView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func measuredSize(model: SearchKeyword?, indexPath: IndexPath) -> CGSize {
        print("🟢\(#function)")
        return CGSize(width: UIScreen.width, height: 40)
    }

    override func update(model: SearchKeyword) {
        baseView.keywordLabel.text = model.keyword
    }
}
