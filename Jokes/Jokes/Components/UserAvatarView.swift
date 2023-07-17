//
//  UserAvatarView.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 10.07.2023.
//

import Foundation
import UIKit

protocol UserAvatarViewDelegate: AnyObject {
    func userAvatarViewOnPress(view: UserAvatarView)
}

class UserAvatarView: UIView, LoadingImageViewInterface {
    weak var containerView: UIView!
    weak var loadingImageView: LoadingImageView!
    
    var delegate: UserAvatarViewDelegate?
    
    public init() {
        super.init(frame: .zero)
        self.setupSubviews()
        self.setupSubviewsConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    public func setModel(_ model: UserAvatarView.Model) {
        model.cellInterface = self
        self.loadingImageView.setLoading(isLoading: model.isLoading)
        self.loadingImageView.setImage(model.image, contentMode: model.contentMode)
        self.setBackgroundColor(color: model.backgroundColor)
        self.setBorder(width: model.borderWidth, color: model.borderColor, cornerRadius: model.cornerRadius)
    }
    
    public func setupBackground(color: UIColor) {
        self.containerView.backgroundColor = color
    }
    
    public func setBackgroundColor(color: UIColor) {
        self.containerView?.backgroundColor = color
    }
    
    public func setBorder(width: CGFloat, color: UIColor, cornerRadius: CGFloat) {
        self.containerView?.layer.borderWidth = width
        self.containerView?.layer.borderColor = color.cgColor
        self.containerView?.layer.cornerRadius = cornerRadius
    }
    
    func setLoading(isLoading: Bool) {
        self.loadingImageView.setLoading(isLoading: isLoading)
    }
    
    func setImage(_ image: UIImage?, contentMode: UIView.ContentMode) {
        self.loadingImageView.setImage(image, contentMode: contentMode)
    }
}

extension UserAvatarView {
    class Model {
        var activityIndicatorColor: UIColor = .clear
        var isLoading: Bool = false

        var borderWidth: CGFloat = .zero
        var borderColor: UIColor = .clear
        var cornerRadius: CGFloat = .zero

        var backgroundColor: UIColor = .clear

        var imageUrl: String?
        var image: UIImage?
        var contentMode: UIView.ContentMode = .scaleAspectFill
        
        weak var cellInterface: LoadingImageViewInterface?
    }
}

// MARK: - Subviews configuration

extension UserAvatarView {
    private func setupSubviews() {
        self.setupContainerView()
        self.setupLoadingImageViews()
    }
    
    private func setupContainerView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.masksToBounds = true
        self.addSubview(view)
        self.containerView = view
    }
    
    private func setupLoadingImageViews() {
        let view = LoadingImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        self.containerView?.addSubview(view)
        self.loadingImageView = view
    }
}

// MARK: - Constraints configuration

extension UserAvatarView {
    private func setupSubviewsConstraints() {
        self.setupContainerViewConstraints()
        self.setupLoadingImageViewConstraints()
    }
    
    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupLoadingImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.loadingImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.loadingImageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.loadingImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.loadingImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
        ])
    }
}


