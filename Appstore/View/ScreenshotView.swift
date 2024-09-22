//
//  ScreenshotView.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import UIKit
import Kingfisher

final class ScreenshotView: UIView {
    
    private let firstScreenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let secondScreenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let thirdScreenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var arrangedSubViews = [firstScreenImageView,
                                         secondScreenImageView,
                                         thirdScreenImageView]
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        arrangedSubViews.forEach { $0.snp.makeConstraints { make in
            let width = (UIScreen.width - 24 - 12) / 3
            let height = width * 7 / 3
            make.width.equalTo(width)
            make.height.equalTo(height)
        }}
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateScreenShotImages(with images: [String]) {
        arrangedSubViews.enumerated().forEach { (index, _) in
            let urlString = URL(string: images[index])
            arrangedSubViews[index].kf.setImage(with: urlString)
        }
    }
}


