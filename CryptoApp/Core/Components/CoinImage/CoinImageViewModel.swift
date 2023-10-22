//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 13/06/23.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image:     UIImage? = nil
    @Published var isLoading: Bool     = false
    private var cancellables = Set<AnyCancellable>()
    private let coin: CoinModel
    private let dataService: CoinImageService
    
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.isLoading = true
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        dataService.$image.sink { [weak self] _ in
            self?.isLoading = false
        } receiveValue: { [weak self] returnedImage in
            self?.image = returnedImage
        }.store(in: &cancellables)
    }
    
}
