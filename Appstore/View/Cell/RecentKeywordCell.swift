//
//  RecentKeywordCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import UIKit
import SnapKit
import Kingfisher

class RecentKeywordCell: BaseCell<SearchKeyword> {
    var keywordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.center.equalToSuperview()
            make.height.equalTo(20)
        }
    
        let separator = UIView()
        separator.backgroundColor = .lightGray
        
        contentView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func update(model: SearchKeyword) {
        self.keywordLabel.text = model.keyword
    }
}
