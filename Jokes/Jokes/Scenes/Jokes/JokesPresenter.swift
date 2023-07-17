//
//  JokesPresenter.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

protocol JokesPresentationLogic {
    func presentLoadingState()
    func presentNotLoadingState()

    func presentItems(response: JokesModels.ItemsPresentation.Response)

    func presentNoMoreItems()
    func presentRemoveNoMoreItems()

    func presentError(response: JokesModels.ErrorPresentation.Response)
    func presentRemoveError()
    
    func presentUserAvatarLoadingState(response: JokesModels.UserAvatarFetching.Response)
    func presentUserAvatarNotLoadingState(response: JokesModels.UserAvatarFetching.Response)
    func presentUserAvatarImage(response: JokesModels.UserAvatarImagePresentation.Response)
    func presentUserAvatarPlaceholderImage(response: JokesModels.UserAvatarImagePresentation.Response)
    
    func presentReadState(response: JokesModels.ItemReadState.Response)
}

class JokesPresenter: JokesPresentationLogic {
    weak var displayer: JokesDisplayLogic?
    
    func presentLoadingState() {
        self.displayer?.displayLoadingState()
    }
    
    func presentNotLoadingState() {
        self.displayer?.displayNotLoadingState()
    }
    
    func presentItems(response: JokesModels.ItemsPresentation.Response) {
        self.displayer?.displayItems(viewModel: JokesModels.ItemsPresentation.ViewModel(displayedItems: self.displayedItems(items: response.items, readJokes: response.readJokes)))
    }
    
    func presentNoMoreItems() {
        let text = NSAttributedString(string: JokesLocalization.shared.noMoreItemsText(), attributes: JokesStyle.shared.tableViewModel.noMoreItemsAttributes())
        self.displayer?.displayNoMoreItems(viewModel: JokesModels.NoMoreItemsPresentation.ViewModel(text: text))
    }
    
    func presentRemoveNoMoreItems() {
        self.displayer?.displayRemoveNoMoreItems()
    }
    
    func presentError(response: JokesModels.ErrorPresentation.Response) {
        let viewModel = JokesModels.ErrorPresentation.ViewModel(text: NSAttributedString(string: JokesLocalization.shared.errorText(), attributes: JokesStyle.shared.tableViewModel.errorTextAttributes()))
        self.displayer?.displayError(viewModel: viewModel)
    }
    
    func presentRemoveError() {
        self.displayer?.displayRemoveError()
    }
    
    func presentUserAvatarLoadingState(response: JokesModels.UserAvatarFetching.Response) {
        self.displayer?.displayUserAvatarLoadingState(viewModel: JokesModels.UserAvatarFetching.ViewModel(model: response.model))
    }
    
    func presentUserAvatarNotLoadingState(response: JokesModels.UserAvatarFetching.Response) {
        self.displayer?.displayUserAvatarNotLoadingState(viewModel: JokesModels.UserAvatarFetching.ViewModel(model: response.model))
    }
    
    func presentUserAvatarImage(response: JokesModels.UserAvatarImagePresentation.Response) {
        self.displayer?.displayUserAvatarImage(viewModel: JokesModels.UserAvatarImagePresentation.ViewModel(model: response.model, image: response.image, contentMode: .scaleAspectFill))
    }
    
    func presentUserAvatarPlaceholderImage(response: JokesModels.UserAvatarImagePresentation.Response) {
        self.displayer?.displayUserAvatarImage(viewModel: JokesModels.UserAvatarImagePresentation.ViewModel(model: response.model, image: JokesStyle.shared.jokeCellModel.avatarPlaceholder(), contentMode: .scaleAspectFit))
    }
    
    func presentReadState(response: JokesModels.ItemReadState.Response) {
        self.displayer?.displayReadState(viewModel: JokesModels.ItemReadState.ViewModel(isRead: response.isRead, id: response.id))
    }
}

extension JokesPresenter {
    func displayedItems(items: [Joke], readJokes: [Joke]) -> [JokesModels.DisplayedItem] {
        var displayedItems = [JokesModels.DisplayedItem]()
        displayedItems.append(self.displayedSpaceItem(height: ApplicationConstraints.constant.x16.rawValue))
        items.enumerated().forEach { (index, joke) in
            let isRead = readJokes.contains(where: { $0.uuid == joke.uuid } )
            displayedItems.append(self.displayedJokeItem(joke: joke, isRead: isRead))
            
            if index != (items.count - 1) {
                displayedItems.append(self.displayedSpaceItem(height: ApplicationConstraints.constant.x16.rawValue))
            }
        }
        return displayedItems
    }
    
    func displayedJokeItem(joke: Joke, isRead: Bool) -> JokesModels.DisplayedItem {
        if joke.type == JokeType.qna.rawValue && joke.answer != nil {
            return self.displayedJokeQnaItem(joke: joke, isRead: isRead)
        }
        return self.displayedJokeTextItem(joke: joke)
    }
    
