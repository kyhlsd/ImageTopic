//
//  TopicViewController.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import UIKit
import SnapKit

protocol PushDetailVCDelegate: AnyObject {
    func pushDetailVC(_ photoResult: PhotoResult)
}

final class TopicViewController: UIViewController {
    
    private let profileButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 2
        button.clipsToBounds = true
        return button
    }()
    
    private let tableView = {
        let tableView = UITableView()
        tableView.rowHeight = 260
        tableView.register(cellType: TopicTableViewCell.self)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let viewModel = TopicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
        setupDelegates()
        setupActions()
        setupBindings()
        
        viewModel.input.viewDidLoadTrigger.value = ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLayoutSubviews() {
        profileButton.layer.cornerRadius = profileButton.frame.height / 2
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "OUR TOPIC"
        navigationItem.backButtonTitle = " "
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        profileButton.snp.makeConstraints { make in
            make.size.equalTo(36)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupActions() {
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    private func setupBindings() {
        viewModel.output.responseTrigger.lazyBind { [weak self] indexPaths in
            let indexPaths = indexPaths.map { IndexPath(row: $0, section: 0) }
            self?.tableView.reloadRows(at: indexPaths, with: .none)
        }
    }
    
    @objc
    private func profileButtonTapped() {
        let viewController = ProfileSettingViewController()
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TopicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: TopicTableViewCell.self, for: indexPath)
        cell.configure(title: viewModel.topics[indexPath.row].description, photoResults: viewModel.output.photos[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension TopicViewController: PushDetailVCDelegate {
    func pushDetailVC(_ photoResult: PhotoResult) {
        let viewController = PhotoDetailViewController()
        viewController.configureData(photoResult)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TopicViewController: ProfileImageDelegate {
    func setProfileImage(image: String) {
        profileButton.setImage(UIImage(named: image), for: .normal)
    }
}
