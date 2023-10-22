//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 27/06/23.
//

import Foundation

struct StatisticModel: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageCchange: Double?
    
    init(title: String, value: String, percentageCchange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageCchange = percentageCchange
    }
}
