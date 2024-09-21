//
//  CollectionViewDiffableProtocol.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import UIKit

protocol CollectionViewDiffableProtocol: CollectionViewDiffableAdaptable {
    
    var handler: CollectionViewDiffableHandler! { get set }
}

public class CollectionViewDiffableHandler: NSObject {
    
    private typealias SnapshotType = NSDiffableDataSourceSnapshot<Int, CellModel>
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, CellModel>!
   
    private var collectionView: UICollectionView
    
    weak var adaptable: CollectionViewDiffableAdaptable?
    
    init(adaptable: CollectionViewDiffableAdaptable, collecionView: UICollectionView) {
        self.adaptable = adaptable
        self.collectionView = collecionView
        
        super.init()
        
        self.collectionView.delegate = self
        self.configureDataSource()
    }
}

extension CollectionViewDiffableHandler {
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView,
                                                             cellProvider: {
            [weak self] (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
        
            guard let self, let cell = self.adaptable?.getCell(indexPath, itemModel: itemIdentifier) else { return nil }
         
            return cell
        })
    }
    
    private func createSnapshotItems(_ models: [[CellModel]]) -> SnapshotType {
        
        var snapshot = SnapshotType()
        
        for (index, items) in models.enumerated() {
            snapshot.appendSections([index])
            snapshot.appendItems(items)
        }
        
        return snapshot
    }
    
    func getItem(_ indexPath: IndexPath) -> ModelAdaptable? {
        let sections = self.dataSource.snapshot().sectionIdentifiers
        
        guard indexPath.section < sections.count else { return nil }
        
        let sectionIdentifier = sections[indexPath.section]
        
        let items = self.dataSource.snapshot().itemIdentifiers(inSection: sectionIdentifier)
        
        guard indexPath.item < items.count else { return nil }
        
        return items[indexPath.item]
    }
    
    func initDataSource(_ models: [[ModelAdaptable]]?) {
        guard let models = models as? [[CellModel]] else { return }
        
        let snapshot = self.createSnapshotItems(models)
        
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func updateDataSource(_ models: [[ModelAdaptable]]?, animatingDifferences: Bool = true) {
        guard let models = models as? [[CellModel]] else { return }
        
        let snapshot = self.createSnapshotItems(models)
        
        self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

//MARK: -
extension CollectionViewDiffableHandler: UICollectionViewDelegate {
    
    
    
//    public func collectionView(_ collectionView: UICollectionView, 
//                               layout collectionViewLayout: UICollectionViewLayout,
//                               sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let item = getItem(indexPath) else { return .zero }
//        
//        let size = adaptable.s
//    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.adaptable?.didSelectCell(indexPath)
    }
   
}
