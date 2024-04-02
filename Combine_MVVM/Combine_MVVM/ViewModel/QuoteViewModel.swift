//
//  QuoteViewModel.swift
//  Combine_MVVM
//
//  Created by 강창현 on 4/2/24.
//

import Combine

final class QuoteViewModel {
    
    enum Input {
        case viewDidAppear
        case refreshButtonDidTap
    }
    
    enum Output {
        case fetchQuoteDidFail(error: Error)
        case fetchQuoteDidSucceed(quote: Quote)
        case toggleButton(isEnable: Bool)
    }
    
    private let quoteServiceType: QuoteServiceType
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    init(quoteServiceType: QuoteServiceType = QuoteService()) {
        self.quoteServiceType = quoteServiceType
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>  {
        input.sink { [weak self] event in
            switch event {
            case .viewDidAppear, .refreshButtonDidTap:
                self?.handleGetRandomQuote()
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    private func handleGetRandomQuote() {
        output.send(.toggleButton(isEnable: false))
        quoteServiceType.getRandomQuote().sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.output.send(.toggleButton(isEnable: true))
            case .failure(let error):
                self?.output.send(.fetchQuoteDidFail(error: error))
            }
        } receiveValue: { [weak self] quote in
            self?.output.send(.fetchQuoteDidSucceed(quote: quote))
        }.store(in: &cancellables)
    }
}
