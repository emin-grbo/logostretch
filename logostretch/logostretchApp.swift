//
//  logostretchApp.swift
//  logostretch
//
//  Created by Emin Grbo on 30/05/2021.
//
import SwiftUI
import AppLovinSDK
        
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Please make sure to set the mediation provider value to "max" to ensure proper functionality.
        ALSdk.shared()!.mediationProvider = "max"
        ALSdk.shared()!.initializeSdk { (configuration: ALSdkConfiguration) in
            // AppLovin SDK is initialized, start loading ads
        }
        
        return true
    }
}

@main
struct logostretchApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            if #available(iOS 15.0, *) {
            ContentView()
            }
        }
    }
}
