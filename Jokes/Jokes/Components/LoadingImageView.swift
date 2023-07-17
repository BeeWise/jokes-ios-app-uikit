//
//  LoadingImageView.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 10.07.2023.
//

import Foundation
import UIKit

public protocol LoadingImageViewInterface: AnyObject {
    func setLoading(isLoading: Bool)
    func setImage(_ image: UIImage?, contentMode: UIView.ContentMode)
}

public class LoadingImageView: UIImageView, LoadingImageViewInterface {
    public var isRounded: Bool = false
    
    public var activityIndicatorColor: UIColor? = nil {
        didSet {
            self.activityIndicatorView?.color = self.activityIndicatorColor
        }
    }
    
    public weak var activityIndicatorView: UIActivityIndicatorView!
    
    public init() {
        super.init(frame: .zero)
        self.setupActivityIndicatorView()
        self.setupActivityIndicatorViewConstraints()
        self.setLoading(isLoading: false)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupActivityIndicatorView()
        self.setupActivityIndicatorViewConstraints()
        self.setLoading(isLoading: false)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupActivityIndicatorView()
        self.setupActivityIndicatorViewConstraints()
        self.setLoading(isLoading: false)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if self.isRounded {
            self.layer.cornerRadius = min(self.bounds.width, self.bounds.height) / 2
        }
    }
    
    public func setLoading(isLoading: Bool) {
        if isLoading {
            self.startAnimatingActivityIndicatorView()
            self.showActivityIndicatorView()
        } else {
            self.hideActivityIndicatorView()
            self.stopAnimatingActivityIndicatorView()
        }
    }
    
    public func setImage(_ image: UIImage?, contentMode: UIView.ContentMode) {
        self.image = image
        self.contentMode = contentMode
    }
    
    private func setupActivityIndicatorView() {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = self.activityIndicatorColor
        view.hidesWhenStopped = false
        self.addSubview(view)
        self.activityIndicatorView = view
    }
    
    private func setupActivityIndicatorViewConstraints() {
        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func hideActivityIndicatorView() {
        self.activityIndicatorView?.isHidden = true
    }
    
    private func showActivityIndicatorView() {
        self.activityIndicatorView?.isHidden = false
    }
    
    private func startAnimatingActivityIndicatorView() {
        self.activityIndicatorView?.startAnimating()
    }
    
    private func stopAnimatingActivityIndicatorView() {
        self.activityIndicatorView?.stopAnimating()
    }
}
