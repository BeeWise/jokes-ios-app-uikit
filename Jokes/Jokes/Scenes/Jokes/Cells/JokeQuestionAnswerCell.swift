//
//  JokeQuestionAnswerCell.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.07.2023.
//

import Foundation
import UIKit

protocol JokeQuestionAnswerCellDelegate: AnyObject {
    func jokeQuestionAnswerCellOnPressLikeCount(cell: JokeQuestionAnswerCell, id: String?)
    func jokeQuestionAnswerCellOnPressDislikeCount(cell: JokeQuestionAnswerCell, id: String?)
    func jokeQuestionAnswerCellOnPressUserAvatar(cell: JokeQuestionAnswerCell, id: String?)
    func jokeQuestionAnswerCellOnPressUserName(cell: JokeQuestionAnswerCell, id: String?)
    func jokeQuestionAnswerCellOnPressReadAnswer(cell: JokeQuestionAnswerCell, id: String?)
}

// MARK: - Model

extension JokeQuestionAnswerCell {
    class Model {
        var id: String?
        
        var avatar: UserAvatarView.Model
        
        var name: NSAttributedString?
        var username: NSAttributedString?
        var text: NSAttributedString?
        var answer: NSAttributedString?
        
        var isRead: Bool = false
        
        var likeCount: ImageTitleButton.Model?
        var dislikeCount: ImageTitleButton.Model?
        
        var time: NSAttributedString?
                
        init(avatar: UserAvatarView.Model) {
            self.avatar = avatar
        }
    }
}


class JokeQuestionAnswerCell: UITableViewCell {
    weak var containerView: UIView!
    weak var topContainerView: UIView!
    weak var userAvatarView: UserAvatarView!
    
    weak var nameLabel: UILabel!
    weak var usernameLabel: UILabel!
    weak var jokeTextLabel: UILabel!
    
    weak var answerContainerView: UIStackView!
    weak var answerTextLabel: UILabel!
    weak var answerButton: ImageTitleButton!
    
    weak var bottomContainerView: UIView!
    weak var likeCountView: ImageTitleButton!
    weak var dislikeCountView: ImageTitleButton!
    
    weak var timeLabel: UILabel!
    
    weak var delegate: JokeQuestionAnswerCellDelegate?
    
    var cellModel: Model?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.setupSubviewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setModel(_ model: JokeQuestionAnswerCell.Model) {
        self.cellModel = model
        
        self.userAvatarView?.setModel(model.avatar)
        self.nameLabel?.attributedText = model.name
        self.usernameLabel?.attributedText = model.username
        self.jokeTextLabel?.attributedText = model.text
        self.answerTextLabel?.attributedText = model.answer
        self.timeLabel?.attributedText = model.time
        if let likeModel = model.likeCount {
            self.likeCountView?.setModel(likeModel)
        }
        if let dislikeModel = model.dislikeCount {
            self.dislikeCountView?.setModel(dislikeModel)
        }
        
        self.answerTextLabel.isHidden = model.isRead ? false : true
        self.answerButton.isHidden = model.isRead ? true : false
    }
}

// MARK: - Subviews

extension JokeQuestionAnswerCell {
    private func setupSubviews() {
        self.setupContentView()
        self.setupContainerView()
        self.setupTopContainerView()
        self.setupUserAvatarView()
        self.setupNameLabel()
        self.setupUsernameLabel()
        self.setupJokeTextLabel()
        self.setupAnswerContainerView()
        self.setupAnswerTextLabel()
        self.setupAnswerButton()
        self.setupBottomContainerView()
        self.setupLikeCountView()
        self.setupDislikeCountView()
        self.setupTimeLabel()
    }
    
