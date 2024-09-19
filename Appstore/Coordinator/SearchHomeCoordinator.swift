//
//  SearchHomeCoordinator.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import RxSwift

final class SearchHomeCoordinator: ReactiveCoordinator<Void>,
                                   CoordinatorTransitable {
    
    
    override func start(_ type: CoordinatorTransitionType) -> Observable<Void> {
        
        let viewModel = SearchHomeViewModel()
        let viewController = SearchHomeViewController(viewModel: viewModel)
        
        self.transition(to: viewController,
                        navigationController: navigationController,
                        type: .push,
                        animated: true)
        
        return Observable.just(())
    }
}
