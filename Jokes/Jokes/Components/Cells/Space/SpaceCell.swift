//
//  SpaceCell.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 10.07.2023.
//

import Foundation
import UIKit

extension SpaceCell {
    class Model {
        var height: CGFloat
        
        init(height: CGFloat) {
            self.height = height
        }
    }
}

class SpaceCell: UITableViewCell {
    weak var spaceView: UIView!
    weak var spaceViewHeightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.setupSubviewsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: SpaceCell.Model) {
        self.spaceViewHeightConstraint?.constant = model.height
    }
    
    private func setupSubviews() {
        self.setupContentView()
        self.setupSpaceView()
    }
    
    private func setupContentView() {
        self.selectionStyle = .none
        self.backgroundColor = ApplicationStyle.colors.transparent()
        self.contentView.backgroundColor = ApplicationStyle.colors.transparent()
    }
    
    private func setupSpaceView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        self.spaceView = view
    }
    
    private func setupSubviewsConstraints() {
        self.setupSpaceViewConstraints()
    }
    
    private func setupSpaceViewConstraints() {
        self.spaceViewHeightConstraint = self.spaceView?.heightAnchor.constraint(equalToConstant: 0)
        self.spaceViewHeightConstraint?.priority = UILayoutPriority.init(999)
        self.spaceViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            self.spaceView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.spaceView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.spaceView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.spaceView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
}
