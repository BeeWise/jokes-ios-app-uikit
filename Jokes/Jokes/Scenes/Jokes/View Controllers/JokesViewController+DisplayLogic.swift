//
//  JokesViewController+DisplayLogic.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

protocol JokesDisplayLogic: AnyObject {
    func displayLoadingState()
    func displayNotLoadingState()

    func displayItems(viewModel: JokesModels.ItemsPresentation.ViewModel)

    func displayNoMoreItems(viewModel: JokesModels.NoMoreItemsPresentation.ViewModel)
    func displayRemoveNoMoreItems()

    func displayError(viewModel: JokesModels.ErrorPresentation.ViewModel)
    func displayRemoveError()
    
    func displayUserAvatarLoadingState(viewModel: JokesModels.UserAvatarFetching.ViewModel)
    func displayUserAvatarNotLoadingState(viewModel: JokesModels.UserAvatarFetching.ViewModel)
    func displayUserAvatarImage(viewModel: JokesModels.UserAvatarImagePresentation.ViewModel)
    
    func displayReadState(viewModel: JokesModels.ItemReadState.ViewModel)
}

extension JokesViewController: JokesDisplayLogic {
    func displayLoadingState() {
        DispatchQueue.main.async {
            let section = JokesModels.SectionIndex.footer.rawValue
            self.sections[section].isLoading = true
            self.tableView?.reloadSectionsWithoutAnimation(sections: IndexSet(integer: section))
        }
    }
    
    func displayNotLoadingState() {
        DispatchQueue.main.async {
            let section = JokesModels.SectionIndex.footer.rawValue
            self.sections[section].isLoading = false
            self.tableView?.reloadSectionsWithoutAnimation(sections: IndexSet(integer: section))
        }
    }
    
    func displayItems(viewModel: JokesModels.ItemsPresentation.ViewModel) {
        DispatchQueue.main.async {
            self.appendDisplayedItems(items: viewModel.displayedItems)
        }
    }
    
    func displayNoMoreItems(viewModel: JokesModels.NoMoreItemsPresentation.ViewModel) {
        DispatchQueue.main.async {
            let section = JokesModels.SectionIndex.footer.rawValue
            self.sections[section].noMoreItemsText = viewModel.text
            self.sections[section].noMoreItems = true
            self.tableView?.reloadSectionsWithoutAnimation(sections: IndexSet(integer: section))
        }
    }
    
    func displayRemoveNoMoreItems() {
        DispatchQueue.main.async {
            let section = JokesModels.SectionIndex.footer.rawValue
            self.sections[section].noMoreItemsText = nil
            self.sections[section].noMoreItems = false
            self.tableView?.reloadSectionsWithoutAnimation(sections: IndexSet(integer: section))
        }
    }
    
    func displayError(viewModel: JokesModels.ErrorPresentation.ViewModel) {
        DispatchQueue.main.async {
            let section = JokesModels.SectionIndex.footer.rawValue
            self.sections[section].errorText = viewModel.text
            self.sections[section].hasError = true
            self.tableView?.reloadSectionsWithoutAnimation(sections: IndexSet(integer: section))
        }
    }
    
    func displayRemoveError() {
        DispatchQueue.main.async {
            let section = JokesModels.SectionIndex.footer.rawValue
            self.sections[section].errorText = nil
            self.sections[section].hasError = false
            self.tableView?.reloadSectionsWithoutAnimation(sections: IndexSet(integer: section))
        }
    }
    
    func displayUserAvatarLoadingState(viewModel: JokesModels.UserAvatarFetching.ViewModel) {
        DispatchQueue.main.async {
            viewModel.model.isLoading = true
            viewModel.model.cellInterface?.setLoading(isLoading: true)
        }
    }
    
    func displayUserAvatarNotLoadingState(viewModel: JokesModels.UserAvatarFetching.ViewModel) {
        DispatchQueue.main.async {
            viewModel.model.isLoading = false
            viewModel.model.cellInterface?.setLoading(isLoading: false)
        }
    }
    
    func displayUserAvatarImage(viewModel: JokesModels.UserAvatarImagePresentation.ViewModel) {
        DispatchQueue.main.async {
            viewModel.model.image = viewModel.image
            viewModel.model.contentMode = viewModel.contentMode
            viewModel.model.cellInterface?.setImage(viewModel.image, contentMode: viewModel.contentMode)
        }
    }
    
    func displayReadState(viewModel: JokesModels.ItemReadState.ViewModel) {
        DispatchQueue.main.async {
            if let indexedModel = self.indexedQnaModel(id: viewModel.id) {
                indexedModel.model?.isRead = viewModel.isRead
                if let indexPath = self.indexPathFor(id: viewModel.id, itemType: .qna) {
                    self.tableView?.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
}

// MARK: - Auxiliary

extension JokesViewController {
    private func appendDisplayedItems(items: [JokesModels.DisplayedItem]) {
        let section = JokesModels.SectionIndex.items.rawValue
        let index = self.sections[section].items.count
        let indexPaths = items.enumerated().map({ IndexPath(row: index + $0.offset, section: section) })
        self.sections[section].items.append(contentsOf: items)
        self.tableView?.insertRowsWithoutAnimation(at: indexPaths)
    }
    
    private func displayedQnaModel(id: String?) -> JokeQuestionAnswerCell.Model? {
        let items = self.sections[JokesModels.SectionIndex.items.rawValue].items.filter({ $0.type == .qna })
        for item in items {
            let model = item.model as? JokeQuestionAnswerCell.Model
            if model?.id == id {
                return model
            }
        }
        return nil
    }
    
    private func indexedQnaModel(id: String?) -> (index: IndexPath, model: JokeQuestionAnswerCell.Model?)? {
        let items = self.sections[JokesModels.SectionIndex.items.rawValue].items
        for item in items.enumerated() {
            let model = item.element.model as? JokeQuestionAnswerCell.Model
            if model?.id == id {
                return (index: IndexPath.init(item: 0, section: 0), model: model)
            }
        }
        return nil
    }
    
    private func condi(id: String?, item: JokesModels.DisplayedItem) -> Bool {
        guard let model = item.model as? JokeQuestionAnswerCell.Model else { return false }
        
        return model.id == id
    }
    
    private func indexPathFor(id: String?, itemType: JokesModels.ItemType) -> IndexPath? {
        for section in self.sections.enumerated() {
            if let itemIndex = section.element.items.firstIndex(where: { self.condi(id: id, item: $0) }) {
                return IndexPath(item: itemIndex, section: section.offset)
            }
        }
        return nil
    }
}
