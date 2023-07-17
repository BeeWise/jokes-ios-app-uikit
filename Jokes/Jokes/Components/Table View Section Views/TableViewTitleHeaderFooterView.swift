//
//  TableViewTitleHeaderFooterView.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import UIKit

public class TableViewTitleHeaderFooterView: UITableViewHeaderFooterView, DefaultReuseIdentifier {
    public weak var titleLabel: UILabel!
    
    public convenience init() {
        self.init(reuseIdentifier: TableViewTitleHeaderFooterView.defaultReuseIdentifier)
    }
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.setupSubviewsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    public func setTitle(title: NSAttributedString?) {
        self.titleLabel?.attributedText = title
    }
}

// MARK: - Subviews

extension TableViewTitleHeaderFooterView {
    private func setupSubviews() {
        self.setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        self.titleLabel = label
    }
}

// MARK: - Constraints

extension TableViewTitleHeaderFooterView {
    private func setupSubviewsConstraints() {
        self.setupTitleLabelConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
}
