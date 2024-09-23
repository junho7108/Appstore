//
//  DescriptionCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/23/24.
//

import Foundation
import UIKit
import SnapKit

struct DescriptionCellModel: CellModelProtocol {
    let description: String
    var showMore: Bool = false
    typealias classType = DescriptionCell

}

final class DescriptionCell: BaseCell<DescriptionCellModel>,
                             ActionAttachable {
    
    enum ActionType {
        case didTapShowMoreButton
    }
    
    var completableAction: ((ActionType) -> Void)?
    
    private(set) var didTapShowMore: Bool = false
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .label
        return label
    }()
    
    private lazy var showMoreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitle("더 보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapShowMoreButton), for: .touchUpInside)
        return button
    }()
    
    private(set) var height: CGFloat = 120
  
    override func prepareForReuse() {
        super.prepareForReuse()
        didTapShowMore = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func didTapShowMoreButton() {
        self.completableAction?(.didTapShowMoreButton)
    }
    
    
    override func measuredSize(model: DescriptionCellModel?, indexPath: IndexPath) -> CGSize {
        guard let model else { return .zero }

        let height: CGFloat = model.showMore ? calculateDynamicSize(for: model).height + 34 : 120
        
        return CGSize(width: UIScreen.width, height: height)
    }
    
    override func update(model: DescriptionCellModel) {
        descriptionLabel.text = model.description
        showMoreButton.isHidden = model.showMore
    }
}

private extension DescriptionCell {
    func configureUI() {
        let topDevider = UIView()
        topDevider.backgroundColor = .systemGray4
        
        contentView.addSubview(topDevider)
        topDevider.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        let bottomDevider = UIView()
        bottomDevider.backgroundColor = .systemGray4
        
        contentView.addSubview(bottomDevider)
        bottomDevider.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
       
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(topDevider.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(bottomDevider.snp.top).offset(-16)
        }
        
        contentView.addSubview(showMoreButton)
        showMoreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(descriptionLabel)
            make.width.equalTo(48)
            make.height.equalTo(20)
        }
    }
    
    func calculateDynamicSize(for model: DescriptionCellModel) -> CGSize {
        let cloneLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.font = .systemFont(ofSize: 14, weight: .light)
            label.textColor = .label
            return label
        }()
        
        cloneLabel.text = model.description
        cloneLabel.frame.size.width = UIScreen.width - 32
        
        cloneLabel.sizeToFit()
    
        return cloneLabel.frame.size
    }
}
