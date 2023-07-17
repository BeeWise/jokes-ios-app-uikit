//
//  JokesViewController+Subviews.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

extension JokesViewController {
    func setupSubviews() {
        self.setupNavigationBar()
        self.setupContentView()
        self.setupBackgroundImageView()
        self.setupTableView()
    }
    
    private func setupContentView() {
        self.view.backgroundColor = JokesStyle.shared.contentViewModel.backgroundColor()
    }
    
    private func setupNavigationBar() { 
        self.navigationItem.titleView = UIImageView(image: JokesStyle.shared.navigationBarModel.titleViewImage())
    }
    
    private func setupBackgroundImageView() {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = JokesStyle.shared.contentViewModel.backgroundImage()
        self.view?.addSubview(view)
        self.backgroundImageView = view
    }
    
    private func setupTableView() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = JokesStyle.shared.tableViewModel.backgroundColor()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JokeTextCell.self, forCellReuseIdentifier: JokeTextCell.defaultReuseIdentifier)
        tableView.register(JokeQuestionAnswerCell.self, forCellReuseIdentifier: JokeQuestionAnswerCell.defaultReuseIdentifier)
        tableView.register(SpaceCell.self, forCellReuseIdentifier: SpaceCell.defaultReuseIdentifier)
        self.view.addSubview(tableView)
        self.tableView = tableView
    }
}

extension JokesViewController {
    func setupSubviewsConstraints() {
        self.setupBackgroundImageViewConstraints()
        self.setupTableViewConstraints()
    }
    
    func setupBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
