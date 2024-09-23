//
//  SearchResultCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import UIKit

final class SearchResultCell: BaseCell<SearchResult>,
                              ConfigurableUI,
                              ActionAttachable {
    
    enum ActionType {
        case coordinateToSearchDetail(SearchResult)
    }
    
    var completableAction: ((ActionType) -> Void)?
   
    var baseView: SearchResultCellContentView = SearchResultCellContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBaseView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func measuredSize(model: SearchResult?, indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width, height: 340)
    }
    
    override func update(model: SearchResult) {
        baseView.imageView.kf.setImage(with: URL(string: model.artworkUrl100))
        baseView.trackNameLabel.text = model.trackName
        baseView.descriptionLabel.text = model.description
        
        baseView.starScoreView.updateScore(model.averageUserRating)
        baseView.scoreLabel.text = String(model.averageUserRating.truncateToOneDecimalPlace())
        baseView.screenShotView.updateScreenShotImages(with: model.screenshotUrls)
    }
    
    override func didSelect(model: SearchResult, indexPath: IndexPath) {
        completableAction?(.coordinateToSearchDetail(model))
    }
}
