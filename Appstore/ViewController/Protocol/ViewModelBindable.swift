//
//  ViewModelBindable.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import UIKit
import RxSwift

protocol ViewModelBindable {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    var shouldFetchData: Bool { get }
    var disposeBag: DisposeBag { get set }
    
    func bindViewModel()
    
    init(viewModel: ViewModelType)
}

extension ViewModelBindable where Self: UIViewController {
    var shouldFetchData: Bool { return true }
    
    init(viewModel: ViewModelType) {
        self.init()
        
        self.viewModel = viewModel
        
        bindViewModel()
        
        if let vm = self.viewModel as? (any InputOutputAttachable),
           let input = vm.input as? any DefaultInput,
           shouldFetchData == true {
            input.fetchData.accept(())
        }
    }
}
