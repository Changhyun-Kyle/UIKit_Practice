//
//  QuoteViewController.swift
//  Combine_MVVM
//
//  Created by 강창현 on 4/2/24.
//

import UIKit
import Combine

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
