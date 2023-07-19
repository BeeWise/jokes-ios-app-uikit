//
//  JokesViewControllerTests.swift
//  Jokes
//
//  Created by Bee Wise on 2023-07-18.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

@testable import Jokes
import XCTest

class JokesViewControllerTests: XCTestCase {
    var sut: JokesViewController!
    var interactorSpy: JokesBusinessLogicSpy!
    var routerSpy: JokesRoutingLogicSpy!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        self.setupJokesViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupJokesViewController() {
        self.sut = JokesViewController()
        
        self.interactorSpy = JokesBusinessLogicSpy()
        self.sut.interactor = self.interactorSpy
        
        self.routerSpy = JokesRoutingLogicSpy()
        self.sut.router = self.routerSpy
    }
    
    func loadView() {
        self.window.addSubview(self.sut.view)
        RunLoop.current.run(until: Date())
    }
    
    private func waitForMainQueue() {
        let waitExpectation = expectation(description: "Waiting for main queue.")
        DispatchQueue.main.async {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
        
    func setupSections() {
        self.sut.sections = [JokesModels.Section(), JokesModels.Section()]
    }
    
    // MARK: - Business logic tests
    
    func testAddSubviewsWhenViewDidLoad() {
        self.loadView()
        XCTAssertNotNil(self.sut.navigationItem.titleView)
        XCTAssertNotNil(self.sut.backgroundImageView)
        XCTAssertNotNil(self.sut.tableView)
    }
    
    // MARK: - Table view tests

    func testIfViewControllerConformsToUITableViewDataSourceProtocol() {
        self.loadView()
        XCTAssertTrue(self.sut.conforms(to: UITableViewDataSource.self))
    }

    func testIfViewControllerHasSetUITableViewDataSource() {
        self.loadView()
        XCTAssertNotNil(self.sut.tableView.dataSource)
    }

    func testIfViewControllerConformsToTableViewDelegate() {
        XCTAssertTrue(self.sut.conforms(to: UITableViewDelegate.self))
    }

    func testNumberOfRowsInAnySectionShouldEqualItemCount() {
        self.loadView()
        let items = [self.textDisplayedItem()]
        let section = JokesModels.Section()
        section.items = items
        let sections = [section]
        self.sut.sections = sections
        let numberOfRows = self.sut.tableView(self.sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, self.sut.sections.first?.items.count)
    }

    func testNumberOfSectionsInTableView() {
        self.loadView()
        let items = [self.textDisplayedItem()]
        let section = JokesModels.Section()
        section.items = items
        let sections = [section]
        self.sut.sections = sections

        let tableView = self.sut.tableView
        let numberOfSections = self.sut.numberOfSections(in: tableView!)
        XCTAssertEqual(numberOfSections, sections.count)
    }

    func testCellForRowShouldReturnCorrectCell() {
        self.loadView()
        let items = [self.textDisplayedItem(), self.spaceDisplayedItem(), self.qnaDisplayedItem()]
        let section = JokesModels.Section()
        section.items = items
        let sections = [section]
        self.sut.sections = sections

        let tableView = self.sut.tableView
        let textCell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: 0, section: 0))
        let spaceCell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: 1, section: 0))
        let qnaCell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: 2, section: 0))

        XCTAssertTrue(textCell is JokeTextCell)
        XCTAssertTrue(spaceCell is SpaceCell)
        XCTAssertTrue(qnaCell is JokeQuestionAnswerCell)
    }
    
    func testShouldConfigureJokeTextCell() {
        self.loadView()

        let items = [self.textDisplayedItem()]
        let section = JokesModels.Section()
        section.items = items
        let sections = [section]
        self.sut.sections = sections

        let tableView = self.sut.tableView
        items.enumerated().forEach { index, item in
            let cell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: index, section: 0)) as? JokeTextCell
            let model = item.model as? JokeTextCell.Model

            XCTAssertEqual(cell?.nameLabel.attributedText, model?.name)
            XCTAssertEqual(cell?.usernameLabel.attributedText, model?.username)
            XCTAssertEqual(cell?.jokeTextLabel.attributedText, model?.text)
            XCTAssertEqual(cell?.timeLabel.attributedText, model?.time)
            XCTAssertEqual(cell?.likeCountView?.titleLabel?.attributedText, model?.likeCount?.title)
            XCTAssertEqual(cell?.dislikeCountView?.titleLabel?.attributedText, model?.dislikeCount?.title)
        }
    }
    
    func testShouldConfigureJokeQuestionAnswerCell() {
        self.loadView()

        let items = [self.qnaDisplayedItem()]
        let section = JokesModels.Section()
        section.items = items
        let sections = [section]
        self.sut.sections = sections

        let tableView = self.sut.tableView
        items.enumerated().forEach { index, item in
            let cell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: index, section: 0)) as? JokeQuestionAnswerCell
            let model = item.model as? JokeQuestionAnswerCell.Model
            
            XCTAssertNotNil(cell?.delegate)
            XCTAssertEqual(cell?.nameLabel.attributedText, model?.name)
            XCTAssertEqual(cell?.usernameLabel.attributedText, model?.username)
            XCTAssertEqual(cell?.jokeTextLabel.attributedText, model?.text)
            XCTAssertEqual(cell?.answerTextLabel.attributedText, model?.answer)
            XCTAssertEqual(cell?.timeLabel.attributedText, model?.time)
            XCTAssertEqual(cell?.likeCountView?.titleLabel?.attributedText, model?.likeCount?.title)
            XCTAssertEqual(cell?.dislikeCountView?.titleLabel?.attributedText, model?.dislikeCount?.title)
        }
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewLoadingHeaderFooterViewWhenTheFooterSectionIsLoading() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewLoadingHeaderFooterView)
    }

    func testTableViewViewForHeaderInSectionShouldReturnTableViewTitleHeaderFooterViewWhenTheFooterSectionIsNotLoadingAndHasNoErrorAndHasNoMoreItems() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = true
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewTitleHeaderFooterView)
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewErrorHeaderFooterViewWhenTheFooterSectionHasError() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = true
        self.sut.sections[section].noMoreItems = false
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewErrorHeaderFooterView)
    }

    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionIsLoading() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }

    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionIsNotLoadingAndHasNoErrorAndHasNoMoreItems() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = true
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionHasError() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = true
        self.sut.sections[section].noMoreItems = false
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }

    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionIsNotLoadingAndHasNoErrorAndHasMoreItems() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = false
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, CGFloat.leastNonzeroMagnitude)
    }

    func testTableViewViewForFooterInSectionShouldReturnView() {
        self.loadView()
        for (index, _) in self.sut.sections.enumerated() {
            XCTAssertNotNil(self.sut.tableView(self.sut.tableView, viewForFooterInSection: index))
        }
    }

    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForItemsSection() {
        self.loadView()
        let section = JokesModels.SectionIndex.items.rawValue
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: section)
        XCTAssertEqual(height, CGFloat.leastNonzeroMagnitude)
    }

    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForFooterSection() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: section)
        XCTAssertEqual(height, JokesStyle.shared.tableViewModel.footerSectionFooterHeight())
    }

    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForInvalidSection() {
        self.loadView()
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: 2)
        XCTAssertEqual(height, CGFloat.leastNonzeroMagnitude)
    }
    
    // MARK: - Display logic
    
    func testDisplayLoadingStateShouldUpdateFooterSectionIsLoading() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.displayLoadingState()
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].isLoading)
    }

    func testDisplayLoadingStateShouldAskTheTableViewToReloadSections() {
        self.loadView()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayLoadingState()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }

    func testDisplayNotLoadingStateShouldUpdateFooterSectionIsLoading() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        self.sut.displayNotLoadingState()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].isLoading)
    }

    func testDisplayNotLoadingStateShouldAskTheTableViewToReloadSections() {
        self.loadView()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayNotLoadingState()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }

    func testDisplayNoMoreItemsStateShouldUpdateFooterSectionNoMoreItems() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItems = false
        self.sut.displayNoMoreItems(viewModel: JokesModels.NoMoreItemsPresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].noMoreItems)
    }

    func testDisplayNoMoreItemsStateShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayNoMoreItems(viewModel: JokesModels.NoMoreItemsPresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }

    func testDisplayRemoveNoMoreItemsStateShouldUpdateFooterSectionNoMoreItems() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItems = true
        self.sut.displayRemoveNoMoreItems()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].noMoreItems)
    }

    func testDisplayRemoveNoMoreItemsStateShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayRemoveNoMoreItems()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayErrorStateShouldUpdateFooterSectionHasError() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].hasError = false
        self.sut.displayError(viewModel: JokesModels.ErrorPresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].hasError)
    }
    
    func testDisplayErrorStateShouldUpdateFooterSectionErrorText() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].errorText = nil
        let text = NSAttributedString(string: "Error", attributes: nil)
        self.sut.displayError(viewModel: JokesModels.ErrorPresentation.ViewModel(text: text))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.sections[section].errorText)
        XCTAssertEqual(self.sut.sections[section].errorText, text)
    }
    
    func testDisplayErrorStateShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayError(viewModel: JokesModels.ErrorPresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayRemoveErrorStateShouldUpdateFooterSectionHasError() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].hasError = true
        self.sut.displayRemoveError()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].hasError)
    }
    
    func testDisplayRemoveErrorStateShouldUpdateFooterSectionErrorText() {
        self.loadView()
        let section = JokesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].errorText = NSAttributedString(string: "Error", attributes: nil)
        self.sut.displayRemoveError()
        self.waitForMainQueue()
        XCTAssertNil(self.sut.sections[section].errorText)
    }

    func testDisplayRemoveErrorStateShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayRemoveError()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayItemsShouldUpdateDisplayedItemsModel() {
        self.loadView()
        let tableViewSpy = UITableViewSpy()
        tableViewSpy.dataSource = self.sut
        tableViewSpy.register(JokeTextCell.self, forCellReuseIdentifier: JokeTextCell.defaultReuseIdentifier)
        self.sut.tableView = tableViewSpy
        self.sut.sections[JokesModels.SectionIndex.items.rawValue].items = [self.textDisplayedItem()]
        let count = self.sut.sections[JokesModels.SectionIndex.items.rawValue].items.count
        let displayedJokes = [self.textDisplayedItem()]
        self.sut.displayItems(viewModel: JokesModels.ItemsPresentation.ViewModel(displayedItems: displayedJokes))
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.sections[JokesModels.SectionIndex.items.rawValue].items.count, count + displayedJokes.count)
    }

    func testDisplayItemsShouldAskTheTableViewToInsertRowsInBatchUpdates() {
        let tableViewSpy = UITableViewSpy()
        tableViewSpy.dataSource = self.sut
        tableViewSpy.register(JokeTextCell.self, forCellReuseIdentifier: JokeTextCell.defaultReuseIdentifier)
        self.sut.tableView = tableViewSpy
        let displayedJokes = [self.textDisplayedItem()]

        let section = JokesModels.Section()
        section.items =  displayedJokes
        let sections = [section]
        self.sut.sections = sections

        self.sut.displayItems(viewModel: JokesModels.ItemsPresentation.ViewModel(displayedItems: displayedJokes))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.insertRowsCalled)
    }
    
    func testDisplayUserAvatarLoadingStateShouldUpdateLoadingStateForUserAvatar() {
        self.sut.sections = [JokesModels.Section()]
        let cellInterfaceSpy = LoadingImageViewInterfaceSpy()
        
        let model = self.textCellModel()
        model.avatar.isLoading = false
        model.avatar.cellInterface = cellInterfaceSpy

        self.sut.displayUserAvatarLoadingState(viewModel: JokesModels.UserAvatarFetching.ViewModel(model: model.avatar))
        self.waitForMainQueue()
        XCTAssertTrue(model.avatar.isLoading)
        XCTAssertTrue(cellInterfaceSpy.setLoadingCalled)
    }
    
    func testDisplayUserAvatarNotLoadingStateShouldUpdateLoadingStateForUserAvatar() {
        self.sut.sections = [JokesModels.Section()]
        let cellInterfaceSpy = LoadingImageViewInterfaceSpy()
        
        let model = self.textCellModel()
        model.avatar.isLoading = true
        model.avatar.cellInterface = cellInterfaceSpy
        
        self.sut.displayUserAvatarNotLoadingState(viewModel: JokesModels.UserAvatarFetching.ViewModel(model: model.avatar))
        self.waitForMainQueue()
        XCTAssertFalse(model.avatar.isLoading)
        XCTAssertTrue(cellInterfaceSpy.setLoadingCalled)
    }
    
    func testDisplayUserAvatarImageShouldUpdateImageForUserAvatar() {
        self.sut.sections = [JokesModels.Section()]
        let cellInterfaceSpy = LoadingImageViewInterfaceSpy()
        
        let model = self.textCellModel()
        model.avatar.image = nil
        model.avatar.contentMode = .scaleAspectFill
        model.avatar.cellInterface = cellInterfaceSpy
        
        let image = UIImage()
        let contentMode = UIView.ContentMode.scaleAspectFill
        
        self.sut.displayUserAvatarImage(viewModel: JokesModels.UserAvatarImagePresentation.ViewModel(model: model.avatar, image: image, contentMode: contentMode))
        self.waitForMainQueue()
        XCTAssertEqual(model.avatar.image, image)
        XCTAssertEqual(model.avatar.contentMode, contentMode)
        XCTAssertTrue(cellInterfaceSpy.setImageCalled)
    }
    
    func testDisplayReadStateShouldAskTheTableViewToReloadRows() {
        let tableViewSpy = UITableViewSpy()
        tableViewSpy.dataSource = self.sut
        tableViewSpy.register(JokeTextCell.self, forCellReuseIdentifier: JokeTextCell.defaultReuseIdentifier)
        self.sut.tableView = tableViewSpy

        let model = self.qnaCellModel()
        model.isRead = false

        let displayedJokes = [JokesModels.DisplayedItem(type: .qna, model: model)]

        let section = JokesModels.Section()
        section.items =  displayedJokes
        let sections = [section]
        self.sut.sections = sections

        self.sut.displayReadState(viewModel: JokesModels.ItemReadState.ViewModel(isRead: true, id: model.id))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadRowsCalled)
    }
    
    func testShouldFetchItemsWhenScrollViewDidScroll() {
        let threshold: CGFloat = 100
        let contentSizeHeight: CGFloat = 400
        let frameSizeHeight: CGFloat = 100
        let scrollViewSpy = UIScrollViewSpy()
        scrollViewSpy.shouldDecelerate = true
        scrollViewSpy.contentSize.height = contentSizeHeight
        scrollViewSpy.frame.size.height = frameSizeHeight
        scrollViewSpy.contentOffset.y = contentSizeHeight - frameSizeHeight - threshold
        self.sut.scrollViewDidScroll(scrollViewSpy)
        XCTAssertTrue(self.interactorSpy.shouldFetchItemsCalled)
    }
    
    func testShouldFetchItemsWhenSelectingErrorTitleButtonFromSectionFooterView() {
        self.sut.tableViewErrorHeaderFooterView(view: nil, didSelectTitle: nil)
        XCTAssertTrue(self.interactorSpy.shouldFetchItemsCalled)
    }
    
    private func textDisplayedItem() -> JokesModels.DisplayedItem {
        return JokesModels.DisplayedItem(type: .text, model: self.textCellModel())
    }
    
    private func spaceDisplayedItem() -> JokesModels.DisplayedItem {
        return JokesModels.DisplayedItem(type: .space, model: self.spaceCellModel())
    }
    
    private func qnaDisplayedItem() -> JokesModels.DisplayedItem {
        return JokesModels.DisplayedItem(type: .qna, model: self.qnaCellModel())
    }
    
    private func textCellModel() -> JokeTextCell.Model {
        let model = JokeTextCell.Model(avatar: UserAvatarView.Model())
        model.name = NSAttributedString(string: "Name")
        model.username = NSAttributedString(string: "username")
        model.text = NSAttributedString(string: "text")
        model.likeCount = ImageTitleButton.Model()
        model.dislikeCount = ImageTitleButton.Model()
        model.time = NSAttributedString(string: "time")
        return model
    }
    
    private func spaceCellModel() -> SpaceCell.Model {
        return SpaceCell.Model(height: ApplicationConstraints.constant.x16.rawValue)
    }
    
    private func qnaCellModel() -> JokeQuestionAnswerCell.Model {
        let model = JokeQuestionAnswerCell.Model(avatar: UserAvatarView.Model())
        model.name = NSAttributedString(string: "Name")
        model.username = NSAttributedString(string: "username")
        model.text = NSAttributedString(string: "text")
        model.answer = NSAttributedString(string: "answer")
        model.likeCount = ImageTitleButton.Model()
        model.dislikeCount = ImageTitleButton.Model()
        model.time = NSAttributedString(string: "time")
        return model
    }
}
