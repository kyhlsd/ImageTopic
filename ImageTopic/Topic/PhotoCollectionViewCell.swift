//
//  PhotoCollectionViewCell.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell, Identifying {
    let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.clipsToBounds = true
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    private let starContainerView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.clipsToBounds = true
        return view
    }()
    
    private let starImageview = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        return imageView
    }()
    
    private let likeLabel = {
        let label = UILabel()
        label.font = .Detail.normal
        label.textColor = .white
        return label
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
        likeLabel.text = nil
    }
    
    override func draw(_ rect: CGRect) {
        starContainerView.layer.cornerRadius = starContainerView.frame.height / 2
    }
    
    func configureData(url: URL?, likes: Int) {
        guard let url else { return }
        imageView.kf.setImage(with: url)
        likeLabel.text = likes.formatted()
    }
    
    func setupUI() {
        [imageView, starContainerView].forEach {
            contentView.addSubview($0)
        }
        [starImageview, likeLabel].forEach {
            starContainerView.addSubview($0)
        }
    }
    
    func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        starContainerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-AppPadding.verticalPadding)
            make.leading.equalToSuperview().offset(AppPadding.horizontalPadding)
        }
        starImageview.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(AppPadding.horizontalInset)
            make.verticalEdges.equalToSuperview().inset(4)
            make.size.equalTo(12)
        }
        likeLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImageview.snp.trailing).offset(AppPadding.horizontalInset)
            make.verticalEdges.equalTo(starImageview)
            make.trailing.equalToSuperview().offset(-AppPadding.horizontalInset)
        }
    }
}
