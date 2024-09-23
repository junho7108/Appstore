//
//  AppInfoCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import UIKit
import Kingfisher

struct AppInfoCellModel: CellModelProtocol {
    let imageUrl: String
    let trackName: String
    
    typealias classType = AppInfoCell
}


final class AppInfoCell: BaseCell<AppInfoCellModel>,
                         ConfigurableUI{
    
    var baseView: AppInfoContentView = AppInfoContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBaseView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func measuredSize(model: AppInfoCellModel?, indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width, height: 96)
    }
    
    override func update(model: AppInfoCellModel) {
        baseView.imageView.kf.setImage(with: URL(string: model.imageUrl))
        baseView.trackNameLabel.text = model.trackName
    }
}

