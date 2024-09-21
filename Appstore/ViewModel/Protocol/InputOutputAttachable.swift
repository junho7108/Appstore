//
//  InputOutputAttachable.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import RxRelay

protocol InputOutputAttachable {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get set }
    var output: Output { get set }
    
    func transform(_ input: Input) -> Output
}

protocol DefaultInput {
    var fetchData: PublishRelay<Void> { get set }
}

protocol SearchHomeInput: DefaultInput {
    var fetchSearchResult: PublishRelay<String> { get set }
}
