//
//  FullImage.swift
//  NONTON ID
//
//  Created by Garry on 26/07/22.
//

import SwiftUI
import Zoomable

struct FullImage: View {
    @Environment(\.presentationMode) var presentationMode
    var url: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ZoomableImageView(
                url: URL(string: url)!,
                min: 1.0, max: 3.0,
                showsIndicators: false
            ) {
                Text("")
            }
            
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
