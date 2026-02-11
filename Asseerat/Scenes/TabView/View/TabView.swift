//
//  TabView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home
    case sunnah
    case dhikr
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    @State private var refreshID = UUID()
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var vmPrayerTime = PrayerTimeViewModel()
    @StateObject private var sunnahViewModel = SunnahsViewModel()
    @StateObject private var dhikrViewModel = DhikrsViewModel()
    
    init(selectedTab: Tab = .home) {
        self.selectedTab = selectedTab
    }
    
    var body: some View {
        ZStack {
            Colors.background
            VStack(spacing: 1) {
                ZStack {
                   HomeView(viewModel: homeViewModel, vmPrayerTime: vmPrayerTime)
                       .environmentObject(homeViewModel)
                       .opacity(selectedTab == .home ? 1 : 0)
                   
                   SunnahsView(viewModel: sunnahViewModel)
                       .environmentObject(sunnahViewModel)
                       .opacity(selectedTab == .sunnah ? 1 : 0)
                   
                   DhikrsView(viewModel: dhikrViewModel)
                       .environmentObject(dhikrViewModel)
                       .opacity(selectedTab == .dhikr ? 1 : 0)
                }
            
                ZStack {
                    HStack {}
                    .frame(maxWidth:.infinity, minHeight: 60)
                    .background(Colors.inputStroke)
                    .cornerRadius(17, corners: [.topLeft, .topRight])
                    .offset(y: -2)
                    
                    HStack(spacing:8){
                        TabBarItem(currentView: self.$selectedTab, imageName: "ic_tab_home",title: Localize.home, tab: .home)
                        TabBarSelectItem(imageName: "ic_tab_ai", title: "Asseerat AI") {
                            self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: true, firstPrompt: "")),style: .presentFullscreen)
                        }.padding(.trailing,5)
                        TabBarItem(currentView: self.$selectedTab, imageName: "ic_tab_sunnah", title: Localize.sunnahs, tab: .sunnah)
                        TabBarItem(currentView: self.$selectedTab, imageName: "ic_tab_dhikr", title: Localize.dhikrs, tab: .dhikr)
                    }
                    .frame(minHeight: 60)
                    .background(Colors.background)
                    .cornerRadius(15, corners: [.topLeft, .topRight])
                    .id(refreshID)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }.navigationViewStyle(StackNavigationViewStyle())
            .background(Colors.background)
            .onReceive(NotificationCenter.default.publisher(for: .updateLanguage)) { _ in
                refreshID = UUID()
            }
    }
}

#Preview {
    MainTabView()
}
