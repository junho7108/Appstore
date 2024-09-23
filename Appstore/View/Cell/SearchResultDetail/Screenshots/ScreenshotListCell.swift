//
//  ScreenshotListCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import UIKit

struct ScreenShotListCellModel: CellModelProtocol {
    var screenshotUrls: [String]
    typealias classType = ScreenshotListCell
}

class ScreenshotListCell: BaseCell<ScreenShotListCellModel>,
                          CollectionViewDiffableProtocol {
    
    var items: [[any ModelAdaptable]]?
    
    lazy var handler: CollectionViewDiffableHandler! = CollectionViewDiffableHandler(adaptable: self,
                                                                                     collecionView: collectionView)
    
    private let layout = BaseCollectionFlowLayout(direction: .horizontal,
                                          sectionInset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
                                          lineSpacing: 16)
    
    lazy var collectionView: UICollectionView! = UICollectionView(frame: .zero,
                                                             collectionViewLayout: layout)
    
    func decorateCell(_ cell: UICollectionViewCell, forItemAt indexPath: IndexPath) { }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func measuredSize(model: ScreenShotListCellModel?, indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width, height: 416)
    }
    
    override func update(model: ScreenShotListCellModel) {
        let cellModels = model.screenshotUrls.map { ScreenshotCellModel(screenshotUrl: $0).toCellModel() }
        handler.updateDataSource([cellModels])
    }
}

