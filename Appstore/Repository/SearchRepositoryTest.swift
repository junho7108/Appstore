//
//  SearchRepositoryTest.swift
//  Appstore
//
//  Created by Junho Yoon on 9/23/24.
//

import RxSwift

struct SearchRepositoryTest: SearchRepositoryType {
    func saveSearchKeyword<T>(keyword: T) where T : SearchKeywordType {
        return
    }
    
    func fetcRecentSearchKeywords() -> Observable<[RecentSearchKeyword]> {
        return .just([
            RecentSearchKeyword(keyword: "테스트1"),
            RecentSearchKeyword(keyword: "테스트2"),
        ])
    }
    
    func searchSoftware(term: String, country: String, entity: MediaType) -> Observable<SearchResponse?> {
        return .just(SearchResponse(resultCount: 1, results: [SearchResult.testObject(trackName: term)]))
    }
}
