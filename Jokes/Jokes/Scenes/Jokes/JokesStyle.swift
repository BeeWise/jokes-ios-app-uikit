//
//  JokesStyle.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-10.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

class JokesStyle {
    static let shared = JokesStyle()
    
    var navigationBarModel: NavigationBarModel
    var contentViewModel: ContentViewModel
    var tableViewModel: TableViewModel
    var jokeCellModel: JokeCellModel
    
    private init() {
        self.navigationBarModel = NavigationBarModel()
        self.contentViewModel = ContentViewModel()
        self.tableViewModel = TableViewModel()
        self.jokeCellModel = JokeCellModel()
    }
    
    struct ContentViewModel {
        func backgroundColor() -> UIColor { ApplicationStyle.colors.transparent() }
        func backgroundImage() -> UIImage { ApplicationStyle.images.wallBackgroundImage() }
    }
    
    struct NavigationBarModel {
        func titleViewImage() -> UIImage { ApplicationStyle.images.neonLogoMediumImage() }
    }
    
    struct TableViewModel {
        func backgroundColor() -> UIColor { ApplicationStyle.colors.white() }
        
        func footerSectionFooterActivityColor() -> UIColor { ApplicationStyle.colors.primary() }
        func footerSectionFooterHeight() -> CGFloat { 40 }
        
        func noMoreItemsAttributes() -> [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.gray(),
                NSAttributedString.Key.font: ApplicationStyle.fonts.regular(size: 13),
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        }
        
        func errorTextAttributes() -> [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.secondary(),
                NSAttributedString.Key.font: ApplicationStyle.fonts.regular(size: 13),
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        }
    }
    
    struct JokeCellModel {
        func avatarBorderRadius() -> CGFloat { ApplicationConstraints.constant.x20.rawValue }
        func avatarActivityColor() -> UIColor { ApplicationStyle.colors.primary() }
        func avatarBackgroundColor() -> UIColor { ApplicationStyle.colors.transparent() }
        func avatarBorderColor() -> UIColor { ApplicationStyle.colors.white().withAlphaComponent(0.5) }
        func avatarBorderWidth() -> CGFloat { ApplicationConstraints.constant.x1.rawValue }
        
        func avatarPlaceholder() -> UIImage { return ApplicationStyle.images.userAvatarPlaceholderSmallImage() }
        
        func borderWidth() -> CGFloat { ApplicationConstraints.constant.x1.rawValue }
        func cornerRadius() -> CGFloat { ApplicationConstraints.constant.x16.rawValue }
        func borderColor() -> UIColor { ApplicationStyle.colors.lightGray() }
        
        func nameTextAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.primary(),
                NSAttributedString.Key.font: ApplicationStyle.fonts.bold(size: 17),
            ]
        }
        
        func usernameTextAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.gray(),
                NSAttributedString.Key.font: ApplicationStyle.fonts.regular(size: 14),
            ]
        }
        
        func jokeTextAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.primary(),
                NSAttributedString.Key.font: ApplicationStyle.fonts.regular(size: 17),
            ]
        }
        
        func answerTextAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.primary(),
                NSAttributedString.Key.font: ApplicationStyle.fonts.regular(size: 17),
            ]
        }
        
        func timeTextAttributes() -> [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .right
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.gray(),
                NSAttributedString.Key.font: ApplicationStyle.fonts.oblique(size: 13),
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        }
        
        func likeCountActivityColor() -> UIColor {  ApplicationStyle.colors.gray() }
        func likeCountBorderColor() -> UIColor {  ApplicationStyle.colors.transparent() }
        func likeCountImage() -> UIImage {  ApplicationStyle.images.likeSmallImage() }
        func unselectedLikeCountBackgroundColor() -> UIColor { ApplicationStyle.colors.transparent() }
        func unselectedLikeCountTintColor() -> UIColor { ApplicationStyle.colors.gray() }
        func unselectedLikeCountAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.gray(),
                NSAttributedString.Key.font: ApplicationStyle.fonts.regular(size: 16),
            ]
        }
        
        func dislikeCountActivityColor() -> UIColor {  ApplicationStyle.colors.primary() }
        func dislikeCountBorderColor() -> UIColor {  ApplicationStyle.colors.transparent() }
        func dislikeCountImage() -> UIImage {  ApplicationStyle.images.dislikeSmallImage() }
        func unselectedDislikeCountBackgroundColor() -> UIColor { ApplicationStyle.colors.transparent() }
        func unselectedDislikeCountTintColor() -> UIColor { ApplicationStyle.colors.gray() }
        func unselectedDislikeCountTintAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.gray(),
                NSAttributedString.Key.font: ApplicationStyle.fonts.regular(size: 16),
            ]
        }
        
        func answerImage() -> UIImage {  ApplicationStyle.images.answerSmallImage() }
        func answerBackgroundImage() -> UIImage {  ApplicationStyle.images.buttonBackgroundImage() }
        func answerBackgroundColor() -> UIColor {  ApplicationStyle.colors.primary() }
        func answerBorderWidth() -> CGFloat { ApplicationConstraints.constant.x1.rawValue }
        func answerCornerRadius() -> CGFloat { ApplicationConstraints.constant.x16.rawValue }
        func answerBorderColor() -> UIColor { ApplicationStyle.colors.white() }
        
        func answerButtonAttributes() -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.foregroundColor: ApplicationStyle.colors.white(),
                NSAttributedString.Key.font: ApplicationStyle.fonts.regular(size: 17),
            ]
        }
    }
}
