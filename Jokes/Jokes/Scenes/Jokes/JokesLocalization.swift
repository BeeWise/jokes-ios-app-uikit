//
//  JokesLocalization.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

class JokesLocalization {
    static let shared = JokesLocalization()
    
    private init() {
        
    }
    
    struct LocalizedKey {
        static let
            noMoreItemsText = "Jokes.scene.no.more.items.text",
            errorText = "Jokes.scene.error.text",
            readAnswerTitle = "Joke.read.answer.title"
    }
    
    func noMoreItemsText() -> String { LocalizedKey.noMoreItemsText.localized() }
    func errorText() -> String { LocalizedKey.errorText.localized() }
    func readAnswerTitle() -> String { LocalizedKey.readAnswerTitle.localized() }
}
