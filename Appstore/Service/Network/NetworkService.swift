//
//  NetworkService.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import Foundation
import Alamofire

final class NetworkService: NSObject {
    static let shared = NetworkService()
    
    private(set) var session: Session
    
    private override init() {
        let logger = APIEventLogger()
        self.session = Session(eventMonitors: [logger])
    }
    
    private var headers: HTTPHeaders {
        return HTTPHeaders.init([
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Accept", value: "application/json")
        ])
    }
    
    func sendGet<T: Decodable>(with url: String,
                               parameters: Parameters? = nil,
                               completion: @escaping (Result<T, Error>) -> Void) {
        session.request(url,
                        method: .get,
                        parameters: parameters,
                        headers: headers)
        .responseDecodable(of: T.self) { res in
            switch res.result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sendPost<T: Decodable>(with url: String,
                                parameters: Parameters?,
                                header: HTTPHeaders? = nil,
                                completion: @escaping (Result<T, Error>) -> Void) {
        session.request(url,
                        method: .post,
                        parameters: parameters,
                        encoding: JSONEncoding.default,
                        headers: headers)
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
