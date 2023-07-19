//
//  JokesWorkerTests.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-18.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

@testable import Jokes
import XCTest

class JokesWorkerTests: XCTestCase {
    var sut: JokesWorker!
    var delegateSpy: JokesWorkerDelegateSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupJokesWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupJokesWorker() {
        self.delegateSpy = JokesWorkerDelegateSpy()
        self.sut = JokesWorker(delegate: self.delegateSpy)
    }
    
    // MARK: - Fetch jokes tests
    
    func testFetchJokesShouldAskTheReportTaskToCreateReport() {
        let taskSpy = JokesTaskSpy()
        self.sut.jokesTask = taskSpy
        self.sut.fetchJokes(page: 0, limit: 10)
        XCTAssertTrue(taskSpy.fetchJokesCalled)
    }
    
    func testFetchJokesForSuccessCase() {
        let taskSpy = JokesTaskSpy()
        taskSpy.shouldFailFetchJokes = false
        self.sut.jokesTask = taskSpy
        self.sut.fetchJokes(page: 0, limit: 10)
        XCTAssertTrue(self.delegateSpy.successDidFetchJokesCalled)
    }
    
    func testFetchJokesShouldAskTheDelegateToSendErrorForFailureCase() {
        let taskSpy = JokesTaskSpy()
        taskSpy.shouldFailFetchJokes = true
        self.sut.jokesTask = taskSpy
        self.sut.fetchJokes(page: 0, limit: 10)
        XCTAssertTrue(self.delegateSpy.failureDidFetchJokesCalled)
    }
}
