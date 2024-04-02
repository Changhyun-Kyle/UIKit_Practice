//
//  QuoteServiceType.swift
//  Combine_MVVM
//
//  Created by 강창현 on 4/2/24.
//

import Combine

protocol QuoteServiceType {
    func getRandomQuote() -> AnyPublisher<Quote, Error>
}
