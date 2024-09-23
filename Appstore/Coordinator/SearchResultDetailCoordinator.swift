//
//  SearchResultDetailCoordinator.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import UIKit
import RxSwift
import RxRelay

final class SearchResultDetailCoordinator: ReactiveCoordinator<Void>,
                                           CoordinatorTransitable {
    
    typealias Dependency = SearchResultDetailViewModel.Dependency
    
    private(set) var dependency: Dependency
    
    init(dependency: Dependency, navigationController: UINavigationController) {
        self.dependency = dependency
        super.init(navigationController: navigationController)
    }
    
    override func start(_ type: CoordinatorTransitionType) -> Observable<Void> {
        
        
        let viewModel = SearchResultDetailViewModel(dependency: dependency)
        let viewController = SearchResultDetailViewController(viewModel: viewModel)
        
        self.transition(to: viewController,
                        navigationController: navigationController,
                        type: .push, 
                        animated: true)
        
        return Observable.empty()
    }
}
