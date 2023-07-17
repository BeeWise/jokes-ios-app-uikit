//
//  DownloadImageOperation.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import Foundation
import UIKit
import Kingfisher

enum DownloadImageOperationModels {
    struct Request {
        let imageUrl: String?
    }
    
    struct Response {
        let image: UIImage?
    }
}

protocol DownloadTaskLogic {
    func cancel()
}

extension DownloadTask: DownloadTaskLogic {
    
}

class DownloadImageOperation: AsynchronousOperation {
    var model: DownloadImageOperationModels.Request
    private var operationCompletionHandler: ((Result<DownloadImageOperationModels.Response, OperationError>) -> Void)
    
    var downloadTask: DownloadTaskLogic?
    
    init(model: DownloadImageOperationModels.Request, completionHandler: @escaping ((Result<DownloadImageOperationModels.Response, OperationError>) -> Void)) {
        self.model = model
        self.operationCompletionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        guard let imageUrl = self.model.imageUrl, let url = URL(string: imageUrl) else {
            self.noUrlAvailableErrorBlock()
            return
        }
        
        if self.shouldCancelOperation() {
            return
        }
        
        self.downloadTask = KingfisherManager.shared.retrieveImage(with: url) { (result) in
            if self.shouldCancelOperation() {
                return
            }
            switch result {
                case .success(let value): self.successfulResultBlock(response: DownloadImageOperationModels.Response(image: value.image)); break
                case .failure(_): self.noDataAvailableErrorBlock(); break
            }
        }
    }
    
    override func cancel() {
        self.downloadTask?.cancel()
        super.cancel()
    }
    
    func shouldCancelOperation() -> Bool {
        if self.isCancelled {
            self.cancelledOperationErrorBlock()
            return true
        }
        return false
    }
    
    // MARK: - Success
    
    func successfulResultBlock(response: DownloadImageOperationModels.Response) {
        self.operationCompletionHandler(Result.success(response))
        self.completeOperation()
    }
    
    // MARK: - Operation errors
    
    private func noUrlAvailableErrorBlock() {
        self.operationCompletionHandler(Result.failure(OperationError.noUrlAvailable))
        self.completeOperation()
    }
    
    func noDataAvailableErrorBlock() {
        self.operationCompletionHandler(Result.failure(OperationError.noDataAvailable))
        self.completeOperation()
    }
    
    private func cancelledOperationErrorBlock() {
        self.operationCompletionHandler(Result.failure(OperationError.operationCancelled))
        self.completeOperation()
    }
}

class DownloadImageLocalOperation: DownloadImageOperation {
    var shouldFail: Bool = false
    var delay: Int = Int.random(in: 350...1000)
    
    override func main() {
        if self.shouldCancelOperation() {
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(self.delay)) {
            if self.shouldCancelOperation() {
                return
            }
            
            if self.shouldFail {
                self.noDataAvailableErrorBlock()
            } else {
                self.successfulResultBlock(response: DownloadImageOperationModels.Response(image: ApplicationStyle.images.userAvatarPlaceholderSmallImage()))
            }
        }
    }
}
