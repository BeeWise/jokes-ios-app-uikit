//
//  JokesModels.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

enum JokesModels {
    class PaginationModel {
        var isFetchingItems: Bool = false
        var noMoreItems: Bool = false
        var hasError: Bool = false
        var currentPage: Int = 0
        var limit: Int = 10
        var items: [Joke] = []
        var readJokes: [Joke] = []
        
        func reset() {
            self.isFetchingItems = false
            self.noMoreItems = false
            self.hasError = false
            self.currentPage = 0
            self.limit = 10
            self.items = []
            self.readJokes = []
        }
    }
    
    class Section {
        var items: [DisplayedItem] = []
        var readJokes: [DisplayedItem] = []
        var isLoading: Bool = false
        var hasError: Bool = false
        var errorText: NSAttributedString?
        var noMoreItems: Bool = false
        var noMoreItemsText: NSAttributedString?
    }
    
    enum SectionIndex: Int {
        case items = 0
        case footer = 1
    }
    
    enum ItemType {
        case text
        case qna
        case space
    }
    
    struct DisplayedItem: Identifiable {
        internal let id: String = UUID().uuidString
        
        let type: ItemType
        let model: Any
    }
    
    struct ItemsPresentation {
        struct Response {
            let items: [Joke]
            let readJokes: [Joke]
        }
        
        struct ViewModel {
            let displayedItems: [DisplayedItem]
        }
    }
    
    class ItemSelection {
        struct Request {
            let id: String?
        }
     }
    
    class ItemReadState {
        struct Response {
            var isRead: Bool
            var id: String?
        }

        struct ViewModel {
            var isRead: Bool
            var id: String?
        }
    }
    
    enum NoMoreItemsPresentation {
        struct ViewModel {
            let text: NSAttributedString?
        }
    }
    
    enum ErrorPresentation {
        struct Response {
            let error: OperationError?
        }
        
        struct ViewModel {
            let text: NSAttributedString?
        }
    }
    
    struct UserAvatarFetching {
        struct Request {
            let model: UserAvatarView.Model
        }
        
        struct Response {
            let model: UserAvatarView.Model
        }
        
        struct ViewModel {
            let model: UserAvatarView.Model
        }
    }
    
    struct UserAvatarImagePresentation {
        struct Response {
            let model: UserAvatarView.Model
            let image: UIImage?
        }
        
        struct ViewModel {
            let model: UserAvatarView.Model
            let image: UIImage?
            let contentMode: UIView.ContentMode
        }
    }
}
