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
   
    var collectionView: UICollectionView
    
    weak var adaptable: CollectionViewDiffableAdaptable?
    
    init(adaptable: CollectionViewDiffableAdaptable, collecionView: UICollectionView) {
        self.adaptable = adaptable
        self.collectionView = collecionView

        super.init()
    
        registerCells()
        configureDataSource()
        
        self.collectionView.delegate = self
    }
    
    func registerCells() { 
        collectionView.register(cellWithClass: RecentKeywordTitleCell.self)
        collectionView.register(cellWithClass: RecentKeywordCell.self)
        
        collectionView.register(cellWithClass: RelatedKeywordCell.self)
        collectionView.register(cellWithClass: DuplicatedKeywordCell.self)
        
        collectionView.register(cellWithClass: SearchResultCell.self)
        collectionView.register(cellWithClass: AppInfoCell.self)
        collectionView.register(cellWithClass: AnalyticsCell.self)
        collectionView.register(cellWithClass: ScreenshotListCell.self)
        collectionView.register(cellWithClass: ScreenshotCell.self)
        collectionView.register(cellWithClass: DescriptionCell.self)
    }
}

extension CollectionViewDiffableHandler {
    private func configureDataSource() {
        
        self.dataSource = UICollectionViewDiffableDataSource(collectionView: adaptable!.collectionView,
                                                             cellProvider: {
            [weak self] (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            
            guard let self,
                  let cell = self.adaptable?.getCell(indexPath, itemModel: itemIdentifier) else { return nil }

            return cell
        })
    }
    
    private func createSnapshotItems(_ models: [[CellModel]]) -> SnapshotType {
        var snapshot = SnapshotType()
        
        for (index, items) in models.enumerated() {
            snapshot.appendSections([index])
            snapshot.appendItems(items, toSection: index)
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
    
    func updateDataSource(_ models: [[ModelAdaptable]]?, animatingDifferences: Bool = false) {
        guard let models = models as? [[CellModel]] else { return }
        
        let snapshot = self.createSnapshotItems(models)
  
        self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewDiffableHandler: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let item = getItem(indexPath) else { return .zero }
        
        let size = self.adaptable?.sizeOfCell(indexPath, itemModel: item) ?? .zero
        
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.adaptable?.didSelectCell(indexPath)
    }
   
}
