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
    func saveSearchKeyword(keyword: SearchKeyword)
    func fetcRecentSearchKeywords() -> Observable<[SearchKeyword]>
    func searchSoftware(term: String, country: String, entity: MediaType) -> Observable<SearchResponse?>
}

struct SearchRepository: SearchRepositoryType {
    func saveSearchKeyword(keyword: SearchKeyword) {
        var searchKeywords = UserDefaults.standard.object([SearchKeyword].self,
                                                          forKey: "searchKeywords")
        
        // 중복된 키워드가 있는 경우 제거
        if let index = searchKeywords?.firstIndex(of: keyword) {
            searchKeywords?.remove(at: index)
        }
        
        let result: [SearchKeyword] = [keyword] + (searchKeywords ?? [])
        
        UserDefaults.standard.set(object: result, forKey: "searchKeywords")
    }
    
    func fetcRecentSearchKeywords() -> Observable<[SearchKeyword]> {
        return Observable.create { emitter in
            
            let keywords = UserDefaults.standard.object([SearchKeyword].self, forKey: "searchKeywords")
            
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
