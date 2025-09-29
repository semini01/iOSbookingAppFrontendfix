//
//  SearchBar.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-17.
//

import SwiftUI

struct SearchBar: View {
    
    var placeholder: String
    @Binding var text: String
    var onSearch: (() -> Void)? = nil   

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(placeholder, text: $text, onCommit: {
                onSearch?()
            })
            .textFieldStyle(PlainTextFieldStyle())
            .autocapitalization(.none)
            .disableAutocorrection(true)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                    onSearch?()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray5))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

#Preview {
    SearchBar(
        placeholder: "Search hotels, cities...",
        text: .constant(""),
        onSearch: { print("Search triggered!") }
    )
}
