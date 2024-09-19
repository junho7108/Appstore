//
//  NetworkService+Rx.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import Foundation
import Alamofire
import RxSwift

extension Reactive where Base: NetworkService {
    func sendGet<T: Decodable>(with url: String, parameters: Parameters? = nil) -> Observable<T?> {
        return Observable.create { [weak base] emitter in
            base?.sendGet(with: url, parameters: parameters) { (result: Result<T, Error>) in
                switch result {
                case .success(let model):
                    emitter.onNext(model)
                    
                case .failure(_):
                    emitter.onNext(nil)
                }
                emitter.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func sendPost<T: Decodable>(with url: String,
                                parameters: Parameters? = nil,
                                headers: HTTPHeaders? = nil) -> Observable<T?> {
        return Observable.create { [weak base] emitter in
            base?.sendPost(with: url, parameters: parameters, header: headers) { (result: Result<T, Error>) in
                switch result {
                case .success(let model):
                    emitter.onNext(model)
                   
                case .failure(let error):
                    emitter.onNext(nil)
                }
                emitter.onCompleted()
                
            }
            
            return Disposables.create()
        }
    }
}
