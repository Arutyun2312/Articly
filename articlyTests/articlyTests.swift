//
//  articlyTests.swift
//  articlyTests
//
//  Created by Arutyun Enfendzhyan on 20.01.23.
//

@testable import articly
import XCTest

@MainActor
final class articlyTests: XCTestCase {
    func testDateOnlyStrategy() throws {
        let list: [DateComponents] = [
            .init(year: 2018, month: 6, day: 25),
            .init(year: 2020, month: 12, day: 25),
            .init(year: 1980, month: 1, day: 1)
        ]
        for comps in list {
            let date = try DateOnlyStrategy.decode("\(comps.month!)/\(comps.day!)/\(comps.year!)")
            XCTAssertEqual(Calendar.current.dateComponents([.year, .month, .day], from: date), comps)
        }
    }
    
    func testDateOnlyStrategyError() {
        let string = "6/12"
        XCTAssertThrowsError(try DateOnlyStrategy.decode(string)) {
            XCTAssert(($0 as? DateOnlyStrategy.Errors).map { $0 == DateOnlyStrategy.Errors.invalidDateFormat(string) } == true)
        }
    }

    func testAsyncRetry() async throws {
        for (count, delay) in [(5, 1.0), (3, 1.5)] {
            var timestamps: [Date] = []
            try? await AsyncTask.retrying(count: count, retryDelay: delay) { @MainActor in
                timestamps.append(.init())
                throw NSError(domain: "Test", code: 0)
            }
            XCTAssertEqual(timestamps.count, count)
            XCTAssertEqual(timestamps[0].distance(to: timestamps.last!), (Double(count) - 1) * delay, accuracy: 0.5)
        }
    }
    
    let articles = [Article(id: 1, title: "title", description: "desc", author: "aith", image: .init(string: "google.com")!, releaseDate: try! DateOnlyStrategy.decode("6/25/2017"))]
    let articles2 = [Article(id: 2, title: "title1", description: "desc1", author: "aith1", image: .init(string: "google.com")!, releaseDate: try! DateOnlyStrategy.decode("6/25/2017"))]

    func testArticleStorage() throws {
        ArticleStorage.shared.articles = articles

        XCTAssertEqual(ArticleStorage.shared.articles!, articles)
    }
    
    func testArticleListViewModelGotData() async throws {
        API.config.getArticles = { try JSONEncoder().encode(self.articles) }
        let model = ArticleListViewModel()
        model.articles = nil
        await model.load()
        XCTAssertEqual(model.articles, articles)
        XCTAssertFalse(model.hasError)
        XCTAssertFalse(model.isLoading)
    }
    
    func testArticleListViewModelGotError() async throws {
        API.config.getArticles = { throw NSError() }
        let model = ArticleListViewModel()
        model.articles = nil
        await model.load()
        XCTAssertTrue(model.hasError)
        XCTAssertFalse(model.isLoading)
    }
    
    func testArticleListViewModelGotDataButHasData() async throws {
        API.config.getArticles = { try JSONEncoder().encode(self.articles2) }
        let model = ArticleListViewModel()
        model.articles = articles
        await model.load()
        XCTAssertEqual(model.articles, articles2)
        XCTAssertFalse(model.hasError)
        XCTAssertFalse(model.isLoading)
    }
    
    func testArticleListViewModelGotDataButHasError() async throws {
        API.config.getArticles = { try JSONEncoder().encode(self.articles2) }
        let model = ArticleListViewModel()
        await model.load()
        XCTAssertEqual(model.articles, articles2)
        XCTAssertFalse(model.hasError)
        XCTAssertFalse(model.isLoading)
    }
    
    func testArticleListViewModelGotErrorButHasData() async throws {
        API.config.getArticles = { throw NSError() }
        let model = ArticleListViewModel()
        model.articles = articles
        await model.load()
        XCTAssertEqual(model.articles, articles)
        XCTAssertTrue(model.hasError)
        XCTAssertFalse(model.isLoading)
    }
}
