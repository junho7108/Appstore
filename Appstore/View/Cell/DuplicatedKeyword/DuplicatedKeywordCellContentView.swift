//
//  DuplicatedKeywordCellContentView.swift
//  Appstore
//
//  Created by Junho Yoon on 9/23/24.
//

import UIKit

final class DuplicatedKeywordCellContentView: UIView {
    
    private(set) var matchedKeywordImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "timer")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.systemGray3))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) var keywordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        addSubview(matchedKeywordImageView)
        matchedKeywordImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints { make in
            make.leading.equalTo(matchedKeywordImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
    
        let devider = UIView()
        devider.backgroundColor = .systemGray5
        
        addSubview(devider)
        devider.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
