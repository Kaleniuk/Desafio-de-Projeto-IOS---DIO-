//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 25/06/23.
//

import SwiftUI

struct SearchBarView2: View {
    @State var searchtext: String
    
    var body: some View {
        HStack(){
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchtext.isEmpty ? Color.theme.secondarytext:
                                    Color.theme.accent)
            
            TextField("Search by name or symbol", text: $searchtext)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(
                            Image(systemName: "xmark.circle.fill")
                                .padding()
                                .offset(x: 10)
                                .foregroundColor(Color.theme.accent)
                                .opacity(searchtext.isEmpty ? 0.0: 1.0)
                                .onTapGesture {
                                    searchtext = ""
                                    //recolhe o teclado
                                }, alignment: .trailing
                )
            }
        .font(.headline)
        .padding()
        .background(RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.theme.background)
            .shadow(color: Color.theme.accent.opacity(0.15), radius: 10.0, x: 0.0, y: 0.0)
        )
        .padding()
       
    }
}
struct SearchBarView2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            SearchBarView2(searchtext: "")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
            
            SearchBarView2(searchtext: "")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
     
    }
}
