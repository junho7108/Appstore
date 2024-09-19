//
//  AppCoordinator.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import UIKit
import RxSwift
import RxRelay

final class AppCoordinator: ReactiveCoordinator<Void>,
                            CoordinatorTransitable {
  
    
    static let shared = AppCoordinator(navigationController: UINavigationController())
    
    var viewController: UIViewController?
    
    var window: UIWindow!
    
    private override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
        self.navigationController.setNavigationBarHidden(true, animated: false)
        
        let coordinator = SearchHomeCoordinator(navigationController: navigationController)
        
        corodinate(to: coordinator, type: .push, animated: false)
            .bind { _ in
                print("SearchHome Coordinator start..")
            }
            .disposed(by: disposeBag)
    }
    
    func start(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        
        
    }
}

