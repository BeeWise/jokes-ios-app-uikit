//
//  ImageTask.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import Foundation
import UIKit

public enum ImageTaskModels {
    public struct Download {
        public struct Request {
            var imageUrl: String?
        }
        
        public struct Response {
            var image: UIImage?
        }
    }
}

protocol ImageTaskProtocol: TaskProtocol {
    func downloadImage(model: ImageTaskModels.Download.Request, completionHandler: @escaping (Result<ImageTaskModels.Download.Response, OperationError>) -> Void)
}

class ImageTask: ImageTaskProtocol {
    public var downloadImageOperationQueue = OperationQueue()
    
    public var environment: TaskEnvironment
    
    public init(environment: TaskEnvironment) {
        self.environment = environment
    }
    
    func downloadImage(model: ImageTaskModels.Download.Request, completionHandler: @escaping (Result<ImageTaskModels.Download.Response, OperationError>) -> Void) {
        let operationModel = DownloadImageOperationModels.Request(imageUrl: model.imageUrl)
        let operation = self.downloadImageOperation(model: operationModel, completionHandler: completionHandler)
        self.downloadImageOperationQueue.addOperation(operation)
    }
    
    func downloadImageOperation(model: DownloadImageOperationModels.Request, completionHandler: @escaping (Result<ImageTaskModels.Download.Response, OperationError>) -> Void) -> AsynchronousOperation {
        let operationCompletionHandler: ((Result<DownloadImageOperationModels.Response, OperationError>) -> Void) = { result in
            switch result {
                case .success(let response): completionHandler(Result.success(ImageTaskModels.Download.Response(image: response.image))); break
                case .failure(let error): completionHandler(Result.failure(error)); break
            }
        }
        switch self.environment {
            case .production: return DownloadImageOperation(model: model, completionHandler: operationCompletionHandler)
            case .development: return DownloadImageOperation(model: model, completionHandler: operationCompletionHandler)
            case .memory: return DownloadImageLocalOperation(model: model, completionHandler: operationCompletionHandler)
        }
    }
}
