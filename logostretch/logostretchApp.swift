//
//  logostretchApp.swift
//  logostretch
//
//  Created by Emin Grbo on 30/05/2021.
//
import SwiftUI

@main
struct logostretchApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 15.0, *) {
//                ContentView()
                AdView()
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
