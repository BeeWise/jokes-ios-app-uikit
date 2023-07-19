//
//  JokesPresentationLogicSpy.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-18.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

@testable import Jokes

class JokesPresentationLogicSpy: JokesPresentationLogic {
    var presentLoadingStateCalled: Bool = false
    var presentNotLoadingStateCalled: Bool = false
    var presentItemsCalled: Bool = false
    var presentNoMoreItemsCalled: Bool = false
    var presentRemoveNoMoreItemsCalled: Bool = false
    var presentErrorCalled: Bool = false
    var presentRemoveErrorCalled: Bool = false
    var presentUserAvatarLoadingStateCalled: Bool = false
    var presentUserAvatarNotLoadingStateCalled: Bool = false
    var presentUserAvatarImageCalled: Bool = false
    var presentUserAvatarPlaceholderImageCalled: Bool = false
    var presentReadStateCalled: Bool = false
    
    func presentLoadingState() {
        self.presentLoadingStateCalled = true
    }
    
    func presentNotLoadingState() {
        self.presentNotLoadingStateCalled = true
    }
    
    func presentItems(response: Jokes.JokesModels.ItemsPresentation.Response) {
        self.presentItemsCalled = true
    }
    
    func presentNoMoreItems() {
        self.presentNoMoreItemsCalled = true
    }
    
    func presentRemoveNoMoreItems() {
        self.presentRemoveNoMoreItemsCalled = true
    }
    
    func presentError(response: Jokes.JokesModels.ErrorPresentation.Response) {
        self.presentErrorCalled = true
    }
    
    func presentRemoveError() {
        self.presentRemoveErrorCalled = true
    }
    
    func presentUserAvatarLoadingState(response: Jokes.JokesModels.UserAvatarFetching.Response) {
        self.presentUserAvatarLoadingStateCalled = true
    }
    
    func presentUserAvatarNotLoadingState(response: Jokes.JokesModels.UserAvatarFetching.Response) {
        self.presentUserAvatarNotLoadingStateCalled = true
    }
    
    func presentUserAvatarImage(response: Jokes.JokesModels.UserAvatarImagePresentation.Response) {
        self.presentUserAvatarImageCalled = true
    }
    
    func presentUserAvatarPlaceholderImage(response: Jokes.JokesModels.UserAvatarImagePresentation.Response) {
        self.presentUserAvatarPlaceholderImageCalled = true
    }
    
    func presentReadState(response: Jokes.JokesModels.ItemReadState.Response) {
        self.presentReadStateCalled = true
    }
}
