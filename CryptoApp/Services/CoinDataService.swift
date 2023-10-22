//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 05/06/23.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    @Published var msgFailure: String? = nil
    let structType: ErrorResponseCoin
    let insertErro: InsertError
    var coinSubscription: AnyCancellable?
    
    init() {
        structType  = ErrorResponseCoin(status: ErrorCodeCoin(error_code: nil, error_message: nil))
        insertErro = InsertError(dado: structType)
        getCoins()
    }
    
    
    private func getCoins() {
  
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en")
        else { return }
        
        coinSubscription =  NetworkingManager.download(url: url,
                                                       structType: structType,
                                                       insertErro: insertErro)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })           
    }
    
    private func handleCompletion(completion: Subscribers.Completion<Error>  ) {  //Subscribers.Completion<Error>
        switch completion {
        case .finished:
            break
        case .failure(let error):
            
            print(error.localizedDescription)
            msgFailure = error.localizedDescription
            break
        }
    }
}

struct InsertError: Error {
    let dado: ErrorResponseCoin?
    
   func getType ()-> Error {
       return AppError.apiError((dado?.status?.error_message ?? "") + " \(dado!.status!.error_code!)" )
   }
}
