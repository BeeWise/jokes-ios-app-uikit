//
//  JokesViewController.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

class JokesViewController: UIViewController {
    var interactor: JokesBusinessLogic?
    var router: JokesRoutingLogic?

    weak var backgroundImageView: UIImageView!
    weak var tableView: UITableView!
    
    var sections = [JokesModels.Section(), JokesModels.Section()]
    
    // MARK: - Object lifecycle
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = JokesInteractor()
        let presenter = JokesPresenter()
        let router = JokesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.displayer = viewController
        router.viewController = viewController
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        self.setupSubviewsConstraints()
        
        self.interactor?.shouldFetchItems()
    }
}
