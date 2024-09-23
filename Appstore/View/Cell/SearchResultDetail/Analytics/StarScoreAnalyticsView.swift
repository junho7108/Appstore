//
//  StarScoreAnalyticsView.swift
//  Appstore
//
//  Created by Junho Yoon on 9/23/24.
//

import UIKit

final class StarScoreAnalyticsView: UIView {
    private(set) var userRatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    private(set) var starScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private(set) var startScoreView = StarScoreView()
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension StarScoreAnalyticsView {
    func configureUI() {
        let contentView = AnalyticsContentView(topView: userRatingLabel,
                                               centerView: starScoreLabel,
                                               bottomView: startScoreView)
        
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
    }
}
