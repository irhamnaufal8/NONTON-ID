//
//  MainView.swift
//  NONTON ID
//
//  Created by Garry on 16/07/22.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.primaryBackground)
        UINavigationBar.appearance().backgroundColor = UIColor(Color.primaryBackground)
        UINavigationBar.appearance().barTintColor = UIColor(Color.primaryBackground)
    }
    
    @ObservedObject var viewModel = HomeViewModel()
    @State public var tabSelection = 1

    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text(LocalizableText.home.localized(viewModel.language))
                    }
                    .tag(1)
                
                YourListView(tabSelection: $tabSelection)
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                        Text(LocalizableText.yourList.localized(viewModel.language))
                    }
                    .tag(2)
                
                ProfileView(tabSelection: $tabSelection)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text(LocalizableText.profile.localized(viewModel.language))
                    }
                    .tag(3)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .statusBar(hidden: false)
        .accentColor(.primaryText)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
