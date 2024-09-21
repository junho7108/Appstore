//
//  SearchResultCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBackground
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.layer.cornerRadius = 16
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: SearchResult) {
        self.imageView.kf.setImage(with: URL(string: model.artworkUrl100))
        self.trackNameLabel.text = model.trackName
        self.descriptionLabel.text = model.description
        
        self.contentView.backgroundColor = .lightGray
    }
    
    private func configureUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(40)
        }
        
        contentView.addSubview(downloadButton)
        downloadButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        contentView.addSubview(trackNameLabel)
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalTo(imageView.snp.trailing).offset(4)
            make.trailing.equalTo(downloadButton.snp.leading).inset(8)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(trackNameLabel)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
