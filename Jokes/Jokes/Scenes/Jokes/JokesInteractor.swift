//
//  JokesInteractor.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

protocol JokesBusinessLogic {
    func shouldFetchItems()
    func shouldFetchUserAvatarImage(request: JokesModels.UserAvatarFetching.Request)
    
    func shouldSelectReadAnswer(request: JokesModels.ItemSelection.Request)
}

class JokesInteractor: JokesBusinessLogic, JokesWorkerDelegate {
    var presenter: JokesPresentationLogic?
    var worker: JokesWorker?
    
    var paginationModel: JokesModels.PaginationModel = JokesModels.PaginationModel()
    
    init() {
        let environment = TaskEnvironment.from(value: BundleConfiguration.string(for: BundleConfiguration.Keys.taskConfiguratorEnvironment))
        TaskConfigurator.shared.environment = environment
        
        self.worker = JokesWorker(delegate: self)
    }
    
    func shouldFetchItems() {
        if !self.paginationModel.isFetchingItems && !self.paginationModel.noMoreItems {
            self.paginationModel.isFetchingItems = true
            self.presenter?.presentLoadingState()
            self.worker?.fetchJokes(page: self.paginationModel.currentPage, limit: self.paginationModel.limit)
        }
    }
    
    func shouldSelectReadAnswer(request: JokesModels.ItemSelection.Request) {
        guard let joke = self.joke(id: request.id) else { return }
        self.paginationModel.readJokes.append(joke)
        self.presenter?.presentReadState(response: JokesModels.ItemReadState.Response(isRead: true, id: joke.uuid))
    }
    
    func successDidFetchJokes(jokes: [Joke]) {
        self.paginationModel.isFetchingItems = false
        self.paginationModel.items.append(contentsOf: jokes)
        self.paginationModel.currentPage += 1
        self.paginationModel.hasError = false

        self.presenter?.presentNotLoadingState()
        self.presenter?.presentItems(response: JokesModels.ItemsPresentation.Response(items: jokes, readJokes: self.paginationModel.readJokes))
        self.presenter?.presentRemoveError()

        self.shouldVerifyNoMoreItems(count: jokes.count)
    }
    
    func failureDidFetchJokes(error: OperationError) {
        self.paginationModel.isFetchingItems = false
        self.paginationModel.hasError = true
        self.presenter?.presentNotLoadingState()
        self.presenter?.presentError(response: JokesModels.ErrorPresentation.Response(error: error))
    }
    
    private func shouldVerifyNoMoreItems(count: Int) {
        if (count < self.paginationModel.limit) {
            self.paginationModel.noMoreItems = true
            self.presenter?.presentNoMoreItems()
        }
    }
    
    private func joke(id: String?) -> Joke? {
        guard let id = id else { return nil }
        return self.paginationModel.items.filter({ $0.uuid == id }).first
    }
}

extension JokesInteractor {
    func shouldFetchUserAvatarImage(request: JokesModels.UserAvatarFetching.Request) {
        if let image = request.model.image {
            self.presenter?.presentUserAvatarImage(response: JokesModels.UserAvatarImagePresentation.Response(model: request.model, image: image))
            self.presenter?.presentUserAvatarNotLoadingState(response: JokesModels.UserAvatarFetching.Response(model: request.model))
        } else if !request.model.isLoading {
            self.presenter?.presentUserAvatarLoadingState(response: JokesModels.UserAvatarFetching.Response(model: request.model))
            self.worker?.fetchUserAvatarImage(model: request.model)
        }
    }
    
    func successDidFetchUserAvatarImage(image: UIImage?, model: UserAvatarView.Model) {
        self.presenter?.presentUserAvatarImage(response: JokesModels.UserAvatarImagePresentation.Response(model: model, image: image))
        self.presenter?.presentUserAvatarNotLoadingState(response: JokesModels.UserAvatarFetching.Response(model: model))
    }
    
    func failureDidFetchUserAvatarImage(error: OperationError, model: UserAvatarView.Model) {
        self.presenter?.presentUserAvatarPlaceholderImage(response: JokesModels.UserAvatarImagePresentation.Response(model: model, image: nil))
        self.presenter?.presentUserAvatarNotLoadingState(response: JokesModels.UserAvatarFetching.Response(model: model))
    }
}


