//
//  NONTON_IDApp.swift
//  NONTON ID
//
//  Created by Garry on 16/07/22.
//

import SwiftUI
import Firebase

@main
struct NONTON_IDApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("loginStatus") var loginStatus = false
    @AppStorage("isDarkMode") var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            ZStack {
                if loginStatus {
                    MainView()
                } else {
                    LoginView()
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
