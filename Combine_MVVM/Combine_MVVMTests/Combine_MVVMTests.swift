//
//  Combine_MVVMTests.swift
//  Combine_MVVMTests
//
//  Created by 강창현 on 4/2/24.
//

import XCTest
import Combine
@testable import Combine_MVVM

final class Combine_MVVMTests: XCTestCase {
    
    var sut: QuoteViewModel!
    var quoteService: MockQuoteServiceType!
    private let input: PassthroughSubject<QuoteViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        quoteService = MockQuoteServiceType()
        sut = QuoteViewModel(quoteServiceType: quoteService)
    }

    override func tearDown() {
        
    }
    
    func test_a() {
        let output = sut.transform(input: input.eraseToAnyPublisher())
        output.sink { event in
            switch event {
            case .fetchQuoteDidFail(let error):
                XCTAssertThrowsError(error)
            case .fetchQuoteDidSucceed(let quote):
                XCTAssertNotNil(quote)
            case .toggleButton(let isEnable):
                XCTAssertTrue(isEnable)
            }
        }.store(in: &cancellables)
    }
}

final class MockQuoteServiceType: QuoteServiceType {
    var value: AnyPublisher<Quote,Error>?
    func getRandomQuote() -> AnyPublisher<Combine_MVVM.Quote, any Error> {
        return value ?? Empty().eraseToAnyPublisher()
    }
}
