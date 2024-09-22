//
//  BaseViewController.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView = .init(style: .large)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
        
        defer { 
            setupActivityIndicator()
        }
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    func configure() { }
    
    func showIndicator() {
        view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    func dismissIndicator() {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
}

private extension BaseViewController {
    func setupActivityIndicator() {
           activityIndicator = UIActivityIndicatorView(style: .large)
           activityIndicator.center = view.center
           activityIndicator.hidesWhenStopped = true
           view.addSubview(activityIndicator)
       }
}
