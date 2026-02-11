//
//  OnboardingView.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI
import Combine

struct OnboardingView: View {
    @State private var currentStep = 0
    @State var activeBtn: Bool = true
    private var viewModel = OnboardingViewModel()
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
        
    var body: some View {
        ZStack {
            Colors.background
            self.bodyView()
            self.navigationView()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear {
            self.setInterfaceTheme()
        }
    }
    

    private func setInterfaceTheme() {
          DispatchQueue.main.async {
              let theme = UserDefaults.standard.theme
              UIApplication.shared.connectedScenes
                  .compactMap { $0 as? UIWindowScene }
                  .forEach { windowScene in
                      windowScene.windows.forEach { window in
                          window.overrideUserInterfaceStyle = theme.userInterfaceStyle
                      }
                  }
          }
      }
          
    @ViewBuilder
    private func navigationView() -> some View {
        VStack {
            HStack{
                Spacer()
                Button {
                    self.currentStep = viewModel.onboardingSteps.count - 1
                } label: {
                    TextFactory.text(type: .medium(
                        text: self.currentStep == viewModel.onboardingSteps.count - 1 ? "" : Localize.skip,
                        font: AppFonts.med18
                    ))
                    .padding(.trailing,16)
                }
            }
            .padding(.top, biometricType() == .face ? 70 : 30)
            Spacer()
        }
    }
    
    @ViewBuilder
    private func bodyView() -> some View {
        VStack {
            TabView(selection: $currentStep) {
                ForEach(viewModel.onboardingSteps.indices, id: \.self) { index in
                    VStack{
                        Image(viewModel.onboardingSteps[index].image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: viewModel.screenWidth, height: viewModel.screenHeight * 0.63)
                            .clipped()
                    
                        TextFactory.text(type: .medium(text: viewModel.onboardingSteps[index].title, font: AppFonts.med24)).padding(.top, 36)
                        TextFactory.text(type: .regular(text: viewModel.onboardingSteps[index].description, font: AppFonts.reg16, color: Colors.seccondary, line: 4))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .padding(.top, 16)
                            .lineSpacing(6)
                        Spacer()
                    }
                    .frame(width: viewModel.screenWidth, height: viewModel.screenHeight)
                    .ignoresSafeArea()
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .id(viewModel.onboardingSteps.count) // Fix for iOS 26 TabView glitch
            
            if currentStep < viewModel.onboardingSteps.count - 1 {
                HStack {
                    HStack(spacing: 8) {
                        ForEach(viewModel.onboardingSteps.indices, id: \.self) { index in
                            if index == currentStep {
                                Rectangle()
                                    .frame(width: 20, height: 10)
                                    .cornerRadius(5)
                                    .foregroundColor(Colors.white)
                            } else {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(Colors.seccondary)
                            }
                        }
                    }
                    Spacer()
                    ButtonFactory.button(type: .rounded(onClick: {
                        guard currentStep < viewModel.onboardingSteps.count - 1 else { return }
                        currentStep += 1
                    }))
                }
                .frame(height:50)
                .padding()
                .padding(.bottom, biometricType() == .face ? 30 : 20)
            } else {
                ButtonFactory.button(type: .primery(text: Localize.getStarted, isActive: $activeBtn, onClick: {
                    coordinator.navigate(type: .auth(.login))
                }))
                .padding()
                .padding(.bottom, biometricType() == .face ? 30 : 20)
            }
        }
    }
}
