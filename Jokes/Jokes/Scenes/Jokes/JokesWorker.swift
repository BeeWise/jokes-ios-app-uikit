//
//  JokesWorker.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

protocol JokesWorkerDelegate: AnyObject {
    func successDidFetchJokes(jokes: [Joke])
    func failureDidFetchJokes(error: OperationError)
    
    func successDidFetchUserAvatarImage(image: UIImage?, model: UserAvatarView.Model)
    func failureDidFetchUserAvatarImage(error: OperationError, model: UserAvatarView.Model)
}

class JokesWorker {
    weak var delegate: JokesWorkerDelegate?
    
    var jokesTask: JokesTaskProtocol = TaskConfigurator.shared.jokesTask()
    var imageTask: ImageTaskProtocol = TaskConfigurator.shared.imageTask()
    
    init(delegate: JokesWorkerDelegate?) {
        self.delegate = delegate
    }
    
    func fetchJokes(page: Int, limit: Int) {        
        self.jokesTask.fetchJokes(model: JokesTaskModels.FetchJokes(page: page, limit: limit)) { result in
            switch result {
            case .success(let jokes): self.delegate?.successDidFetchJokes(jokes: jokes); break
            case .failure(let error): self.delegate?.failureDidFetchJokes(error: error); break
            }
        }
    }
    
    func fetchUserAvatarImage(model: UserAvatarView.Model) {
        self.imageTask.downloadImage(model: ImageTaskModels.Download.Request(imageUrl: model.imageUrl)) { result in
            switch result {
                case .success(let response): self.delegate?.successDidFetchUserAvatarImage(image: response.image, model: model); break
                case .failure(let error): self.delegate?.failureDidFetchUserAvatarImage(error: error, model: model); break
            }
        }
    }
}
