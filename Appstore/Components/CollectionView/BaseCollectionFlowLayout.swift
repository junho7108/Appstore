//
//  BaseCollectionFlowLayout.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import UIKit

class BaseCollectionFlowLayout: UICollectionViewFlowLayout {
    enum Direction { case vertical, horizontal }
    
    override init() {
        super.init()
    }
    
    init(direction: UICollectionView.ScrollDirection,
         sectionInset: UIEdgeInsets = .zero,
         lineSpacing: CGFloat = 8,
         itemSpacing: CGFloat = 8) {
        super.init()
        
        self.scrollDirection = direction
        self.sectionInset = sectionInset
        self.minimumInteritemSpacing = itemSpacing
        self.minimumLineSpacing = lineSpacing
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
