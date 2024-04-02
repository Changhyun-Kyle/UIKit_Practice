//
//  QuoteService.swift
//  Combine_MVVM
//
//  Created by 강창현 on 4/2/24.
//

import Foundation
import Combine

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

