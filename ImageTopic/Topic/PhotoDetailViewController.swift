//
//  PhotoDetailViewController.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoDetailViewController: UIViewController {

    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    private let contentView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let photoUserImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    private let photoUserNameLabel = {
        let label = UILabel()
        label.font = .Detail.normal
        return label
    }()
    private let photoDateLabel = {
        let label = UILabel()
        label.font = .Detail.bold
        return label
    }()
    private let heartButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
    
    private let photoImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    private let infoLabel = {
        let label = UILabel()
        label.font = .subtitle
        label.text = "정보"
        return label
    }()
    private let chartLabel = {
        let label = UILabel()
        label.font = .subtitle
        label.text = "차트"
        return label
    }()
    
    private let sizeLabel = {
        let label = UILabel()
        label.font = .Body.bold
        label.text = "크기"
        return label
    }()
    private let viewsLabel = {
        let label = UILabel()
        label.font = .Body.bold
        label.text = "조회수"
        return label
    }()
    private let downloadLabel = {
        let label = UILabel()
        label.font = .Body.bold
        label.text = "다운로드"
        return label
    }()
    private let sizeResultLabel = {
        let label = UILabel()
        label.font = .Body.normal
        return label
    }()
    private let viewsResultLabel = {
        let label = UILabel()
        label.font = .Body.normal
        return label
    }()
    private let downloadResultLabel = {
        let label = UILabel()
        label.font = .Body.normal
        return label
    }()
    private let chartSegmentedControl = {
        let control = UISegmentedControl(items: ["조회", "다운로드"])
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private let viewModel = PhotoDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
        setupActions()
        setupBindings()
        
        viewModel.id = "OEg36vuwa6g"
        viewModel.input.viewDidLoadTrigger.value = ()
    }
    
    override func viewDidLayoutSubviews() {
        photoUserImageView.layer.cornerRadius = photoUserImageView.frame.height / 2
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        navigationItem.title = nil
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [photoUserImageView, photoUserNameLabel, photoDateLabel, heartButton, photoImageView, infoLabel, chartLabel, sizeLabel, viewsLabel, downloadLabel, sizeResultLabel, viewsResultLabel, downloadResultLabel, chartSegmentedControl].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.verticalEdges.equalTo(scrollView)
        }
        
        photoUserImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(AppPadding.verticalPadding)
            make.leading.equalToSuperview().inset(AppPadding.horizontalPadding)
            make.size.equalTo(32)
        }
        
        heartButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppPadding.horizontalPadding)
            make.centerY.equalTo(photoUserImageView)
            make.size.equalTo(28)
        }
        photoUserNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(photoUserImageView.snp.trailing).offset(AppPadding.horizontalInset)
            make.trailing.equalTo(heartButton.snp.leading).offset(-AppPadding.horizontalInset)
            make.top.equalTo(photoUserImageView)
            make.bottom.equalTo(photoUserImageView.snp.centerY)
        }
        photoDateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(photoUserNameLabel)
            make.top.equalTo(photoUserImageView.snp.centerY)
            make.bottom.equalTo(photoUserImageView)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(photoUserImageView.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.equalToSuperview()
            // TODO: 여기 삭제
            make.height.equalTo(400)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(AppPadding.verticalInset)
            make.leading.equalToSuperview().offset(AppPadding.horizontalPadding)
            make.width.equalTo(80)
        }
        sizeLabel.snp.makeConstraints { make in
            make.lastBaseline.equalTo(infoLabel)
            make.leading.equalTo(infoLabel.snp.trailing).offset(AppPadding.horizontalInset)
        }
        sizeResultLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(sizeLabel)
            make.trailing.equalToSuperview().inset(AppPadding.horizontalPadding)
        }
        viewsLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeLabel.snp.bottom).offset(AppPadding.verticalInset)
            make.leading.equalTo(sizeLabel)
        }
        viewsResultLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(viewsLabel)
            make.trailing.equalTo(sizeResultLabel)
        }
        downloadLabel.snp.makeConstraints { make in
            make.top.equalTo(viewsLabel.snp.bottom).offset(AppPadding.verticalInset)
            make.leading.equalTo(sizeLabel)
        }
        downloadResultLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(downloadLabel)
            make.trailing.equalTo(sizeResultLabel)
        }
        chartLabel.snp.makeConstraints { make in
            make.top.equalTo(downloadLabel.snp.bottom).offset(AppPadding.verticalPadding)
            make.horizontalEdges.equalTo(infoLabel)
        }
        chartSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(chartLabel)
            make.leading.equalTo(sizeLabel)
            make.height.equalTo(24)
            // TODO: 여기 삭제
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupActions() {
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        chartSegmentedControl.addTarget(self, action: #selector(controlValueChanged), for: .valueChanged)
    }
    
    private func setupBindings() {
        viewModel.output.statistic.bind { [weak self] statistic in
            self?.viewsResultLabel.text = statistic?.views.total.formatted()
            self?.downloadResultLabel.text = statistic?.downloads.total.formatted()
        }
    }
    
    @objc
    private func heartButtonTapped() {
        print(#function)
    }
    @objc
    private func controlValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
}
