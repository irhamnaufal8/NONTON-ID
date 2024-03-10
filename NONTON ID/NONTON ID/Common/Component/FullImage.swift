//
//  FullImage.swift
//  NONTON ID
//
//  Created by Garry on 26/07/22.
//

import SwiftUI

struct FullImage: View {
    @Environment(\.presentationMode) var presentationMode
    var url: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ImageLoader(url: url)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.primaryText)
                    .font(.headline)
                    .padding()
            }
        }
    }
}
