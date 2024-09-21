//
//  SearchUsecase.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import Alamofire
import RxSwift

struct SearchUsecase {
    private let repository: SearchRepositoryType
    
    init(repository: SearchRepositoryType) {
        self.repository = repository
    }
    
    func saveSearchKeyword(keyword: SearchKeyword) {
        return self.repository.saveSearchKeyword(keyword: keyword)
    }
    
    func fetcRecentSearchKeywords() -> Observable<[SearchKeyword]> {
        return self.repository.fetcRecentSearchKeywords()
    }
    
    func searchSoftware(term: String,
                        country: String = "KR",
                        entity: MediaType = .software) -> Observable<SearchResponse?> {
        return self.repository.searchSoftware(term: term, country: country, entity: entity)
    }
}
