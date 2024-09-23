//
//  SearchResultDetailViewController.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchResultDetailViewController: BaseViewController,
                                              ViewModelBindable,
                                              CollectionViewDiffableProtocol {

    enum SectionType: Int, Hashable {
        case appInfo
        case reviews
        case screenShot
        case description
    }
    
    var items: [[any ModelAdaptable]]?
    
    lazy var handler: CollectionViewDiffableHandler! = CollectionViewDiffableHandler(adaptable: self, collecionView: collectionView)
    
    var collectionView: UICollectionView! = UICollectionView(frame: .zero,
                                                             collectionViewLayout: BaseCollectionFlowLayout(direction: .vertical))
 
    var viewModel: SearchResultDetailViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    func decorateCell(_ cell: UICollectionViewCell, forItemAt indexPath: IndexPath) { 
        switch cell {
        case is DescriptionCell:
            let cell = cell as! DescriptionCell
            cell.completableAction = { [weak self] action in
                switch action {
                case .didTapShowMoreButton:
                    self?.viewModel.input.didTapShowMore.accept((true))
                }
            }
        default:
            return
        }
    }
    
    func bindViewModel() {
        
        Observable.combineLatest(
            viewModel.output.searchResult,
            viewModel.output.showMoreDescription
        )
        .bind { [weak self] (model, showMore) in
            guard let self else { return }
            
            var items: [[ModelAdaptable]] = []
            
            items = self.createItems(model: model, showMore: showMore)
            
            self.handler.updateDataSource(items, animatingDifferences: true)
        }
        .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SearchResultDetailViewController {
    private func createItems(model: SearchResult, showMore: Bool) -> [[ModelAdaptable]] {
        var items = [[ModelAdaptable]]()
        
        let appInfo = AppInfoCellModel(imageUrl: model.artworkUrl100,
                         trackName: model.trackName).toCellModel()
        
        let analytics = AnalyticsCellModel(userRatingCount: model.userRatingCount,
                                           averageUserRating: model.averageUserRating).toCellModel()
        
        let screenshots = ScreenShotListCellModel(screenshotUrls: model.screenshotUrls).toCellModel()
        
        let description = DescriptionCellModel(description: model.description, showMore: showMore).toCellModel()
        
        items.append([appInfo,
//                      analytics,
                      screenshots,
                      description])
       
        return items
    }
}
