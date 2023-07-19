//
//  JokesInteractorTests.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-18.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

@testable import Jokes
import XCTest

class JokesInteractorTests: XCTestCase {
    var sut: JokesInteractor!
    var presenterSpy: JokesPresentationLogicSpy!
    var workerSpy: JokesWorkerSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupJokesInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupJokesInteractor() {
        self.sut = JokesInteractor()
        
        self.presenterSpy = JokesPresentationLogicSpy()
        self.sut.presenter = self.presenterSpy
        
        self.workerSpy = JokesWorkerSpy(delegate: self.sut)
        self.sut.worker = self.workerSpy
    }
    
    // MARK: - Business logic tests
    
    func testShouldFetchJokesShouldSetIsFetchingItemsToTrueForPaginationModel() {
        self.sut.paginationModel.isFetchingItems = false
        self.sut.paginationModel.noMoreItems = false
        self.sut.shouldFetchItems()
        XCTAssertTrue(self.sut.paginationModel.isFetchingItems)
    }
    
    func testShouldFetchJokesShouldAskThePresenterToPresentLoadingStateWhenItIsNotFetchingItemsAndThereAreMoreItems() {
        self.sut.paginationModel.isFetchingItems = false
        self.sut.paginationModel.noMoreItems = false
        self.sut.shouldFetchItems()
        XCTAssertTrue(self.presenterSpy.presentLoadingStateCalled)
    }
    
    func testShouldFetchJokesShouldAskTheWorkerToFetchJokesWhenItIsNotFetchingItemsAndThereAreMoreItems() {
        self.sut.paginationModel.isFetchingItems = false
        self.sut.paginationModel.noMoreItems = false
        self.sut.shouldFetchItems()
        XCTAssertTrue(self.workerSpy.fetchJokesCalled)
    }
    
    func testSuccessDidFetchJokesShouldSetIsFetchingItemsToFalseForPaginationModel() {
        self.sut.paginationModel.isFetchingItems = true
        self.sut.successDidFetchJokes(jokes: [])
        XCTAssertFalse(self.sut.paginationModel.isFetchingItems)
    }
    
    func testSuccessDidFetchJokesShouldUpdateJokesForPaginationModel() {
        let items = [Joke(uuid: ""), Joke(uuid: ""), Joke(uuid: "")]
        let itemsLength = items.count
        self.sut.paginationModel.items = items
        
        let jokes = [Joke(uuid: ""), Joke(uuid: ""), Joke(uuid: "")]
        let jokesLength = jokes.count
        self.sut.successDidFetchJokes(jokes: jokes)
        XCTAssertEqual(self.sut.paginationModel.items.count, itemsLength + jokesLength)
    }
    
    func testSuccessDidFetchJokesShouldIncrementCurrentPageForPaginationModel() {
        let currentPage = 0
        self.sut.paginationModel.currentPage = currentPage
        self.sut.successDidFetchJokes(jokes: [])
        XCTAssertEqual(self.sut.paginationModel.currentPage, currentPage + 1)
    }
    
    func testSuccessDidFetchJokesShouldSetHasErrorToFalseForPaginationModel() {
        self.sut.paginationModel.hasError = true
        self.sut.successDidFetchJokes(jokes: [])
        XCTAssertFalse(self.sut.paginationModel.hasError)
    }
    
    func testSuccessDidFetchJokesShouldAskThePresenterToPresentNotLoadingState() {
        self.sut.successDidFetchJokes(jokes: [])
        XCTAssertTrue(self.presenterSpy.presentNotLoadingStateCalled)
    }
    
    func testSuccessDidFetchJokesShouldAskThePresenterToPresentItems() {
        self.sut.successDidFetchJokes(jokes: [])
        XCTAssertTrue(self.presenterSpy.presentItemsCalled)
    }
    
    func testSuccessDidFetchJokesShouldAskThePresenterToPresentRemoveError() {
        self.sut.successDidFetchJokes(jokes: [])
        XCTAssertTrue(self.presenterSpy.presentRemoveErrorCalled)
    }
    
    func testSuccessDidFetchJokesShouldSetNoMoreItemsToTrueForPaginationModelWhenLimitReached() {
        self.sut.paginationModel.limit = 10
        self.sut.paginationModel.noMoreItems = false
        self.sut.successDidFetchJokes(jokes: [])
        XCTAssertTrue(self.sut.paginationModel.noMoreItems)
    }
    
    func testSuccessDidFetchJokesShouldAskThePresenterToPresentNoMoreItemsWhenLimitReached() {
        self.sut.paginationModel.limit = 10
        self.sut.successDidFetchJokes(jokes: [])
        XCTAssertTrue(self.presenterSpy.presentNoMoreItemsCalled)
    }
    
    func testFailureDidFetchJokesShouldUpdatePaginationModel() {
        self.sut.paginationModel.isFetchingItems = true
        self.sut.failureDidFetchJokes(error: OperationError.noDataAvailable)
        XCTAssertFalse(self.sut.paginationModel.isFetchingItems)
    }
    
    func testFailureDidFetchJokesShouldSetHasErrorToTrueForPaginationModel() {
        self.sut.paginationModel.hasError = false
        self.sut.failureDidFetchJokes(error: OperationError.noDataAvailable)
        XCTAssertTrue(self.sut.paginationModel.hasError)
    }
    
