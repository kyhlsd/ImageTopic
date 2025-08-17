//
//  SearchPhotoViewController.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/15/25.
//

import UIKit
import SnapKit
import CHTCollectionViewWaterfallLayout

final class SearchPhotoViewController: UIViewController {

    private let colorCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = AppPadding.horizontalInset
        layout.sectionInset = UIEdgeInsets(top: 0, left: AppPadding.horizontalPadding, bottom: 0, right: 0)
        layout.estimatedItemSize = CGSize(width: 80, height: 28)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: ColorCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let sortButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        let symbolConfig = UIImage.SymbolConfiguration(font: .Detail.bold)
        config.image = UIImage(systemName: "text.alignleft")?.withConfiguration(symbolConfig)
        config.imagePadding = 8
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .white
        button.configuration = config
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.clipsToBounds = true
        return button
    }()
    
    private let photoCollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = 2
        layout.minimumColumnSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: PhotoCollectionViewCell.self)
        return collectionView
    }()
    
    private let viewModel = SearchPhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
        setupDelegates()
        setupActions()
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
        
        [colorCollectionView, sortButton, photoCollectionView].forEach {
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
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(colorCollectionView.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
    private func setupDelegates() {
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
        navigationItem.searchController?.searchBar.delegate = self
    }
    
    private func setupActions() {
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    private func setupBindings() {
        viewModel.output.reloadColorCellTrigger.lazyBind { [weak self] indices in
            let indexPaths = indices.map { IndexPath(item: $0, section: 0)}
            self?.colorCollectionView.reloadItems(at: indexPaths)
        }
        
        viewModel.output.orderBy.bind { [weak self] orderBy in
            self?.setSortButtonTitle(orderBy.description)
        }
        
        viewModel.output.photos.lazyBind { [weak self] _ in
            self?.photoCollectionView.reloadData()
        }
        
        viewModel.output.scrollToTopTrigger.lazyBind { [weak self] _ in
            self?.photoCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
    }
    
    private func setSortButtonTitle(_ text: String) {
        var container = AttributeContainer()
        container.font = UIFont.Detail.bold
        sortButton.configuration?.attributedTitle = AttributedString(text, attributes: container)
    }
    
    @objc
    private func sortButtonTapped() {
        viewModel.input.sortButtonTappedTrigger.value = ()
    }
}

extension SearchPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorCollectionView {
            return viewModel.colors.count
        } else {
            return viewModel.output.photos.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colorCollectionView {
            let cell = collectionView.dequeueReusableCell(cellType: ColorCollectionViewCell.self, for: indexPath)
            cell.configure(color: viewModel.colors[indexPath.item], isSelected: viewModel.getIsSelected(index: indexPath.item))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(cellType: PhotoCollectionViewCell.self, for: indexPath)
            let url = URL(string: viewModel.output.photos.value[indexPath.item].urls.small)
            cell.configureData(url: url)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colorCollectionView {
            viewModel.input.colorCellTappedTrigger.value = indexPath.item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.output.photos.value.count - 6 {
            viewModel.input.paginationTrigger.value = ()
        }
    }
}

extension SearchPhotoViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = viewModel.output.photos.value[indexPath.item]
        let ratio = CGFloat(photo.width) / CGFloat(photo.height)
        let width = (collectionView.frame.width - 4) / 2
        return CGSize(width: width, height: width / ratio)
    }
}

extension SearchPhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.input.searchWord.value = searchBar.text
    }
}
