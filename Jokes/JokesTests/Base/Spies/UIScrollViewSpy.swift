//
//  UIScrollViewSpy.swift
//  JokesTests
//
//  Created by Cristian Crasneanu on 19.07.2023.
//

import UIKit

class UIScrollViewSpy: UIScrollView {
    var shouldDecelerate: Bool = false
    override var isDecelerating: Bool {
        return self.shouldDecelerate
    }
}
