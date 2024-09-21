//
//  SearchHomeViewModel.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import RxSwift
import RxRelay

final class SearchHomeViewModel: ViewModelType {
    
    enum ScreenType {
        case relatedKeywords, searchResult
    }
    
    struct Input: SearchHomeInput {
        var fetchData: PublishRelay<Void>
        var fetchSearchResult: PublishRelay<String>
        var didChangeKeywordText: BehaviorRelay<String>
        let searchButtonClicked: PublishRelay<SearchKeyword>
    }
    
    struct Output {
        let response: PublishRelay<SearchResponse>
        let recentKeywords: BehaviorRelay<[SearchKeyword]>
        let relatedKeywords: BehaviorRelay<[SearchKeyword]>
        let searchResults: BehaviorRelay<[SearchResult]>
        let sectionType: BehaviorRelay<ScreenType>
    }
    
    struct Coordinate: DefaultCoordinate {
        var close: PublishRelay<Void>
    }
    
    var input: Input = Input(fetchData: PublishRelay<Void>(),
                             fetchSearchResult: PublishRelay<String>(),
                             didChangeKeywordText: BehaviorRelay<String>(value: ""),
                             searchButtonClicked: PublishRelay<SearchKeyword>())
    
    lazy var output: Output = transform(input)
    
    var coordinate: Coordinate = Coordinate(close: PublishRelay<Void>())
    
    var disposeBag: DisposeBag = DisposeBag()
    
    let useacse: SearchUsecase
    
    init(usecase: SearchUsecase) {
        self.useacse = usecase
    }
    
    func transform(_ input: Input) -> Output {
        
        let response = PublishRelay<SearchResponse>()
        let recentKeywords = BehaviorRelay<[SearchKeyword]>(value: [])
        let relatedKeywords = BehaviorRelay<[SearchKeyword]>(value: [])
        let searchResults = BehaviorRelay<[SearchResult]>(value: [])
                                                          
        let sectionType = BehaviorRelay<ScreenType>(value: .relatedKeywords)
      
        
        input.fetchData
            .withUnretained(self)
            .flatMap { (self, _) in self.useacse.fetcRecentSearchKeywords() }
            .bind(to: recentKeywords)
            .disposed(by: disposeBag)
        
        input.didChangeKeywordText
            .filter { !$0.isEmpty }
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .flatMapLatest { (self, term) in self.useacse.searchSoftware(term: term) }
            .bind(onNext: { response in
                guard let response else { return }
               
                relatedKeywords.accept(response.results.map { SearchKeyword(keyword: $0.trackName )})
                
                searchResults.accept(response.results)
              
                sectionType.accept(.relatedKeywords)
            })
            .disposed(by: disposeBag)
    
        input.searchButtonClicked.share()
            .withUnretained(self)
            .bind { (self, keyword) in
                self.useacse.saveSearchKeyword(keyword: keyword)
                self.input.fetchData.accept(())
                sectionType.accept(.searchResult)
            }
            .disposed(by: disposeBag)
        
        return Output(response: response,
                      recentKeywords: recentKeywords,
                      relatedKeywords: relatedKeywords,
                      searchResults: searchResults,
                      sectionType: sectionType)
    }
}
