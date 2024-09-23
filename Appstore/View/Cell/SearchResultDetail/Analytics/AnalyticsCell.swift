//
//  AnalyticsCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/23/24.
//

import UIKit

struct AnalyticsCellModel: CellModelProtocol {
    var userRatingCount: Int
    var averageUserRating: Double
  
    typealias classType = AnalyticsCell
}

final class AnalyticsCell: BaseCell<AnalyticsCellModel> {
    
    private let startScoreView = StarScoreAnalyticsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func measuredSize(model: AnalyticsCellModel?, indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width, height: 100)
    }
    
    override func update(model: AnalyticsCellModel) {
        startScoreView.userRatingLabel.text = formatRatingCount(model.userRatingCount)
        startScoreView.starScoreLabel.text = String(model.averageUserRating.truncateToOneDecimalPlace())
        startScoreView.startScoreView.updateScore(model.averageUserRating.truncateToOneDecimalPlace())
    }
}

private extension AnalyticsCell {
    func configureUI() {
        let devider = UIView()
        devider.backgroundColor = .systemGray4
        
        addSubview(devider)
        devider.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
//        addSubview(startScoreView)
//        contentView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview()
//            make.leading.equalToSuperview().inset(16)
//            make.width.equalTo(96)
//            make.height.equalTo(100)
//        }
    }
    
    func formatRatingCount(_ count: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        if count >= 1000000 {
            let millions = count / 1000000
            return "\(millions)백만개의 평가"
        } else if count >= 1000 {
            let thousands = count / 1000
            return "\(thousands)만개의 평가"
        } else {
            return "\(count)개의 평가"
        }
    }
}
