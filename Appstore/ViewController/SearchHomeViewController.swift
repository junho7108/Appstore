//
//  SearchHomeViewController.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class SearchHomeViewController: UIViewController,
                                      ViewModelBindable {
    
    typealias ViewModelType = SearchHomeViewModel
    
    var viewModel: SearchHomeViewModel!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    func bindViewModel() {
        
    }
}

