//
//  JokesViewController+TableViewDataSource.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 10.07.2023.
//

import Foundation
import UIKit

extension JokesViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedItem = self.sections[indexPath.section].items[indexPath.row]
        switch displayedItem.type {
            case .qna: return self.jokeQuestionAnswerCell(tableView: tableView, indexPath: indexPath, item: displayedItem)
            case .text: return self.jokeTextCell(tableView: tableView, indexPath: indexPath, item: displayedItem)
            case .space: return self.spaceCell(tableView: tableView, indexPath: indexPath, item: displayedItem)
        }
    }
}

// MARK: - Jokes text

extension JokesViewController {
    private func jokeTextCell(tableView: UITableView, indexPath: IndexPath, item: JokesModels.DisplayedItem) -> JokeTextCell {
        guard let model = item.model as? JokeTextCell.Model else {
            return JokeTextCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: JokeTextCell.defaultReuseIdentifier, for: indexPath) as? JokeTextCell ?? JokeTextCell()
        cell.setModel(model)
        self.interactor?.shouldFetchUserAvatarImage(request: JokesModels.UserAvatarFetching.Request(model: model.avatar))
        return cell
    }
}

// MARK: - Jokes question and answer

extension JokesViewController: JokeQuestionAnswerCellDelegate {
    private func jokeQuestionAnswerCell(tableView: UITableView, indexPath: IndexPath, item: JokesModels.DisplayedItem) -> JokeQuestionAnswerCell {
        guard let model = item.model as? JokeQuestionAnswerCell.Model else {
            return JokeQuestionAnswerCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: JokeQuestionAnswerCell.defaultReuseIdentifier, for: indexPath) as? JokeQuestionAnswerCell ?? JokeQuestionAnswerCell()
        cell.setModel(model)
        cell.delegate = self
        self.interactor?.shouldFetchUserAvatarImage(request: JokesModels.UserAvatarFetching.Request(model: model.avatar))
        return cell
    }
    
    func jokeQuestionAnswerCellOnPressLikeCount(cell: JokeQuestionAnswerCell, id: String?) {
        
    }
    
    func jokeQuestionAnswerCellOnPressDislikeCount(cell: JokeQuestionAnswerCell, id: String?) {
        
    }
    
    func jokeQuestionAnswerCellOnPressUserAvatar(cell: JokeQuestionAnswerCell, id: String?) {
        
    }
    
    func jokeQuestionAnswerCellOnPressUserName(cell: JokeQuestionAnswerCell, id: String?) {
        
    }
    
    func jokeQuestionAnswerCellOnPressReadAnswer(cell: JokeQuestionAnswerCell, id: String?) {
        self.interactor?.shouldSelectReadAnswer(request: JokesModels.ItemSelection.Request(id: id))
    }
}

// MARK: - Space cell

extension JokesViewController {
    private func spaceCell(tableView: UITableView, indexPath: IndexPath, item: JokesModels.DisplayedItem) -> SpaceCell {
        guard let model = item.model as? SpaceCell.Model else {
            return SpaceCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SpaceCell.defaultReuseIdentifier, for: indexPath) as? SpaceCell ?? SpaceCell()
        cell.setModel(model)
        return cell
    }
}
