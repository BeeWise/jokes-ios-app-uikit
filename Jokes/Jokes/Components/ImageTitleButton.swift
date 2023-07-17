//
//  ImageTitleButton.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 14.07.2023.
//

import Foundation
import UIKit

// MARK: - Model

extension ImageTitleButton {
    class Model {
        var title: NSAttributedString?
        var image: UIImage?
        var imageContentMode: UIView.ContentMode = .scaleAspectFit
        var imageTintColor: UIColor = .clear
        
        var backgroundColor: UIColor = .clear
        
        var borderRadius = ApplicationConstraints.constant.x4.rawValue
        var borderWidth = ApplicationConstraints.constant.x0.rawValue
        var borderColor = ApplicationStyle.colors.primary()

        var activityIndicatorColor = ApplicationStyle.colors.white()

        var isLoading = false
        
        var backgroundImage: UIImage?
        var backgroundImageContentMode: UIView.ContentMode = .scaleAspectFit
    }
}

class ImageTitleButton: UIView {
    weak var backgroundImageView: UIImageView!
    weak var containerView: UIView!
    
    weak var titleLabel: UILabel!
    weak var imageView: UIImageView!
    weak var activityIndicatorView: UIActivityIndicatorView!
    
    init() {
        super.init(frame: .zero)
        self.setupSubviews()
        self.setupSubviewsConstraints()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: ImageTitleButton.Model) {
        self.setBorders(borderRadius: model.borderRadius, borderWidth: model.borderWidth, borderColor: model.borderColor)
        self.setBackgroundImage(model.backgroundImage, contentMode: model.backgroundImageContentMode)
        self.setTitle(model.title)
        self.setImage(model.image, contentMode: model.imageContentMode, tintColor: model.imageTintColor)
        self.setLoading(isLoading: model.isLoading)
    }

    private func setTitle(_ title: NSAttributedString?) {
        self.titleLabel?.attributedText = title
    }
    
    private func setBorders(borderRadius: CGFloat,  borderWidth: CGFloat, borderColor: UIColor) {
        self.containerView?.layer.cornerRadius = borderRadius
        self.containerView?.layer.borderWidth = borderWidth
        self.containerView?.layer.borderColor = borderColor.cgColor
    }
    
    private func setBackgroundImage(_ image: UIImage?, contentMode: UIView.ContentMode) {
        self.backgroundImageView?.image = image
        self.backgroundImageView?.contentMode = contentMode
    }

    private func setImage(_ image: UIImage?, contentMode: UIView.ContentMode, tintColor: UIColor) {
        self.imageView?.image = image
        self.imageView?.contentMode = contentMode
        self.imageView?.tintColor = tintColor
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

// MARK: - Subviews

extension ImageTitleButton {
    private func setupSubviews() {
        self.setupContainerView()
        self.setupBackgroundImageView()
        self.setupImageView()
        self.setupTitleLabel()
        self.setupActivityIndicatorView()
    }
    
    private func setupContainerView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        self.addSubview(view)
        self.containerView = view
    }
    
    private func setupBackgroundImageView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView?.addSubview(imageView)
        self.backgroundImageView = imageView
    }

    private func setupTitleLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.containerView?.addSubview(label)
        self.titleLabel = label
    }
    
    private func setupImageView() {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        self.containerView?.addSubview(view)
        self.imageView = view
    }
    
    private func setupActivityIndicatorView() {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = false
        self.containerView?.addSubview(view)
        self.activityIndicatorView = view
    }
}

// MARK: - Constraints

extension ImageTitleButton {
    private func setupSubviewsConstraints() {
        self.setupContainerViewConstraints()
        self.setupBackgroundImageViewConstraints()
        self.setupImageViewConstraints()
        self.setupTitleLabelConstraints()
        self.setupActivityIndicatorViewConstraints()
    }
    
    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
        ])
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: ApplicationConstraints.constant.x8.rawValue),
            self.imageView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: ApplicationConstraints.multiplier.x62.rawValue),
            self.imageView.widthAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: ApplicationConstraints.multiplier.x62.rawValue)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: ApplicationConstraints.constant.x8.rawValue),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -ApplicationConstraints.constant.x0.rawValue),
        ])
    }
    
    private func setupActivityIndicatorViewConstraints() {
        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor)
        ])
    }
}
