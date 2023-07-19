//
//  JokesBusinessLogicSpy.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-18.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

@testable import Jokes

class JokesBusinessLogicSpy: JokesBusinessLogic {
    var shouldFetchItemsCalled: Bool = false
    var shouldFetchUserAvatarImageCalled: Bool = false
    var shouldSelectReadAnswerCalled: Bool = false
    
    func shouldFetchItems() {
        self.shouldFetchItemsCalled = true
    }
    
    func shouldFetchUserAvatarImage(request: Jokes.JokesModels.UserAvatarFetching.Request) {
        self.shouldFetchUserAvatarImageCalled = true
    }
    
    func shouldSelectReadAnswer(request: Jokes.JokesModels.ItemSelection.Request) {
        self.shouldSelectReadAnswerCalled = true
    }
}
