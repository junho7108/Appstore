//
//  CollectionViewDiffableAdaptable.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import UIKit

protocol CollectionViewDiffableAdaptable: ListAdaptable {
    
    var collectionView: UICollectionView! { get set }
    
    func getCell(_ indexPath: IndexPath, itemModel: ModelAdaptable) -> UICollectionViewCell
}

extension CollectionViewDiffableAdaptable {
    
    func getCell(_ indexPath: IndexPath, itemModel: ModelAdaptable) -> UICollectionViewCell {
   
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: itemModel.identifier,
                                                                            for: indexPath)
        
        if let adaptCell = cell as? CollectionViewCellAdaptable {
            
            adaptCell.adaptOnBind(model: itemModel.model, indexPath: indexPath)
            
            adaptCell.adaptOnUpdate()
        }
        
        return cell
    }
    
    func sizeOfCell(_ indexPath: IndexPath, itemModel: ModelAdaptable) -> CGSize {
        
      
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: itemModel.identifier,
                                                                            for: indexPath)
        
        if let adapatCell = cell as? CollectionViewCellAdaptable {
            
            return adapatCell.adaptComputedSize(model: itemModel.model, indexPath: indexPath)
            
        } else {
            return .zero
        }
    }
    
    
    func didSelectCell(_ indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellAdaptable else { return }
        
        cell.adaptDidSelect(indexPath)
    }
}

