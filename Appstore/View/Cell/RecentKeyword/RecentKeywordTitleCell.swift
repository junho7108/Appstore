//
//  RecentKeywordTitleCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/23/24.
//

import UIKit

struct RecentKeywordTitleCellModel: CellModelProtocol {
    var title: String
    typealias classType = RecentKeywordTitleCell
}

final class RecentKeywordTitleCell: BaseCell<RecentKeywordTitleCellModel> {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func measuredSize(model: RecentKeywordTitleCellModel?, indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width, height: 40)
    }
    
    override func update(model: RecentKeywordTitleCellModel) {
        titleLabel.text = model.title
    }
}

private extension RecentKeywordTitleCell {
    func configureUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
