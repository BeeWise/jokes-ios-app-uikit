//
//  JokesRouterTests.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-18.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

@testable import Jokes
import XCTest

class JokesRouterTests: XCTestCase {
    var sut: JokesRouter!
    var viewControllerSpy: JokesViewControllerSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupJokesRouter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupJokesRouter() {
        self.sut = JokesRouter()
        
        self.viewControllerSpy = JokesViewControllerSpy()
        self.sut.viewController = self.viewControllerSpy
    }
    
    // MARK: - Tests
    
    
}
