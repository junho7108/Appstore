//
//  SearchHomeViewModelTest.swift
//  AppstoreTests
//
//  Created by Junho Yoon on 9/23/24.
//

import XCTest
import RxSwift
import RxRelay
import RxTest
@testable import Appstore


final class SearchHomeViewModelTest: XCTestCase {
    
    var scheduler: TestScheduler!
    var viewModel: SearchHomeViewModel!
    
    var disposeBag = DisposeBag()
    override func setUpWithError() throws {
        super.setUp()
        
        let repository = SearchRepositoryTest()
        let usecase = SearchUsecase(repository: repository)
        
        self.scheduler = TestScheduler(initialClock: 0)
        self.viewModel = SearchHomeViewModel(usecase: usecase)
        
      
    }

    override func tearDownWithError() throws {
      
        viewModel = nil
    }
    
    func testGetSearchResult() {
        let observer = scheduler.createObserver([SearchResult].self)
        
        self.viewModel.output.searchResults
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler
            .createColdObservable([
                .next(2, ())
            ])
            .map { RelatedSearchKeyword(keyword: "Test1") }
            .bind(to: self.viewModel.input.searchKeyword)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
      
        let expected = [SearchResult.testObject(trackName: "Test1")]
        XCTAssertEqual(observer.events, [.next(0, []), .next(2, expected)])
        
//        let expected2 = [SearchResult.testObject(trackName: "Test2")]
//        XCTAssertEqual(observer.events, [.next(0, []), .next(2, expected2)])
    }
    
    func testGetRecentKeywords() {
        let observer = scheduler.createObserver([RecentSearchKeyword].self)
        
        self.viewModel.output.recentKeywords.asDriver()
            .drive(observer)
            .disposed(by: disposeBag)
        
        scheduler
            .createColdObservable([
                .next(2, ())
            ])
            .bind(to: self.viewModel.input.fetchData)
            .disposed(by: self.disposeBag)
        
        scheduler.start()
        
        let expected = [RecentSearchKeyword(keyword: "테스트1"),
                        RecentSearchKeyword(keyword: "테스트2")]
        

        XCTAssertEqual(observer.events, [.next(0, []), .next(2, expected)])
        
//        let expected2 = [RecentSearchKeyword(keyword: "1"),
//                         RecentSearchKeyword(keyword: "2")]
//
//        XCTAssertEqual(observer.events, [.next(0, []), .next(2, expected2)])
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
