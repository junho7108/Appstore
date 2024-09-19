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
    
    private var splashCoordinator: Disposable!
    
    var splash: Disposable!
    var window: UIWindow!
    
    private override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        
        coordinateToHome()
    }
}

//MARK: -

private extension AppCoordinator {
    @discardableResult
    func coordinateToHome() -> Observable<Void> {
        let coordinator = SearchHomeCoordinator(navigationController: navigationController)
        return self.coordinate(to: coordinator, type: .push, animated: false)
    }
}
