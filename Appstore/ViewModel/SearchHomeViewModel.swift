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
        
    }
    
    struct Coordinate: DefaultCoordinate {
        var close: PublishRelay<Void>
    }
    
    var input: Input = Input(fetchData: PublishRelay<Void>())
    
    lazy var output: Output = transform(input)
    
    var coordinate: Coordinate = Coordinate(close: PublishRelay<Void>())
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        
        return Output()
    }
}
