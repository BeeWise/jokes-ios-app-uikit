//
//  UIScrollView+LoadMore.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 14.07.2023.
//

import UIKit

extension UIScrollView {
    public func shouldLoadMoreBeforeReaching(threshold: CGFloat) -> Bool {
        let currentOffset = self.contentOffset.y
        let maximumOffset = self.contentSize.height - self.frame.size.height
        
        guard self.isDecelerating else { return false }
        guard maximumOffset > 0 else { return false }
        guard currentOffset > 0 else { return false }
        guard currentOffset >= (maximumOffset - threshold) else { return false }
        
        return true
    }
}
