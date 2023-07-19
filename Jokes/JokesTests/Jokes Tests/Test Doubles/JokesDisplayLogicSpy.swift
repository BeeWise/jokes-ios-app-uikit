//
//  JokesDisplayLogicSpy.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-18.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

@testable import Jokes

class JokesDisplayLogicSpy: JokesDisplayLogic {
    var displayLoadingStateCalled: Bool = false
    var displayNotLoadingStateCalled: Bool = false
    var displayItemsCalled: Bool = false
    var displayNoMoreItemsCalled: Bool = false
    var displayRemoveNoMoreItemsCalled: Bool = false
    var displayErrorCalled: Bool = false
    var displayRemoveErrorCalled: Bool = false
    var displayUserAvatarLoadingStateCalled: Bool = false
    var displayUserAvatarNotLoadingStateCalled: Bool = false
    var displayUserAvatarImageCalled: Bool = false
    var displayReadStateCalled: Bool = false
    
    func displayLoadingState() {
        self.displayLoadingStateCalled = true
    }
    
    func displayNotLoadingState() {
        self.displayNotLoadingStateCalled = true
    }
    
    func displayItems(viewModel: Jokes.JokesModels.ItemsPresentation.ViewModel) {
        self.displayItemsCalled = true
    }
    
    func displayNoMoreItems(viewModel: Jokes.JokesModels.NoMoreItemsPresentation.ViewModel) {
        self.displayNoMoreItemsCalled = true
    }
    
    func displayRemoveNoMoreItems() {
        self.displayRemoveNoMoreItemsCalled = true
    }
    
    func displayError(viewModel: Jokes.JokesModels.ErrorPresentation.ViewModel) {
        self.displayErrorCalled = true
    }
    
    func displayRemoveError() {
        self.displayRemoveErrorCalled = true
    }
    
    func displayUserAvatarLoadingState(viewModel: Jokes.JokesModels.UserAvatarFetching.ViewModel) {
        self.displayUserAvatarLoadingStateCalled = true
    }
    
    func displayUserAvatarNotLoadingState(viewModel: Jokes.JokesModels.UserAvatarFetching.ViewModel) {
        self.displayUserAvatarNotLoadingStateCalled = true
    }
    
    func displayUserAvatarImage(viewModel: Jokes.JokesModels.UserAvatarImagePresentation.ViewModel) {
        self.displayUserAvatarImageCalled = true
    }
    
    func displayReadState(viewModel: Jokes.JokesModels.ItemReadState.ViewModel) {
        self.displayReadStateCalled = true
    }
}
