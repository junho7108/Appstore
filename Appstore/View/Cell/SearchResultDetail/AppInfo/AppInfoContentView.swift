//
//  AppInfoContentView.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import UIKit

final class AppInfoContentView: UIView {
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        return imageView
    }()
    
    private(set) var trackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .semibold)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AppInfoContentView {
    func configureUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(80)
        }
        
        addSubview(trackNameLabel)
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(8)
        }
        
        addSubview(downloadButton)
        downloadButton.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(8).priority(250)
            make.bottom.equalTo(imageView)
            make.leading.equalTo(trackNameLabel)
            make.width.equalTo(64)
            make.height.equalTo(32)
        }
    }
}
