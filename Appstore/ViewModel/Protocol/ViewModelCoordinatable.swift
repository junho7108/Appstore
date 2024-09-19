//
//  ViewModelCoordinatable.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import RxRelay


protocol DefaultCoordinatable {
    var coordinate: DefaultCoordinate { get }
}

protocol DefaultCoordinate {
    var close: PublishRelay<Void> { get set }
}


protocol ViewModelCoordinatable: DefaultCoordinatable {
    associatedtype Coordinate: DefaultCoordinate
    var coordinate: Coordinate { get set }
}

extension ViewModelCoordinatable {
    var coordinate: DefaultCoordinate { return coordinate }
}
