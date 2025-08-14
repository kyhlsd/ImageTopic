//
//  PhotoCollectionViewCell.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoCollectionViewCell: UICollectionViewCell, Identifying {
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configureData(url: URL?) {
        guard let url else { return }
        imageView.kf.setImage(with: url) { [weak self] result in
            guard case .success(let value) = result, let self else { return }
            
            imageView.snp.updateConstraints { make in
                let ratio = value.image.size.width / value.image.size.height
                make.width.equalTo(200 * ratio).priority(999)
            }
            invalidateIntrinsicContentSize()
        }
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(200).priority(999)
            make.width.equalTo(100).priority(999)
        }
    }
}
