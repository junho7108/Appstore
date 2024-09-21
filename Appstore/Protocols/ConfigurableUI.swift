//
//  ConfigurableUI.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import UIKit

protocol ConfigurableUI where Self: UIView {
    associatedtype BaseView: UIView
    
    var baseView: BaseView { get set }
    
    func configureBaseView()
}

extension ConfigurableUI {
    func configureBaseView() {
        addSubview(baseView)
        baseView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension ConfigurableUI where Self: UICollectionViewCell {
    func configureBaseView() {
        contentView.addSubview(baseView)
        baseView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
