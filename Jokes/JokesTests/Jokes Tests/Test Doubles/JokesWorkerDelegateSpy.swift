//
//  JokesWorkerDelegateSpy.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-18.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

@testable import Jokes
import UIKit

class JokesWorkerDelegateSpy: JokesWorkerDelegate {
    var successDidFetchJokesCalled: Bool = false
    var failureDidFetchJokesCalled: Bool = false
    var successDidFetchUserAvatarImageCalled: Bool = false
    var failureDidFetchUserAvatarImageCalled: Bool = false
    
    
    func successDidFetchJokes(jokes: [Jokes.Joke]) {
        self.successDidFetchJokesCalled = true
    }
    
    func failureDidFetchJokes(error: Jokes.OperationError) {
        self.failureDidFetchJokesCalled = true
    }
    
    func successDidFetchUserAvatarImage(image: UIImage?, model: Jokes.UserAvatarView.Model) {
        self.successDidFetchUserAvatarImageCalled = true
    }
    
    func failureDidFetchUserAvatarImage(error: Jokes.OperationError, model: Jokes.UserAvatarView.Model) {
        self.failureDidFetchUserAvatarImageCalled = true
    }
}
