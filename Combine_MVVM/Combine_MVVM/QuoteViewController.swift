//
//  QuoteViewController.swift
//  Combine_MVVM
//
//  Created by 강창현 on 4/2/24.
//

import UIKit
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

final class QuoteViewController: UIViewController {
    
    @IBOutlet private weak var quoteLabel: UILabel!
    @IBOutlet private weak var refreshButton: UIButton!
    
    private let viewModel = QuoteViewModel()
    private let input: PassthroughSubject<QuoteViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        input.send(.viewDidAppear)
    }
    
    private func bind() {
        let output = viewModel.transform(
            input: input.eraseToAnyPublisher()
        )
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
            switch event {
            case .fetchQuoteDidFail(let error):
                self?.quoteLabel.text = error.localizedDescription
            case .fetchQuoteDidSucceed(let quote):
                self?.quoteLabel.text = quote.content
            case .toggleButton(let isEnable):
                self?.refreshButton.isEnabled = isEnable
            }
        }
        .store(in: &cancellables)
    }
    
    @IBAction private func refreshButtonTapped(_ sender: UIButton) {
        input.send(.refreshButtonDidTap)
    }
    
}

protocol QuoteServiceType {
    func getRandomQuote() -> AnyPublisher<Quote, Error>
}

final class QuoteService: QuoteServiceType {
    
    func getRandomQuote() -> AnyPublisher<Quote, Error> {
        guard 
            let url = URL(string: "https://api.quotable.io/random")
        else {
            return Empty().eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }.map { $0.data }
            .decode(type: Quote.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct Quote: Decodable {
    let content: String
    let author: String
}
