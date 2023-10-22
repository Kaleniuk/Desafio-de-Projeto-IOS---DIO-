//
//  SearchBarView4.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 01/07/23.
//

import SwiftUI

struct SearchBarView4: View {
    
    @State var searchText: String
    
    var body: some View {
        
        HStack {
            Image(systemName: "xbox.logo")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondarytext: Color.theme.accent)
            
            TextField("Search by name or symbol", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay (
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0: 1.0)
                        .onTapGesture {
                            searchText  = ""
                        }, alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.theme.background)
            .shadow(color: Color.theme.accent.opacity(0.15), radius: 15.0, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView4_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView4(searchText: "")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            SearchBarView4(searchText: "")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
       
        
    }
}
