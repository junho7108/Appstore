//
//  ViewModelStatusObservable.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import UIKit
import RxSwift
import RxRelay

enum ViewModelStatus {
    case ready
    case loading
    case complete
    case cancel
}

protocol ViewModelStatusObservable {
    var status: BehaviorRelay<ViewModelStatus> { get set }
}

protocol ViewModelStatusChangeListener {
    
    var disposeBag: DisposeBag { get set }
}

extension ViewModelStatusChangeListener where Self: BaseViewController,
                                              Self: ViewModelBindable {
    func attachViewModelStatusChangeObserver() {
        if let viewModel = viewModel as? ViewModelStatusObservable {
            viewModel.status
                .asDriver(onErrorJustReturn: .ready)
                .drive(onNext: { [weak self] status in
                   
                    guard let self else { return }
                    switch status {
                    case .ready: break
                    case .loading:
                        self.showIndicator()
                    case .complete, .cancel:
                        self.dismissIndicator()
                    }
                })
                .disposed(by: self.disposeBag)
        }
    }
}

