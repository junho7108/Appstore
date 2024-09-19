//
//  BaseViewController.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
}
