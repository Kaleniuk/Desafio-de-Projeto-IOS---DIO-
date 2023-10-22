//
//  SearchBarView3.swift
//  CryptoApp
//
//  Created by Orest Kaleniuk Filho on 25/06/23.
//

import SwiftUI

struct SearchBarView3: View {
    
    @State var searchText: String
    
    var body: some View {
        
        HStack{
            Image(systemName: "xbox.logo")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondarytext: Color.theme.accent)
            
            TextField("Search by text or symbol", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay (
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.theme.accent)
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0.0: 1.0)
                        .onTapGesture {
                            searchText = ""
                            //TODO recolher o teclado
                        }, alignment: .trailing
                )
            
        }
        .font(.headline)
        .padding()
        .background(RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.theme.background)
            .shadow(color: Color.theme.accent.opacity(0.15), radius: 15, x: 0.0, y: 0.0)
        )
        .padding()
    }
}

struct SearchBarView3_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            SearchBarView3(searchText: "")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            SearchBarView3(searchText: "")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
        }
   
    }
}

