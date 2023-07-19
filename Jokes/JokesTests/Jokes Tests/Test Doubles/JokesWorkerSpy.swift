//
//  JokesWorkerSpy.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-18.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

@testable import Jokes

class JokesWorkerSpy: JokesWorker {
    var fetchJokesCalled: Bool = false
    var fetchUserAvatarImageCalled: Bool = false
    
    override func fetchJokes(page: Int, limit: Int) {
        self.fetchJokesCalled = true
    }
    
    override func fetchUserAvatarImage(model: UserAvatarView.Model) {
        self.fetchUserAvatarImageCalled = true
    }
}
