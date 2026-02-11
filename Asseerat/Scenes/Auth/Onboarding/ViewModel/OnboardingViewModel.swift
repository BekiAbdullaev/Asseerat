//
//  OnboardingViewModel.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import Foundation
import SwiftUI

struct OnboardingStep {
    let image:String
    let title:String
    let description:String
}

struct OnboardingViewModel {
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    let onboardingSteps = [
        OnboardingStep(image: "ic_onboarding0", title: Localize.onboard1Title, description: Localize.onboard1Detail),
        OnboardingStep(image: "ic_onboarding1", title: Localize.onboard2Title, description: Localize.onboard2Detail),
        OnboardingStep(image: "ic_onboarding2", title: Localize.onboard3Title, description: Localize.onboard3Detail),
        OnboardingStep(image: "ic_onboarding3", title: Localize.onboard4Title, description: Localize.onboard4Detail),
        OnboardingStep(image: "ic_onboarding4", title: Localize.onboard5Title, description: Localize.onboard5Detail)
    ]
}


