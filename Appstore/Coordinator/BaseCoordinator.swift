//
//  BaseCoordinator.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import UIKit

class BaseCoordinator: Identifiable {
    let identifier: UUID = UUID()
    var childCoordinators = [UUID: BaseCoordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func store(coordinator: BaseCoordinator) {
        self.childCoordinators[coordinator.identifier] = coordinator
    }
    
    func release(coordinator: BaseCoordinator) {
        self.childCoordinators[coordinator.identifier] = nil
    }
    
    public func removeAll() {
        childCoordinators.forEach { child in
            self.release(coordinator: child.value)
        }
    }
}
