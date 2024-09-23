//
//  SearchResultCellContentView.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import Foundation
import UIKit

final class SearchResultCellContentView: UIView {
    
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        return imageView
    }()
    
    private(set) var trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private(set) var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray2
        return label
    }()
    
    private(set) var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 16
        return button
    }()
    
    private(set) var starScoreView = StarScoreView()
    
    private(set) var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .systemGray2
        return label
    }()
    
    private(set) var screenShotView = ScreenshotView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.width.height.equalTo(64)
        }
        
        addSubview(downloadButton)
        downloadButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
        
        addSubview(trackNameLabel)
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-16)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(trackNameLabel)
        }
        
        addSubview(starScoreView)
        starScoreView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.equalTo(imageView)
        }
        
        addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.leading.equalTo(starScoreView.snp.trailing).offset(4)
            make.centerY.equalTo(starScoreView)
        }
        
        addSubview(screenShotView)
        screenShotView.snp.makeConstraints { make in
            make.top.equalTo(starScoreView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
