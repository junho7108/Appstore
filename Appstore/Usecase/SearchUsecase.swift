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
    
    func searchSoftware(term: String, country: String = "KR") -> Observable<SearchResponse?> {
        return self.repository.searchSoftware(term: term, country: country)
    }
}
