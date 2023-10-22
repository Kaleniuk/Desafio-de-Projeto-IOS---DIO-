//
//  ErrorResponseCoin.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 15/06/23.
//

import Foundation

struct ErrorResponseCoin: Codable {
    
    let status: ErrorCodeCoin?
    
    enum Codingkeys: String, CodingKey {
        
        case status
    }
}

struct ErrorCodeCoin: Codable {
    
    let error_code: Int?
    let error_message: String?
    
    enum Codingkeys: String, CodingKey {
        
        case errorCode = "error_code"
        case errorMsg  = "error_message"
    }
}


enum AppError: Error, LocalizedError {
    case apiError(String)
    
    var errorDescription: String? {
        switch self {
        case .apiError(let message):
            return message
        }
    }
}

enum AppError2<T>: Error, LocalizedError {
    case apiError(T)
    
}
enum MyError: Error {
    case decodingFailed
}
