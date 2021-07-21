//
//  adView.swift
//  logostretch
//
//  Created by Emin Grbo on 28/06/2021.
//

import SwiftUI
import UIKit
import AppLovinSDK

struct AdView: UIViewControllerRepresentable {
    
    let didComplete: Binding<Bool>
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = RewardedAd()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiView: UIViewController, context: Context) {}
    
    // this will be the delegate of the view controller, it's role is to allow
    // the data transfer from UIKit to SwiftUI
    class Coordinator: RewardDelegate {
        let didCompleteBinding: Binding<Bool>
        
        init(didCompleteBinding: Binding<Bool>) {
            self.didCompleteBinding = didCompleteBinding
        }
        
        func rewardOccured(_ didComplete: Bool) {
            // whenever the view controller notifies it's delegate about receiving a new idenfifier
            // the line below will propagate the change up to SwiftUI
            didCompleteBinding.wrappedValue = didComplete
        }
    }
    
    // this is very important, this coordinator will be used in `makeUIViewController`
    func makeCoordinator() -> Coordinator {
        Coordinator(didCompleteBinding: didComplete)
    }
}


class RewardedAd: UIViewController, MARewardedAdDelegate {
    
    weak var delegate: RewardDelegate?
    
    var rewardedAd: MARewardedAd!
    var retryAttempt = 0.0
    
    func createRewardedAd() {
        rewardedAd = MARewardedAd.shared(withAdUnitIdentifier: "c8930a9db2932500")
        rewardedAd.delegate = self
        
        // Load the first ad
        rewardedAd.load()
    }
    
    // MARK: MAAdDelegate Protocol
    func didLoad(_ ad: MAAd) {
        // Rewarded ad is ready to be shown. '[self.rewardedAd isReady]' will now return 'YES'
        if rewardedAd.isReady
        {
            rewardedAd.show()
        }
        // Reset retry attempt
        retryAttempt = 0
    }
    
    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        // Rewarded ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        
        retryAttempt += 1
        let delaySec = pow(2.0, min(6.0, retryAttempt))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySec) {
            self.rewardedAd.load()
        }
    }
    
    func didDisplay(_ ad: MAAd) {}
    
    func didClick(_ ad: MAAd) {}
    
    func didHide(_ ad: MAAd) {
        // Rewarded ad is hidden. Pre-load the next ad
        rewardedAd.load()
    }
    
    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        // Rewarded ad failed to display. We recommend loading the next ad
        rewardedAd.load()
    }
    
    // MARK: MARewardedAdDelegate Protocol
    func didStartRewardedVideo(for ad: MAAd) {}
    
    func didCompleteRewardedVideo(for ad: MAAd) {
        print("")
    }
    
    func didRewardUser(for ad: MAAd, with reward: MAReward) {
        // Rewarded ad was displayed and user should receive the reward
        delegate?.rewardOccured(true)
    }
    
    override func viewDidLoad() {
        createRewardedAd()
    }
}

protocol RewardDelegate: AnyObject {
    func rewardOccured(_ didComplete: Bool)
}
