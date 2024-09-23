//
//  ScreenshotCell.swift
//  Appstore
//
//  Created by Junho Yoon on 9/23/24.
//

import UIKit
import Kingfisher


struct ScreenshotCellModel: CellModelProtocol {
    var screenshotUrl: String
    typealias classType = ScreenshotCell
  
}

final class ScreenshotCell: BaseCell<ScreenshotCellModel> {
    
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        imageView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func measuredSize(model: ScreenshotCellModel?, indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 400)
    }
    
    override func update(model: ScreenshotCellModel) {
        imageView.kf.setImage(with: URL(string: model.screenshotUrl))
    }
}
