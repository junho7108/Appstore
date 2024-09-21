//
//  CellModelConvertible.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import UIKit

protocol CellModelConvertible: Decodable {
    associatedtype classType: UICollectionViewCell
    
    func toCellModel() -> CellModel
}

extension CellModelConvertible {
    func toCellModel() -> CellModel {
        return CellModel(identifier: String(describing: classType.self),
                                   model: self)
    }
}
