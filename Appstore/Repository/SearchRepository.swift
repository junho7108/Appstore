//
//  SearchRepository.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import Foundation
import Alamofire
import RxSwift

protocol SearchRepositoryType {
    func saveSearchKeyword<T: SearchKeywordType>(keyword: T)
    func fetcRecentSearchKeywords() -> Observable<[RecentSearchKeyword]>
    func searchSoftware(term: String, country: String, entity: MediaType) -> Observable<SearchResponse?>
}

struct SearchRepository: SearchRepositoryType {
    func saveSearchKeyword<T: SearchKeywordType>(keyword: T) {
        var searchKeywords = UserDefaults.standard.object([T].self,
                                                          forKey: "searchKeywords")
        if let index = searchKeywords?.firstIndex(of: keyword) {
            searchKeywords?.remove(at: index)
        }
        
        let result: [T] = [keyword] + (searchKeywords ?? [])
        
        UserDefaults.standard.set(object: result, forKey: "searchKeywords")
    }
    
    func fetcRecentSearchKeywords() -> Observable<[RecentSearchKeyword]> {
        return Observable.create { emitter in
            
            let keywords = UserDefaults.standard.object([RecentSearchKeyword].self, forKey: "searchKeywords")
            
            emitter.onNext(keywords ?? [])
            
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func searchSoftware(term: String, country: String, entity: MediaType) -> Observable<SearchResponse?> {
        
        let url = Const.domain + Const.ApiPath.search
        let parameters = [
            "term": term,
            "country": country,
            "media": "software",
            "entity": entity.rawValue
        ]
        
        return NetworkService.shared.rx.sendGet(with: url, parameters: parameters)
    }
}
