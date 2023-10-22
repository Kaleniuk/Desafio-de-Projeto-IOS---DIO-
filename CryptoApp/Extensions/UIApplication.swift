//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 15/06/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func addEditing() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
