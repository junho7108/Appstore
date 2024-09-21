//
//  BaseCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import UIKit

class BaseCell<Model: Decodable>: UICollectionViewCell {
    
    public var model: Model?
    
    public var indexPath: IndexPath?
    
    func update(model: Model) { }
    
    func didSelect(model: Model, indexPath: IndexPath) { }
}

extension BaseCell: CollectionViewCellAdaptable {
    func adaptOnBind(model: any Decodable, indexPath: IndexPath) {
        self.model = model as? Model
        self.indexPath = indexPath
    }
    
    func adaptOnUpdate() {
        guard let model else { return }
        
        self.update(model: model)
    }
    
    func adaptDidSelect(_ indexPath: IndexPath) {
        guard let model else { return }
        
        self.didSelect(model: model, indexPath: indexPath)
    }
}

