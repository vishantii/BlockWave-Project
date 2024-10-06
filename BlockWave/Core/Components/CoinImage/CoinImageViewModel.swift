//
//  CoinImageViewModel.swift
//  BlockWave
//
//  Created by Mohamad Farhan on 22/09/24.
//

import Foundation
import SwiftUI
import Combine


class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let dataServices: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.dataServices = CoinImageService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        dataServices.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
    
}
