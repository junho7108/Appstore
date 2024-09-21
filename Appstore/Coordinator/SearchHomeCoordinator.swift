//
//  SearchHomeCoordinator.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import UIKit
import RxSwift

final class SearchHomeCoordinator: ReactiveCoordinator<Void>,
                                   CoordinatorTransitable {
    
    override func start(_ type: CoordinatorTransitionType) -> Observable<Void> {
        
        self.navigationController.setNavigationBarHidden(false, animated: false)
        
        let repository = SearchRepository()
        let usecase = SearchUsecase(repository: repository)
        let viewModel = SearchHomeViewModel(usecase: usecase)
        let viewController = SearchHomeViewController(viewModel: viewModel)
        
        self.transition(to: viewController,
                        navigationController: navigationController,
                        type: .push,
                        animated: true)
        
        return Observable.empty()
    }
}
