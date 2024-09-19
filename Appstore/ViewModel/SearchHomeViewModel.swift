//
//  SearchHomeViewModel.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import RxSwift
import RxRelay

final class SearchHomeViewModel: ViewModelType {
   
    struct Input: DefaultInput {
        var fetchData: PublishRelay<Void>
    }
    
    struct Output {
        let response: PublishRelay<SearchResponse>
    }
    
    struct Coordinate: DefaultCoordinate {
        var close: PublishRelay<Void>
    }
    
    var input: Input = Input(fetchData: PublishRelay<Void>())
    
    lazy var output: Output = transform(input)
    
    var coordinate: Coordinate = Coordinate(close: PublishRelay<Void>())
    
    var disposeBag: DisposeBag = DisposeBag()
    
    let useacse: SearchUsecase
    
    init(usecase: SearchUsecase) {
        self.useacse = usecase
    }
    
    func transform(_ input: Input) -> Output {
        
        let response = PublishRelay<SearchResponse>()
        
//        input.fetchData
//            .withUnretained(self)
//            .flatMap { (self, _) in self.useacse.searchSoftware(term: "kakao")}
//            .filter { $0 != nil }
//            .map { $0! }
//            .bind(to: response)
//            .disposed(by: disposeBag)
        
        return Output(response: response)
    }
}
