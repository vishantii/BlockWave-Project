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
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                print("Response status code: \(response.statusCode)")
                guard response.statusCode >= 200 && response.statusCode < 300 else {
                    if let data = String(data: output.data, encoding: .utf8) {
                        print("Server error response: \(data)")
                    }
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
    }
}
