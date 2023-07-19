//
//  ImageTaskSpy.swift
//  JokesTests
//
//  Created by Cristian Crasneanu on 18.07.2023.
//

@testable import Jokes
import UIKit

class ImageTaskSpy: ImageTask {
    var downloadImageCalled: Bool = false
    var shouldFailDownloadImage: Bool = false
    
    convenience init() {
        self.init(environment: .memory)
    }
        
    override func downloadImage(model: ImageTaskModels.Download.Request, completionHandler: @escaping (Result<ImageTaskModels.Download.Response, OperationError>) -> Void) {
        self.downloadImageCalled = true

        if shouldFailDownloadImage {
            completionHandler(Result.failure(OperationError.noDataAvailable))
        } else {
            completionHandler(Result.success(ImageTaskModels.Download.Response(image: UIImage())))
        }
    }
}
