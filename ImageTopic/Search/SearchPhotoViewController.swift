//
//  SearchPhotoViewController.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/15/25.
//

import UIKit
import SnapKit

final class SearchPhotoViewController: UIViewController {

    private let colorCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = AppPadding.horizontalInset
        layout.sectionInset = UIEdgeInsets(top: 0, left: AppPadding.horizontalPadding, bottom: 0, right: 0)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: ColorCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let sortButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        let symbolConfig = UIImage.SymbolConfiguration(font: .Detail.bold)
        config.image = UIImage(systemName: "text.alignleft")?.withConfiguration(symbolConfig)
        
        var container = AttributeContainer()
        container.font = UIFont.Detail.bold
        config.attributedTitle = AttributedString("최신순", attributes: container)
        config.imagePadding = 8
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .white
        button.configuration = config
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
        setupDelegates()
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        sortButton.layer.cornerRadius = sortButton.frame.height / 2
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "SEARCH PHOTO"
        navigationItem.backButtonTitle = " "
        navigationItem.searchController = UISearchController()
        
        [colorCollectionView, sortButton].forEach {
            view.addSubview($0)
        }
    }

    private func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(AppPadding.verticalInset)
            make.trailing.equalTo(safeArea).offset(-AppPadding.verticalPadding)
            make.height.equalTo(28)
        }
        
        colorCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(safeArea)
            make.trailing.equalTo(sortButton.snp.leading).offset(-AppPadding.horizontalInset)
            make.verticalEdges.equalTo(sortButton)
        }
    }
    
    private func setupDelegates() {
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
    }
    
    private func setupBindings() {
        
    }
}

extension SearchPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: ColorCollectionViewCell.self, for: indexPath)
        if indexPath.item == 0 {
            cell.configure(text: "검정")
        } else {
            cell.configure(text: "옐로우")
        }
        
        return cell
    }
}
