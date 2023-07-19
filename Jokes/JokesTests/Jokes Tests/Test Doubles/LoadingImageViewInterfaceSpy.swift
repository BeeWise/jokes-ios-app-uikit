//
//  LoadingImageViewInterfaceSpy.swift
//  JokesTests
//
//  Created by Cristian Crasneanu on 18.07.2023.
//

@testable import Jokes
import UIKit

class LoadingImageViewInterfaceSpy: NSObject, LoadingImageViewInterface {
    var setLoadingCalled: Bool = false
    var setImageCalled: Bool = false
    
    func setLoading(isLoading: Bool) {
        self.setLoadingCalled = true
    }
    
    func setImage(_ image: UIImage?, contentMode: UIView.ContentMode) {
        self.setImageCalled = true
    }
}
