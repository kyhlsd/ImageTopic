//
//  TopicTableViewCell.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import UIKit

final class TopicTableViewCell: UITableViewCell, Identifying {

    private let titleLabel = {
        let label = UILabel()
        label.font = .title
        return label
    }()
    
    private let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = AppPadding.horizontalInset
        layout.sectionInset = UIEdgeInsets(top: 0, left: AppPadding.horizontalPadding, bottom: 0, right: AppPadding.horizontalPadding)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: PhotoCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var list = [PhotoResult]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        setupDelegates()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configure(title: String, photoResults: [PhotoResult]) {
        titleLabel.text = title
        list = photoResults
        collectionView.reloadData()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        [titleLabel, collectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(AppPadding.verticalInset)
            make.horizontalEdges.equalToSuperview().inset(AppPadding.horizontalPadding)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(AppPadding.verticalPadding)
        }
    }
    
    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension TopicTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: PhotoCollectionViewCell.self, for: indexPath)
        let url = URL(string: list[indexPath.item].urls.small)
        cell.configureData(url: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = list[indexPath.item]
        let ratio = CGFloat(photo.width) / CGFloat(photo.height)
        let height = collectionView.frame.height
        return CGSize(width: height * ratio, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