    private func setupContentView() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = ApplicationStyle.colors.transparent()
        self.backgroundColor = ApplicationStyle.colors.transparent()
    }
    
    private func setupContainerView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ApplicationStyle.colors.transparent()
        view.layer.borderWidth = JokesStyle.shared.jokeCellModel.borderWidth()
        view.layer.borderColor = JokesStyle.shared.jokeCellModel.borderColor().cgColor
        view.layer.cornerRadius = JokesStyle.shared.jokeCellModel.cornerRadius()
        self.contentView.addSubview(view)
        self.containerView = view
    }
    
    private func setupTopContainerView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        self.topContainerView = view
    }
    
    private func setupUserAvatarView() {
        let view = UserAvatarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchUpInsideUserAvatar)))
        self.topContainerView?.addSubview(view)
        self.userAvatarView = view
    }
    
    private func setupNameLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchUpInsideUserName)))
        self.topContainerView?.addSubview(label)
        self.nameLabel = label
    }
    
    private func setupUsernameLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.topContainerView?.addSubview(label)
        self.usernameLabel = label
    }
    
    private func setupJokeTextLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.containerView?.addSubview(label)
        self.jokeTextLabel = label
    }
    
    private func setupAnswerContainerView() {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        self.containerView?.addSubview(view)
        self.answerContainerView = view
    }
    
    private func setupAnswerTextLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isHidden = true
        self.answerContainerView?.addArrangedSubview(label)
        self.answerTextLabel = label
    }
    
    private func setupAnswerButton() {
        let view = ImageTitleButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchUpInsideReadAnswerButton)))
        view.isHidden = true
        view.setModel(self.setupAnswerButtonModel())
        self.answerContainerView?.addArrangedSubview(view)
        self.answerButton = view
    }
    
    private func setupAnswerButtonModel() -> ImageTitleButton.Model {
        let model = ImageTitleButton.Model()
        model.image = JokesStyle.shared.jokeCellModel.answerImage()
        model.backgroundImage = JokesStyle.shared.jokeCellModel.answerBackgroundImage()
        model.backgroundImageContentMode = .scaleAspectFill
        model.borderRadius = JokesStyle.shared.jokeCellModel.answerCornerRadius()
        model.borderColor = JokesStyle.shared.jokeCellModel.answerBorderColor()
        model.borderWidth = JokesStyle.shared.jokeCellModel.answerBorderWidth()
        model.backgroundColor = JokesStyle.shared.jokeCellModel.answerBackgroundColor()
        model.title = NSAttributedString(string: JokesLocalization.shared.readAnswerTitle(), attributes: JokesStyle.shared.jokeCellModel.answerButtonAttributes())
        return model
    }
    
    private func setupBottomContainerView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.containerView?.addSubview(view)
        self.bottomContainerView = view
    }
    
    private func setupLikeCountView() {
        let view = ImageTitleButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchUpInsideLikeButton)))
        self.bottomContainerView?.addSubview(view)
        self.likeCountView = view
    }
    
    private func setupDislikeCountView() {
        let view = ImageTitleButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchUpInsideDislikeButton)))
        self.bottomContainerView?.addSubview(view)
        self.dislikeCountView = view
    }
    
    private func setupTimeLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.bottomContainerView?.addSubview(label)
        self.timeLabel = label
    }
}

extension JokeQuestionAnswerCell {
    @objc func touchUpInsideUserAvatar() {
        self.delegate?.jokeQuestionAnswerCellOnPressUserAvatar(cell: self, id: self.cellModel?.id)
    }
    
    @objc func touchUpInsideUserName() {
        self.delegate?.jokeQuestionAnswerCellOnPressUserName(cell: self, id: self.cellModel?.id)
    }
    
    @objc func touchUpInsideLikeButton() {
        self.delegate?.jokeQuestionAnswerCellOnPressLikeCount(cell: self, id: self.cellModel?.id)
    }
    
    @objc func touchUpInsideDislikeButton() {
        self.delegate?.jokeQuestionAnswerCellOnPressDislikeCount(cell: self, id: self.cellModel?.id)
    }
    
    @objc func touchUpInsideReadAnswerButton() {
        self.delegate?.jokeQuestionAnswerCellOnPressReadAnswer(cell: self, id: self.cellModel?.id)
    }
}

// MARK: - Constraints

