//
//  JokesPresenterTests.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-18.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

@testable import Jokes
import XCTest

class JokesPresenterTests: XCTestCase {
    var sut: JokesPresenter!
    var displayerSpy: JokesDisplayLogicSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupJokesPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupJokesPresenter() {
        self.sut = JokesPresenter()
        
        self.displayerSpy = JokesDisplayLogicSpy()
        self.sut.displayer = self.displayerSpy
    }
    
    // MARK: - Tests
    
    func testPresentLoadingStateShouldAskTheDisplayerToDisplayLoadingState() {
        self.sut.presentLoadingState()
        XCTAssertTrue(self.displayerSpy.displayLoadingStateCalled)
    }
    
    func testPresentNotLoadingStateShouldAskTheDisplayerToDisplayNotLoadingState() {
        self.sut.presentNotLoadingState()
        XCTAssertTrue(self.displayerSpy.displayNotLoadingStateCalled)
    }
    
    func testPresentItemsShouldAskTheDisplayerToDisplayItems() {
        self.sut.presentItems(response: JokesModels.ItemsPresentation.Response(items: [], readJokes: []))
        XCTAssertTrue(self.displayerSpy.displayItemsCalled)
    }
    
    func testPresentNoMoreItemsShouldAskTheDisplayerToDisplayNoMoreItems() {
        self.sut.presentNoMoreItems()
        XCTAssertTrue(self.displayerSpy.displayNoMoreItemsCalled)
    }
    
    func testPresentRemoveNoMoreItemsShouldAskTheDisplayerToDisplayRemoveNoMoreItems() {
        self.sut.presentRemoveNoMoreItems()
        XCTAssertTrue(self.displayerSpy.displayRemoveNoMoreItemsCalled)
    }
    
    func testPresentErrorShouldAskTheDisplayerToDisplayError() {
        self.sut.presentError(response: JokesModels.ErrorPresentation.Response(error: OperationError.noDataAvailable))
        XCTAssertTrue(self.displayerSpy.displayErrorCalled)
    }
    
    func testPresentRemoveErrorShouldAskTheDisplayerToDisplayRemoveError() {
        self.sut.presentRemoveError()
        XCTAssertTrue(self.displayerSpy.displayRemoveErrorCalled)
    }
    
    func testPresentReadStateShouldAskTheDisplayerToDisplayReadState() {
        self.sut.presentReadState(response: JokesModels.ItemReadState.Response(isRead: true, id: "id"))
        XCTAssertTrue(self.displayerSpy.displayReadStateCalled)
    }
    
    func testPresentUserAvatarLoadingStateShouldAskTheDisplayerToDisplayUserAvatarLoadingState() {
        self.sut.presentUserAvatarLoadingState(response: JokesModels.UserAvatarFetching.Response(model: UserAvatarView.Model()))
        XCTAssertTrue(self.displayerSpy.displayUserAvatarLoadingStateCalled)
    }
    
    func testPresentUserAvatarNotLoadingStateShouldAskTheDisplayerToDisplayUserAvatarNotLoadingState() {
        self.sut.presentUserAvatarNotLoadingState(response: JokesModels.UserAvatarFetching.Response(model: UserAvatarView.Model()))
        XCTAssertTrue(self.displayerSpy.displayUserAvatarNotLoadingStateCalled)
    }
    
    func testPresentUserAvatarImageShouldAskTheDisplayerToDisplayUserAvatarImage() {
        self.sut.presentUserAvatarImage(response: JokesModels.UserAvatarImagePresentation.Response(model: UserAvatarView.Model(), image: nil))
        XCTAssertTrue(self.displayerSpy.displayUserAvatarImageCalled)
    }
    
    func testPresentUserAvatarPlaceholderImageShouldAskTheDisplayerToDisplayUserAvatarImage() {
        self.sut.presentUserAvatarPlaceholderImage(response: JokesModels.UserAvatarImagePresentation.Response(model: UserAvatarView.Model(), image: nil))
        XCTAssertTrue(self.displayerSpy.displayUserAvatarImageCalled)
    }
}
