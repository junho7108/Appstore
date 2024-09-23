//
//  AnalyticsContentView.swift
//  Appstore
//
//  Created by Junho Yoon on 9/23/24.
//

import UIKit

final class AnalyticsContentView: UIView {
    let topView: UIView
    let centerView: UIView
    let bottomView: UIView
    
    init(topView: UIView, centerView: UIView, bottomView: UIView) {
        self.topView = topView
        self.centerView = centerView
        self.bottomView = bottomView
        
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AnalyticsContentView {
    func configureUI() {
    
        addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(centerView.snp.bottom).offset(16)
        }
        
        let rightDevider = UIView()
        rightDevider.backgroundColor = .systemGray4
        
        addSubview(rightDevider)
        rightDevider.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.trailing.equalToSuperview()
            make.width.equalTo(1)
        }

    }
}
