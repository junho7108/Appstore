//
//  StarScoreView.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import Foundation
import UIKit

final class StarScoreView: UIView {
    
    private let starImage = UIImage(systemName: "star")?
        .withRenderingMode(.alwaysOriginal)
        .withTintColor(.systemGray2)
    
    private let fillStarImage = UIImage(systemName: "star.fill")?
        .withRenderingMode(.alwaysOriginal)
        .withTintColor(.systemGray2)
    
    private let halffilledStarImage = UIImage(systemName: "star.leadinghalf.filled")?
        .withRenderingMode(.alwaysOriginal)
        .withTintColor(.systemGray2)
    
    private lazy var firstStartImageView: UIImageView = {
        let imageView = UIImageView(image: fillStarImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var secondStartImageView: UIImageView = {
        let imageView = UIImageView(image: fillStarImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var thirdStartImageView: UIImageView = {
        let imageView = UIImageView(image: fillStarImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var fourthStartImageView: UIImageView = {
        let imageView = UIImageView(image: halffilledStarImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var fivethStartImageView: UIImageView = {
        let imageView = UIImageView(image: starImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var arrangedSubviews = [firstStartImageView,
                                         secondStartImageView,
                                         thirdStartImageView,
                                         fourthStartImageView,
                                         fivethStartImageView]
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        
        arrangedSubviews.forEach { $0.snp.makeConstraints { $0.width.height.equalTo(12) }}
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateScore(_ score: Double) {
        
        arrangedSubviews.enumerated().forEach { (index, _) in
            let starScore = Double(index) + 0.5
            
            if score >= starScore {
                arrangedSubviews[index].image = fillStarImage
            } else if score >= Double(index) && score != 0 {
                arrangedSubviews[index].image = halffilledStarImage
            } else {
                arrangedSubviews[index].image = starImage
            }
        }
    }
}
