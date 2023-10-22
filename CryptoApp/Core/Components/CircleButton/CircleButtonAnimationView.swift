//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 02/06/23.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding  var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0: 0.0)
            .opacity(animate ? 0.0: 1.0)
            .animation(animate ? Animation.easeInOut(duration: 1.0): nil, value: UUID())
//            .onAppear {
//                animate.toggle()
//            }
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonAnimationView(animate: .constant(false))
                .foregroundColor(.red)
                .frame(width: 100, height: 100)
            CircleButtonAnimationView(animate: .constant(false))
                .preferredColorScheme(.dark)
               
        }
        
        
    }
}
