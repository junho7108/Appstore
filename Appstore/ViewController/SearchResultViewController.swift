//
//  SearchResultViewController.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import UIKit
import RxSwift


final class SearchResultViewController: BaseViewController,
                                        ViewModelBindable {
    
    enum SearchResultSectionType: Hashable {
        case relatedKeywords
        case searchResult
    }
    
    enum SearchResultItemType: Hashable {
        case relatedKeywords(SearchKeyword)
        case searchResult(SearchResult)
    }
    
    typealias SnapshotType = NSDiffableDataSourceSnapshot<SearchResultSectionType, SearchResultItemType>
    typealias ViewModelType = SearchHomeViewModel
    
    var shouldFetchData: Bool { false }
    
    var viewModel: SearchHomeViewModel!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                    collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<SearchResultSectionType, SearchResultItemType>!
    
    override func configureUI() {
        super.configureUI()
        defer {
            configureCollectionView()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func bindViewModel() {
        viewModel.output.sectionType
            .skip(1)
            .withUnretained(self)
            .bind { (self, section) in
                print("🔴 section \(section)")
                let snapshot = self.createSnapshot(section: section)
                self.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .disposed(by: disposeBag)
    }
}

private extension SearchResultViewController {
    
    func createSnapshot(section: SearchResultSectionType) -> SnapshotType {
        var snapshot = SnapshotType()
        
        switch section {
        case .relatedKeywords:
            snapshot.appendSections([.relatedKeywords])
            print("🔴 연관검색어 \(viewModel.output.relatedKeywords.value)")
            snapshot.appendItems(viewModel.output.relatedKeywords.value.map { .relatedKeywords($0)})
        case .searchResult:
            snapshot.appendSections([.searchResult])
            snapshot.appendItems(viewModel.output.searchResults.value.map { .searchResult($0)} )
        }
        
        return snapshot
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: UIScreen.width, height: 100)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let recentKeywordRegistration = UICollectionView.CellRegistration<RecentKeywordCell, SearchKeyword> { 
            cell, indexPath, itemIdentifier in
            print("🟠 keyword \(itemIdentifier.keyword)")
//            cell.configure(itemIdentifier)
        }
        
        let searchResultRegistration = UICollectionView.CellRegistration<SearchResultCell, SearchResult> {
            cell, indexPath, itemIdentifier in
            
            cell.configure(itemIdentifier)
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<SearchResultSectionType, SearchResultItemType>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier -> UICollectionViewCell? in
            
                switch itemIdentifier {
                case .relatedKeywords(let keywords):
                    return collectionView.dequeueConfiguredReusableCell(using: recentKeywordRegistration,
                                                                        for: indexPath,
                                                                        item: keywords)
                    
                case .searchResult(let result):
                    return collectionView.dequeueConfiguredReusableCell(using: searchResultRegistration,
                                                                        for: indexPath,
                                                                        item: result)
                }
            }
        )
    }
}
