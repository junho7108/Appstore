//
//  SearchHomeViewModel.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import RxSwift
import RxRelay

final class SearchHomeViewModel: ViewModelType,
                                 ViewModelStatusObservable {
    
    enum ScreenType {
        case relatedKeywords, searchResult
    }
    
    struct Input: DefaultInput {
        var fetchData: PublishRelay<Void>
        var didChangeKeywordText: BehaviorRelay<String>
        let searchKeyword: PublishRelay<any SearchKeywordType>
//        let searchButtonClicked: PublishRelay<any SearchKeywordType>
    }
    
    struct Output {
        let isLoading: BehaviorRelay<Bool>
        let searchText: PublishRelay<String>
        let response: PublishRelay<SearchResponse>
        let recentKeywords: BehaviorRelay<[RecentSearchKeyword]>
        let relatedKeywords: BehaviorRelay<[RelatedSearchKeyword]>
        let searchResults: BehaviorRelay<[SearchResult]>
        let sectionType: BehaviorRelay<ScreenType>
    }
    
    struct Coordinate: DefaultCoordinate {
        var close: PublishRelay<Void>
    }
    
    var input: Input = Input(fetchData: PublishRelay<Void>(),
                             didChangeKeywordText: BehaviorRelay<String>(value: ""),
                             searchKeyword: PublishRelay<any SearchKeywordType>())
    
    lazy var output: Output = transform(input)
    
    var coordinate: Coordinate = Coordinate(close: PublishRelay<Void>())
    
    var disposeBag: DisposeBag = DisposeBag()
    
    let useacse: SearchUsecase
    
    var status: BehaviorRelay<ViewModelStatus> = .init(value: .ready)
    
    init(usecase: SearchUsecase) {
        self.useacse = usecase
    }
    
    func transform(_ input: Input) -> Output {
        
        let isLoading = BehaviorRelay<Bool>(value: false)
        let searchText = PublishRelay<String>()
        let response = PublishRelay<SearchResponse>()
        let recentKeywords = BehaviorRelay<[RecentSearchKeyword]>(value: [])
        let relatedKeywords = BehaviorRelay<[RelatedSearchKeyword]>(value: [])
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
            .flatMapLatest { (self, term) in self.searchSoftware(term: term) }
            .bind(onNext: { response in
                guard let response else { return }
               
                let keywords = response.results.map { RelatedSearchKeyword(keyword: $0.trackName)}
                
                relatedKeywords.accept(keywords)
                
                sectionType.accept(.relatedKeywords)
            })
            .disposed(by: disposeBag)
        
        input.searchKeyword
            .share()
            .withUnretained(self)
            .do(onNext: { (self, keyword) in
                self.useacse.saveSearchKeyword(keyword: keyword)
                self.input.fetchData.accept(())
                searchText.accept(keyword.keyword)
            })
            .flatMapLatest { (self, keyword) in self.searchSoftware(term: keyword.keyword )}
            .bind { response in
                guard let response else { return }
          
                searchResults.accept(response.results)
                
                sectionType.accept(.searchResult)
            }
            .disposed(by: disposeBag)
        
        return Output(isLoading: isLoading,
                      searchText: searchText,
                      response: response,
                      recentKeywords: recentKeywords,
                      relatedKeywords: relatedKeywords,
                      searchResults: searchResults,
                      sectionType: sectionType)
    }
}

private extension SearchHomeViewModel {
    func searchSoftware(term: String) -> Observable<SearchResponse?>  {
        self.status.accept(.loading)
        
        return self.useacse.searchSoftware(term: term)
            .do(onNext: { [weak self] _ in
                self?.status.accept(.complete)
            })
    }
}
