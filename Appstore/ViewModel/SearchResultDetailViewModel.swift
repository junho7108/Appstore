//
//  SearchResultDetailViewModel.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import RxSwift
import RxRelay

final class SearchResultDetailViewModel: ViewModelType {
    
    struct Input: DefaultInput {
        var fetchData: PublishRelay<Void>
        var didTapShowMore: BehaviorRelay<Bool>
    }
    
    struct Output { 
        var searchResult: PublishRelay<SearchResult>
        var showMoreDescription: BehaviorRelay<Bool>
    }
    
    struct Coordinate: DefaultCoordinate {
        var close: PublishRelay<Void>
    }
    
    struct Dependency {
        var data: SearchResult
    }
    
    var input: Input = Input(fetchData: PublishRelay<Void>(),
                             didTapShowMore: BehaviorRelay<Bool>(value: false))
    
    lazy var output: Output = transform(input)
    
    var coordinate: Coordinate = Coordinate(close: PublishRelay<Void>())
    
    var dependency: Dependency
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func transform(_ input: Input) -> Output {
        let searchResult = PublishRelay<SearchResult>()
        let showMoreDescription = BehaviorRelay<Bool>(value: false)
           
        input.fetchData
            .share()
            .withUnretained(self)
            .flatMap { (self, _)  in Observable.just(self.dependency.data)}
            .bind(to: searchResult)
            .disposed(by: disposeBag)
        
        input.didTapShowMore
            .bind(to: showMoreDescription)
            .disposed(by: disposeBag)

        return Output(  searchResult: searchResult,
            showMoreDescription: showMoreDescription)
    }
}

private extension SearchResultDetailViewModel {
    func createItems(model: SearchResult, showMore: Bool) -> [[ModelAdaptable]] {
        var items = [[ModelAdaptable]]()
        
        let appInfo = AppInfoCellModel(imageUrl: model.artworkUrl100,
                         trackName: model.trackName).toCellModel()
        
        let analytics = AnalyticsCellModel(userRatingCount: model.userRatingCount,
                                           averageUserRating: model.averageUserRating).toCellModel()
        
        let screenshots = ScreenShotListCellModel(screenshotUrls: model.screenshotUrls).toCellModel()
        
        let description = DescriptionCellModel(description: model.description, showMore: showMore).toCellModel()
        
        items.append([appInfo,
                      analytics,
                      screenshots,
                      description])
       
        return items
    }
}

