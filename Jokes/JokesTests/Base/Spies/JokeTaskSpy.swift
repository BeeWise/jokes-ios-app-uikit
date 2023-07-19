//
//  JokeTaskSpy.swift
//  JokesTests
//
//  Created by Cristian Crasneanu on 18.07.2023.
//

@testable import Jokes
import UIKit

class JokesTaskSpy: JokesTask {
    var fetchJokesCalled: Bool = false
    var shouldFailFetchJokes: Bool = false
    
    convenience init() {
        self.init(environment: .memory)
    }
    
    override func fetchJokes(model: JokesTaskModels.FetchJokes, completionHandler: @escaping (Result<[Joke], OperationError>) -> Void) {
        self.fetchJokesCalled = true

        if shouldFailFetchJokes {
            completionHandler(Result.failure(OperationError.noDataAvailable))
        } else {
            completionHandler(Result.success([]))
        }
    }
}
