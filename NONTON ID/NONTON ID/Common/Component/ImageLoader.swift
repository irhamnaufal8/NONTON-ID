//
//  ImageLoader.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.
//

import SwiftUI

struct ImageLoader: View {
    var url: String
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        AsyncImage(
            url: URL(string: url),
            content: { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Rectangle()
                            .foregroundColor(.loadingImage)
                            .frame(width: width, height: height)
                        
                        ProgressView()
                    }
                case .failure:
                    ZStack {
                        Rectangle()
                            .foregroundColor(.loadingImage)
                            .frame(width: width, height: height)
                        
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                @unknown default:
                    ZStack {
                        Rectangle()
                            .foregroundColor(.loadingImage)
                            .frame(width: width, height: height)
                        
                        ProgressView()
                    }
                }
            }
        )
    }
}

struct ImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoader(url: "https://image.tmdb.org/t/p/w500/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg")
    }
}
