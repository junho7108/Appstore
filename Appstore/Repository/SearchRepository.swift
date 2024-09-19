//
//  SearchRepository.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import Alamofire
import RxSwift

protocol SearchRepositoryType {
    func searchSoftware(term: String, country: String) -> Observable<SearchResponse?>
}

struct SearchRepository: SearchRepositoryType {
    func searchSoftware(term: String, country: String = "kr") -> Observable<SearchResponse?> {
        
        let url = Const.domain + Const.ApiPath.search
        let parameters = [
            "term": term,
            "country": country,
            "entity": "software"
        ]
        
        return NetworkService.shared.rx.sendGet(with: url, parameters: parameters)
    }
}
