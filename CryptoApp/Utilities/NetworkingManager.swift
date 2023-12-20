//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 11/06/23.
//

import Foundation
import Combine

class NetworkingManager {
   
    enum DataError: Error {
        case decodingError(String)
    }
     
 
    enum NetworkError {
        case badrequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum NetworkingError: LocalizedError {
        case badURLResponse
        case unknown
        
        var errorDescription: String? {
            switch self{
            case .badURLResponse: return "[🔥] Bad response from URL"
            case .unknown: return "[⚠️] Unknown error occured"
                
            }
        }
        
    }
    
    static func download(url: URL,
                         structType: ErrorResponseCoin,
                         insertErro: InsertError) -> AnyPublisher<Data,Error>  {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ output in  try  handleURLResponse(output: output,
                                                        structType: structType,
                                                        insertErro: insertErro) })  //handleURLResponse(output: $0)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output,
                                  structType: ErrorResponseCoin,
                                  insertErro: InsertError) throws -> Data {
        
        
        guard let response = output.response as? HTTPURLResponse
        else { throw NetworkingError.badURLResponse }
    
        if response.statusCode == 429 {
            let dados = output.data
            let decoder = JSONDecoder()
            print(String(data: dados, encoding: .utf8)!)
            let objectType = type(of: structType)
            guard let decodedResponse = try? decoder.decode(ErrorResponseCoin.self, from: dados)
            else {
                print("Erro decoder")
                throw MyError.decodingFailed
            }
            print(decodedResponse.status?.errorMsg ?? "Error de decoder" )
            let insertErroStruct = type(of: insertErro)
            throw insertErroStruct.init(dado: decodedResponse).getType()
        }
        
        if  (response.statusCode >= 200 && response.statusCode < 300) {
            return output.data
        }
        
        throw NetworkingError.unknown
    }
    
}


