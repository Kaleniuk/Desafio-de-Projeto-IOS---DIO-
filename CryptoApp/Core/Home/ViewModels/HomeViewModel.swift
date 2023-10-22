//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 05/06/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value", percentageCchange: 1),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value", percentageCchange: -2),
        ]
    @Published var allCoins: [CoinModel] = []
    @Published var portifolioCoins: [CoinModel] = []
    @Published var searchText:  String = ""
    @Published var uiStateHomeView: UIStateHomeView = .none
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    private var cancellablesFailure = Set<AnyCancellable>()
    
    init() {
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.allCoins.append(DeveloperPreview.instance.coin)
//            self.portifolioCoins.append(DeveloperPreview.instance.coin)
//        }
        
        addSubscribers()
    }
    
    func addSubscribers() {
        
        dataService.$msgFailure
            .sink(receiveValue: { [weak self] msgError in
                guard let self = self , let msg = msgError else {
                    return
                }
                self.uiStateHomeView = UIStateHomeView.error(msg)
            })
            .store(in: &cancellablesFailure)
        
       $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
}
