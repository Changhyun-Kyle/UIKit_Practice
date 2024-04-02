//
//  QuoteViewController.swift
//  Combine_MVVM
//
//  Created by 강창현 on 4/2/24.
//

import UIKit
import Combine

final class QuoteViewModel {
    
}

final class QuoteViewController: UIViewController {
    @IBOutlet private weak var quoteLabel: UILabel!
    @IBOutlet private weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func refreshButtonTapped(_ sender: UIButton) {
        
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
