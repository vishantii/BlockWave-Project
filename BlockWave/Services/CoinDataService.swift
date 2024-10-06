//
//  CoinDataService.swift
//  BlockWave
//
//  Created by Mohamad Farhan on 19/08/24.
//

import Foundation
import Combine

class CoinDataService {
    private var coinSubscription: AnyCancellable?
    @Published var allCoins: [CoinModel] = []

    init() {
        getAllCoins()
    }

    private func getAllCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }
        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.timeoutInterval = 10
//        request.allHTTPHeaderFields = [
//            "accept": "application/json",
//            "x-cg-pro-api-key": "CG-yLLVs7uyrzux6TdFuppLRAiw"
//        ]
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
