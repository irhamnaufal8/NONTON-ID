//
//  ScreenWidthEnvironmentKey.swift
//  NONTON ID
//
//  Created by Irham Naufal on 13/03/24.
//

import SwiftUI

enum ScreenWidth {
    case small
    case medium
    case large
}

struct ScreenWidthEnvironmentKey: EnvironmentKey {
    static let defaultValue: ScreenWidth = .small
}

extension EnvironmentValues {
    var screenWidth: ScreenWidth {
        get { self[ScreenWidthEnvironmentKey.self] }
        set { self[ScreenWidthEnvironmentKey.self] = newValue }
    }
}

struct ScreenWidthModifier: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .environment(\.screenWidth, self.screenWidthCategory(for: geometry.size.width))
        }
    }
    
    private func screenWidthCategory(for width: CGFloat) -> ScreenWidth {
        if width < 640 {
            return .small
        } else if width < 1026 {
            return .medium
        } else {
            return .large
        }
    }
}

extension View {
    func detectScreenWidth() -> some View {
        self.modifier(ScreenWidthModifier())
    }
}

struct SampleView: View {
    
    @Environment(\.screenWidth) var screenWidth
    
    var grid: [GridItem] {
        switch screenWidth {
        case .small:
            return [GridItem(.flexible())]
        case .medium:
            return [GridItem(.flexible()), GridItem(.flexible())]
        case .large:
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        }
    }
    
    var body: some View {
        switch screenWidth {
        case .small:
            VStack(spacing: 0) {
                mainContent
                navBar
            }
        case .large, .medium:
            HStack(spacing: 0) {
                navBar
                mainContent
            }
        }
    }
    
    @ViewBuilder
    var mainContent: some View {
        ScrollView {
            LazyVGrid(columns: grid, content: {
                ForEach(0...12, id: \.self) { _ in
                    Button {
                        
                    } label: {
                        cardView
                            .multilineTextAlignment(.leading)
                    }
                    .tint(.black)
                }
            })
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12)
        }
    }
    
    @ViewBuilder
    var cardView: some View {
        VStack(alignment: .leading) {
            Text("This is Header For any personal purposes")
                .font(.title2)
                .bold()
            
            Text("You can watch any other bla without  anything you want aaaa. Then you will know what does it mean. Okay?")
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
    
    @ViewBuilder
    var navBar: some View {
        Group {
            switch screenWidth {
            case .small:
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "house")
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "person")
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .shadow(color: .black.opacity(0.05), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            case .large, .medium:
                VStack(alignment: .leading, spacing: 12) {
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "house")
                                .frame(maxWidth: 30)
                            
                            Text("Home")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .frame(maxWidth: 30)
                            
                            Text("Search")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .frame(maxWidth: 30)
                            Text("Post")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "heart")
                                .frame(maxWidth: 30)
                            Text("Likes")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "person")
                                .frame(maxWidth: 30)
                            Text("Profile")
                        }
                    }
                }
                .padding()
                .padding(.trailing, 24)
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color.gray.opacity(0.1))
            }
        }
        .tint(.purple)
    }
}

struct ContentView: View {
    var body: some View {
        SampleView()
            .detectScreenWidth()
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