    func testFailureDidFetchJokesShouldAskThePresenterToPresentDidFetchJokes() {
        self.sut.failureDidFetchJokes(error: OperationError.noDataAvailable)
        XCTAssertTrue(self.presenterSpy.presentNotLoadingStateCalled)
    }
    
    func testFailureDidFetchJokesShouldAskThePresenterToPresentErrorState() {
        self.sut.failureDidFetchJokes(error: OperationError.noDataAvailable)
        XCTAssertTrue(self.presenterSpy.presentErrorCalled)
    }
    
    func testShouldSelectReadAnswerShouldUpdateReadJokesForPaginationModel() {
        let uuid = "jokeId"
        let joke = Joke(uuid: uuid)
        let jokes = [joke]
        self.sut.paginationModel.items = jokes
        self.sut.paginationModel.readJokes = []
        
        self.sut.shouldSelectReadAnswer(request: JokesModels.ItemSelection.Request(id: uuid))
        XCTAssertEqual(self.sut.paginationModel.readJokes.count, jokes.count)
    }
    
    func testShouldSelectReadAnswerShouldAskThePresenterToPresentReadState() {
        let uuid = "jokeId"
        let joke = Joke(uuid: uuid)
        self.sut.paginationModel.items = [joke]
        
        self.sut.shouldSelectReadAnswer(request: JokesModels.ItemSelection.Request(id: uuid))
        XCTAssertTrue(self.presenterSpy.presentReadStateCalled)
    }
    
    // MARK: - Fetch user profile image tests
    
    func testShouldFetchUserAvatarImageShouldAskThePresenterToPresentUserAvatarImageWhenThereIsImage() {
        let userAvatarModel = UserAvatarView.Model()
        userAvatarModel.image = UIImage()
        userAvatarModel.imageUrl = "https://beewisedevelopment.com/image"
        userAvatarModel.isLoading = false

        self.sut.shouldFetchUserAvatarImage(request: JokesModels.UserAvatarFetching.Request(model: userAvatarModel))
        XCTAssertTrue(self.presenterSpy.presentUserAvatarImageCalled)
    }
    
    func testShouldFetchUserAvatarImageShouldAskThePresenterToPresentNotLoadingImageWhenThereIsImage() {
        let userAvatarModel = UserAvatarView.Model()
        userAvatarModel.image = UIImage()
        userAvatarModel.imageUrl = "https://beewisedevelopment.com/image"
        userAvatarModel.isLoading = false

        self.sut.shouldFetchUserAvatarImage(request: JokesModels.UserAvatarFetching.Request(model: userAvatarModel))
        XCTAssertTrue(self.presenterSpy.presentUserAvatarNotLoadingStateCalled)
    }
        
    func testShouldFetchUserAvatarImageShouldAskThePresenterToPresentUserAvatarLoadingStateWhenThereImageUrlAndNoImageAndIsNotLoadingImage() {
        let userAvatarModel = UserAvatarView.Model()
        userAvatarModel.image = nil
        userAvatarModel.imageUrl = "https://beewisedevelopment.com/image"
        userAvatarModel.isLoading = false

        self.sut.shouldFetchUserAvatarImage(request: JokesModels.UserAvatarFetching.Request(model: userAvatarModel))
        XCTAssertTrue(self.presenterSpy.presentUserAvatarLoadingStateCalled)
    }
    
    func testShouldFetchUserAvatarImageShouldAskTheWorkerToFetchUserAvatarImageWhenThereImageUrlAndNoImageAndIsNotLoadingImage() {
        let userAvatarModel = UserAvatarView.Model()
        userAvatarModel.image = nil
        userAvatarModel.imageUrl = "https://beewisedevelopment.com/image"
        userAvatarModel.isLoading = false
        
        self.sut.shouldFetchUserAvatarImage(request: JokesModels.UserAvatarFetching.Request(model: userAvatarModel))
        XCTAssertTrue(self.workerSpy.fetchUserAvatarImageCalled)
    }
    
    func testSuccessDidFetchUserProfileImageShouldAskThePresenterToPresentUserAvatarNotLoadingState() {
        self.sut.successDidFetchUserAvatarImage(image: nil, model: UserAvatarView.Model())
        XCTAssertTrue(self.presenterSpy.presentUserAvatarNotLoadingStateCalled)
    }
    
    func testSuccessDidFetchUserProfileImageShouldAskThePresenterToPresentUserAvatarImage() {
        self.sut.successDidFetchUserAvatarImage(image: nil, model: UserAvatarView.Model())
        XCTAssertTrue(self.presenterSpy.presentUserAvatarImageCalled)
    }
    
    func testFailureDidFetchUserProfileImageShouldAskThePresenterToPresentUserAvatarNotLoadingState() {
        self.sut.failureDidFetchUserAvatarImage(error: OperationError.noDataAvailable, model: UserAvatarView.Model())
        XCTAssertTrue(self.presenterSpy.presentUserAvatarNotLoadingStateCalled)
    }
    
    func testFailureDidFetchUserProfileImageShouldAskThePresenterToPresentUserAvatarPlaceholderImage() {
        self.sut.failureDidFetchUserAvatarImage(error: OperationError.noDataAvailable, model: UserAvatarView.Model())
        XCTAssertTrue(self.presenterSpy.presentUserAvatarPlaceholderImageCalled)
    }
}
