//
//  CollectionViewCellAdaptable.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import UIKit

protocol CollectionViewCellAdaptable: UICollectionViewCell {
    func adaptOnBind(model: Decodable, indexPath: IndexPath)
    
    func adaptOnUpdate()
    
    func adaptDidSelect(_ indexPath: IndexPath)
}



