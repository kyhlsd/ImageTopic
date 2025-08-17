//
//  SearchPhotoCollectionViewCell.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/18/25.
//

import UIKit
import SnapKit

final class SearchPhotoCollectionViewCell: PhotoCollectionViewCell {
    
    private let heartButton = {
        let button = HeartButton()
        button.backgroundColor = .white
        button.clipsToBounds = true
        return button
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        heartButton.layer.cornerRadius = heartButton.frame.height / 2
    }
    
    func configureData(url: URL?, likes: Int, id: String) {
        super.configureData(url: url, likes: likes)
        heartButton.configureData(id: id)
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(heartButton)
        imageView.layer.cornerRadius = 0
    }
    
    override func setupLayout() {
        super.setupLayout()
        heartButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-AppPadding.verticalPadding)
            make.trailing.equalToSuperview().offset(-AppPadding.horizontalPadding)
            make.size.equalTo(28)
        }
    }
}