extension JokeQuestionAnswerCell {
    private func setupSubviewsConstraints() {
        self.setupContainerViewConstraints()
        self.setupTopContainerViewConstraints()
        self.setupUserAvatarViewConstraints()
        
        self.setupNameLabelConstraints()
        self.setupUsernameLabelConstraints()
        self.setupJokeTextLabelConstraints()
        self.setupAnswerContainerViewConstraints()
        self.setupAnswerButtonConstraints()
        
        self.setupBottomContainerViewConstraints()
        self.setupLikeCountViewConstraints()
        self.setupDislikeCountViewConstraints()
        self.setupTimeLabelConstraints()
    }
    
    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: ApplicationConstraints.constant.x16.rawValue),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -ApplicationConstraints.constant.x16.rawValue)
        ])
    }
    
    private func setupTopContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.topContainerView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: ApplicationConstraints.constant.x16.rawValue),
            self.topContainerView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: ApplicationConstraints.constant.x16.rawValue),
            self.topContainerView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -ApplicationConstraints.constant.x16.rawValue)
        ])
    }
    
    private func setupUserAvatarViewConstraints() {
        NSLayoutConstraint.activate([
            self.userAvatarView.topAnchor.constraint(equalTo: self.topContainerView.topAnchor),
            self.userAvatarView.leadingAnchor.constraint(equalTo: self.topContainerView.leadingAnchor),
            
            self.userAvatarView.heightAnchor.constraint(equalToConstant: ApplicationConstraints.constant.x40.rawValue),
            self.userAvatarView.widthAnchor.constraint(equalToConstant: ApplicationConstraints.constant.x40.rawValue)
        ])
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.topContainerView.topAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.userAvatarView.trailingAnchor, constant: ApplicationConstraints.constant.x8.rawValue),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.topContainerView.trailingAnchor, constant: -ApplicationConstraints.constant.x16.rawValue)
        ])
    }
    
    private func setupUsernameLabelConstraints() {
        NSLayoutConstraint.activate([
            self.usernameLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: ApplicationConstraints.constant.x2.rawValue),
            self.usernameLabel.leadingAnchor.constraint(equalTo: self.userAvatarView.trailingAnchor, constant: ApplicationConstraints.constant.x8.rawValue),
            self.usernameLabel.trailingAnchor.constraint(equalTo: self.topContainerView.trailingAnchor, constant: -ApplicationConstraints.constant.x16.rawValue)
        ])
    }
    
    private func setupJokeTextLabelConstraints() {
        NSLayoutConstraint.activate([
            self.jokeTextLabel.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: ApplicationConstraints.constant.x8.rawValue),
            self.jokeTextLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: ApplicationConstraints.constant.x16.rawValue),
            self.jokeTextLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -ApplicationConstraints.constant.x16.rawValue)
        ])
    }
    
    private func setupAnswerContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.answerContainerView.topAnchor.constraint(equalTo: self.jokeTextLabel.bottomAnchor, constant: ApplicationConstraints.constant.x16.rawValue),
            self.answerContainerView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: ApplicationConstraints.constant.x16.rawValue),
            self.answerContainerView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -ApplicationConstraints.constant.x16.rawValue)
        ])
    }

    private func setupAnswerButtonConstraints() {
        NSLayoutConstraint.activate([
            self.answerButton.heightAnchor.constraint(equalToConstant: ApplicationConstraints.constant.x32.rawValue)
        ])
    }
    
    private func setupBottomContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.bottomContainerView.topAnchor.constraint(equalTo: self.answerContainerView.bottomAnchor, constant: ApplicationConstraints.constant.x16.rawValue),
            self.bottomContainerView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -ApplicationConstraints.constant.x16.rawValue),
            self.bottomContainerView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: ApplicationConstraints.constant.x16.rawValue),
            self.bottomContainerView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -ApplicationConstraints.constant.x16.rawValue),
            
            self.bottomContainerView.heightAnchor.constraint(equalToConstant: ApplicationConstraints.constant.x24.rawValue)
        ])
    }
    
    private func setupLikeCountViewConstraints() {
        NSLayoutConstraint.activate([
            self.likeCountView.topAnchor.constraint(equalTo: self.bottomContainerView.topAnchor),
            self.likeCountView.bottomAnchor.constraint(equalTo: self.bottomContainerView.bottomAnchor),
            self.likeCountView.leadingAnchor.constraint(equalTo: self.bottomContainerView.leadingAnchor)
        ])
    }
    
    private func setupDislikeCountViewConstraints() {
        NSLayoutConstraint.activate([
            self.dislikeCountView.topAnchor.constraint(equalTo: self.bottomContainerView.topAnchor),
            self.dislikeCountView.bottomAnchor.constraint(equalTo: self.bottomContainerView.bottomAnchor),
            self.dislikeCountView.leadingAnchor.constraint(equalTo: self.likeCountView.trailingAnchor, constant: ApplicationConstraints.constant.x16.rawValue)
        ])
    }
    
    private func setupTimeLabelConstraints() {
        NSLayoutConstraint.activate([
            self.timeLabel.topAnchor.constraint(equalTo: self.bottomContainerView.topAnchor),
            self.timeLabel.bottomAnchor.constraint(equalTo: self.bottomContainerView.bottomAnchor),
            self.timeLabel.leadingAnchor.constraint(equalTo: self.dislikeCountView.trailingAnchor, constant: ApplicationConstraints.constant.x16.rawValue),
            self.timeLabel.trailingAnchor.constraint(equalTo: self.bottomContainerView.trailingAnchor),
        ])
        
    }
}
