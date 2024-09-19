//
//  ViewModelType.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import RxSwift

protocol ViewModelType: InputOutputAttachable,
                        ViewModelCoordinatable {
    var disposeBag: DisposeBag { get }
}
