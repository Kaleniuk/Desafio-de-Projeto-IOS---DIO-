//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 13/06/23.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private var coin: CoinModel
    let structType: ErrorResponseCoin
    let inserErro: InsertError
    
    init(coin: CoinModel){
        self.coin = coin
        structType  = ErrorResponseCoin(status: ErrorCodeCoin(errorCode: nil, errorMsg: nil))
        inserErro = InsertError(dado: structType)
        getCoinImage()
    }
    
    private func getCoinImage(){
        guard let url = URL(string: coin.image)
        else { return }
        
        imageSubscription =  NetworkingManager.download(url: url,
                                                        structType: structType,
                                                        insertErro: inserErro)
            .tryMap({ data in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
    
    private  func handleCompletion(completion: Subscribers.Completion<Error>  ) {  //Subscribers.Completion<Error>
        switch completion {
        case .finished:
            break
        case .failure(let error):

            print(error.localizedDescription)
            
           break
        }
    }
}
