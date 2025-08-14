//
//  TopicViewController.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import UIKit
import SnapKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
        setupDelegates()
        setupActions()
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
    
    @objc
    private func profileButtonTapped() {
        print(#function)
    }
}

extension TopicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: TopicTableViewCell.self, for: indexPath)
        cell.configure(title: "골든 아워")
        return cell
    }
}
