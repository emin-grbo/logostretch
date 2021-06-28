//
//  adView.swift
//  logostretch
//
//  Created by Emin Grbo on 28/06/2021.
//

import SwiftUI
import UIKit

struct AdView: View {
    
    var body: some View {
        AdContent()
    }
}

struct AdContent: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        return MyAdView()
    }

    func updateUIViewController(_ uiView: UIViewController, context: Context) {
        
    }
}

class MyAdView: UIViewController {
    override func viewDidLoad() {
        
    }
}