    private func displayedJokeTextItem(joke: Joke) -> JokesModels.DisplayedItem {
        let avatar = self.jokeAvatarViewModel(joke: joke)
        let likeCount = self.jokeLikeViewModel(joke: joke)
        let dislikeCount = self.jokeDislikeViewModel(joke: joke)
        
        let model = JokeTextCell.Model(avatar: avatar)
        model.id = joke.uuid
        model.likeCount = likeCount
        model.dislikeCount = dislikeCount
        model.name = NSAttributedString(string: joke.user?.name ?? String(), attributes: JokesStyle.shared.jokeCellModel.nameTextAttributes())
        model.username = NSAttributedString(string: joke.user?.username ?? String(), attributes: JokesStyle.shared.jokeCellModel.usernameTextAttributes())
        model.text = NSAttributedString(string: joke.text ?? String(), attributes: JokesStyle.shared.jokeCellModel.jokeTextAttributes())
        model.time = NSAttributedString(string: joke.createdAt.timeAgo(), attributes: JokesStyle.shared.jokeCellModel.timeTextAttributes())
        return JokesModels.DisplayedItem(type: .text, model: model)
    }
    
    private func displayedJokeQnaItem(joke: Joke, isRead: Bool) -> JokesModels.DisplayedItem {
        let avatar = self.jokeAvatarViewModel(joke: joke)
        let likeCount = self.jokeLikeViewModel(joke: joke)
        let dislikeCount = self.jokeDislikeViewModel(joke: joke)
        
        let model = JokeQuestionAnswerCell.Model(avatar: avatar)
        model.id = joke.uuid
        model.likeCount = likeCount
        model.dislikeCount = dislikeCount
        model.name = NSAttributedString(string: joke.user?.name ?? String(), attributes: JokesStyle.shared.jokeCellModel.nameTextAttributes())
        model.username = NSAttributedString(string: joke.user?.username ?? String(), attributes: JokesStyle.shared.jokeCellModel.usernameTextAttributes())
        model.text = NSAttributedString(string: joke.text ?? String(), attributes: JokesStyle.shared.jokeCellModel.jokeTextAttributes())
        model.answer = NSAttributedString(string: joke.answer ?? String(), attributes: JokesStyle.shared.jokeCellModel.answerTextAttributes())
        model.time = NSAttributedString(string: joke.createdAt.timeAgo(), attributes: JokesStyle.shared.jokeCellModel.timeTextAttributes())
        model.isRead = isRead
        return JokesModels.DisplayedItem(type: .qna, model: model)
    }
    
    private func displayedSpaceItem(height: CGFloat) -> JokesModels.DisplayedItem {
        return JokesModels.DisplayedItem(type: .space, model: SpaceCell.Model(height: height))
    }
    
    private func jokeAvatarViewModel(joke: Joke) -> UserAvatarView.Model {
        let avatar = UserAvatarView.Model()
        avatar.imageUrl = joke.user?.photo?.url150
        avatar.activityIndicatorColor = JokesStyle.shared.jokeCellModel.avatarActivityColor()
        avatar.cornerRadius = JokesStyle.shared.jokeCellModel.avatarBorderRadius()
        avatar.borderColor = JokesStyle.shared.jokeCellModel.borderColor()
        avatar.borderWidth = JokesStyle.shared.jokeCellModel.borderWidth()
        
        avatar.activityIndicatorColor = JokesStyle.shared.jokeCellModel.avatarActivityColor()
        return avatar
    }
    
    private func jokeLikeViewModel(joke: Joke) -> ImageTitleButton.Model {
        let likeCount = ImageTitleButton.Model()
        likeCount.activityIndicatorColor = JokesStyle.shared.jokeCellModel.likeCountActivityColor()
        likeCount.image = JokesStyle.shared.jokeCellModel.likeCountImage()
        likeCount.imageContentMode = .scaleAspectFit
        likeCount.imageTintColor = JokesStyle.shared.jokeCellModel.unselectedLikeCountTintColor()
        likeCount.backgroundColor = JokesStyle.shared.jokeCellModel.unselectedLikeCountBackgroundColor()
        likeCount.title = NSAttributedString(string: String(joke.likeCount), attributes: JokesStyle.shared.jokeCellModel.unselectedLikeCountAttributes())
        likeCount.borderRadius = ApplicationConstraints.constant.x12.rawValue
        likeCount.borderColor = JokesStyle.shared.jokeCellModel.likeCountBorderColor()
        likeCount.isLoading = false
        return likeCount
    }
    
    private func jokeDislikeViewModel(joke: Joke) -> ImageTitleButton.Model {
        let dislikeCount = ImageTitleButton.Model()
        dislikeCount.activityIndicatorColor = JokesStyle.shared.jokeCellModel.dislikeCountActivityColor()
        dislikeCount.image = JokesStyle.shared.jokeCellModel.dislikeCountImage()
        dislikeCount.imageContentMode = .scaleAspectFit
        dislikeCount.imageTintColor = JokesStyle.shared.jokeCellModel.unselectedDislikeCountTintColor()
        dislikeCount.backgroundColor = JokesStyle.shared.jokeCellModel.unselectedDislikeCountBackgroundColor()
        dislikeCount.title = NSAttributedString(string: String(joke.dislikeCount), attributes: JokesStyle.shared.jokeCellModel.unselectedDislikeCountTintAttributes())
        dislikeCount.borderRadius = ApplicationConstraints.constant.x12.rawValue
        dislikeCount.borderColor = JokesStyle.shared.jokeCellModel.dislikeCountBorderColor()
        dislikeCount.isLoading = false
        return dislikeCount
    }
}
