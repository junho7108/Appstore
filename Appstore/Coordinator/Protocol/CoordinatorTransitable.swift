//
//  CoordinatorTransitable.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import UIKit
import RxSwift
import RxCocoa

enum CoordinatorTransitionType {
    case root
    case push
    case modal
}

protocol CoordinatorTransitable {
    func transition(to: UIViewController,
                    navigationController: UINavigationController,
                    type: CoordinatorTransitionType,
                    animated: Bool) -> Observable<Void>
    
    func pop(_ viewController: UIViewController, animated: Bool)
}

extension CoordinatorTransitable {
    @discardableResult
    func transition(to viewController: UIViewController,
                    navigationController: UINavigationController,
                    type: CoordinatorTransitionType,
                    animated: Bool) -> Observable<Void> {
        
        switch type {
        case .root:
            guard let window = navigationController.viewControllers.first?.view.window else { fatalError("윈도우를 찾을 수 없음")
            }
            
            window.rootViewController = viewController
            navigationController.viewControllers.removeAll()
            return Observable.just(())
            
        case .push:
            let push = navigationController.rx.didShow
                .delaySubscription(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
                .filter { _ in
                    guard let _ = navigationController.transitionCoordinator?.viewController(forKey: .from),
                          !navigationController.viewControllers.contains(viewController) else {
                        return false
                    }
                    
                    return true
                }
                .map { _ in }
            
            
            navigationController.pushViewController(viewController, animated: animated)
            
            return push
            
        case .modal:
            guard let presenter = navigationController.viewControllers.last else {
                fatalError("Present를 찾을 수 없음.")
            }
            
            return Observable<Void>.create { emitter in
                
                if viewController.conforms(to: UIViewControllerTransitioningDelegate.self) == false {
                    if viewController.modalPresentationStyle == .pageSheet {
                        viewController.modalPresentationStyle = .fullScreen
                    }
                }
                
                presenter.present(viewController, animated: animated) {
                    emitter.onCompleted()
                }
                
                return Disposables.create()
            }
        }
    }
    
    func pop(_ viewController: UIViewController, animated: Bool) {
        guard viewController.isViewLoaded else { return }
        
        if let presenting = viewController.presentedViewController {
            presenting.dismiss(animated: animated)
            return
        }
        
        guard let navigationController = viewController.navigationController else {
            return
        }
        
        guard navigationController.popViewController(animated: animated) != nil else {
            return
        }
    }
}
