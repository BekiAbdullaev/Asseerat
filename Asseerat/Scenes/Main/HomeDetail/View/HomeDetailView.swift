//
//  HomeDetailView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 19/06/25.
//

import SwiftUI

struct HomeDetailView: View {
    
    private var detailType:HomeDetailType
    private var viewModel = HomeDetailViewModel()
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    
    init(detailType: HomeDetailType) {
        self.detailType = detailType
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false){
                self.setItems(type: detailType)
            }
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(viewModel.getHomeDetailNavTitle(type: detailType))
    }
    
    @ViewBuilder
    private func setItems(type:HomeDetailType) -> some View {
        switch type {
        case .life:
            self.setLifeItems()
        case .shamail:
            self.setShamailItems()
        case .companion:
            self.setCompanionItems()
        case .family:
            self.setFamilyItems()
        case .sunnah:
            self.setSunnahItems()
        }
    }
    
    @ViewBuilder
    private func setLifeItems() -> some View {
        VStack(spacing:10){
            HomeDetailCellView(item: viewModel.lifeList[0], onClick: {
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.lifeList[0].title)")))
            })
            HStack(spacing:10){
                HomeDetailCellView(item: viewModel.lifeList[1], height: 178) {
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.lifeList[1].title)")))
                }
                HomeDetailCellView(item: viewModel.lifeList[2], height: 178) {
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.lifeList[2].title)")))
                }
            }
            HomeDetailCellView(item: viewModel.lifeList[3]) {
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.lifeList[3].title)")))
            }
        }.padding(16)
    }
    
    @ViewBuilder
    private func setShamailItems() -> some View {
        VStack(spacing:10){
            HomeDetailCellView(item: viewModel.shamailList[0]){
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.shamailList[0].title)")))
            }
            HStack(spacing:10){
                HomeDetailCellView(item: viewModel.shamailList[1], height: 153){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.shamailList[1].title)")))
                }
                HomeDetailCellView(item: viewModel.shamailList[2], height: 153){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.shamailList[2].title)")))
                }
            }
            HStack(spacing:10){
                HomeDetailCellView(item: viewModel.shamailList[3], height: 153){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.shamailList[3].title)")))
                }
                HomeDetailCellView(item: viewModel.shamailList[4], height: 153){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.shamailList[4].title)")))
                }
            }
            HomeDetailCellView(item: viewModel.shamailList[5]){
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.shamailList[5].title)")))
            }
        }.padding(16)
    }
    
    @ViewBuilder
    private func setCompanionItems() -> some View {
        VStack(spacing:10){
            HomeDetailCellView(item: viewModel.companionList[0]){
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.companionList[0].title)")))
            }
            HomeDetailCellView(item: viewModel.companionList[1]){
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.companionList[1].title)")))
            }
            HomeDetailCellView(item: viewModel.companionList[2]){
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.companionList[2].title)")))
            }
            HStack(spacing:10){
                HomeDetailCellView(item: viewModel.companionList[3], height: 153){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.companionList[3].title)")))
                }
                HomeDetailCellView(item: viewModel.companionList[4], height: 153){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.companionList[4].title)")))
                }
            }
            HStack(spacing:10){
                HomeDetailCellView(item: viewModel.companionList[5], height: 153){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.companionList[5].title)")))
                }
                HomeDetailCellView(item: viewModel.companionList[6], height: 153){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.companionList[6].title)")))
                }
            }
        }.padding(16)
    }
    
    @ViewBuilder
    private func setFamilyItems() -> some View {
        VStack(spacing:10){
            HomeDetailCellView(item: viewModel.familyList[0]){
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.familyList[0].title)")))
            }
            HStack(spacing:10){
                HomeDetailCellView(item: viewModel.familyList[1], height: 172){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.familyList[1].title)")))
                }
                HomeDetailCellView(item: viewModel.familyList[2], height: 172){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.familyList[2].title)")))
                }
            }
            HomeDetailCellView(item: viewModel.familyList[3]){
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.familyList[3].title)")))
            }
        }.padding(16)
    }
    
    @ViewBuilder
    private func setSunnahItems() -> some View {
        VStack(spacing:10){
            HomeDetailCellView(item: viewModel.sunnahList[0]){
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.sunnahList[0].title)")))
            }
            HomeDetailCellView(item: viewModel.sunnahList[1]){
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.sunnahList[1].title)")))
            }
            
            HStack(spacing:10){
                HomeDetailCellView(item: viewModel.sunnahList[3], height: 178){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.sunnahList[3].title)")))
                }
                HomeDetailCellView(item: viewModel.sunnahList[4], height: 178){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.sunnahList[4].title)")))
                }
            }
            HStack(spacing:10){
                HomeDetailCellView(item: viewModel.sunnahList[5], height: 178){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.sunnahList[5].title)")))
                }
                HomeDetailCellView(item: viewModel.sunnahList[6], height: 178){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.sunnahList[6].title)")))
                }
            }
            HStack(spacing:10){
                HomeDetailCellView(item: viewModel.sunnahList[5], height: 178){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.sunnahList[5].title)")))
                }
                HomeDetailCellView(item: viewModel.sunnahList[6], height: 178){
                    self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.sunnahList[6].title)")))
                }
            }
            HomeDetailCellView(item: viewModel.sunnahList[2]){
                self.coordinator.navigate(type: .ai(.aichat(isGlobalChat: false, firstPrompt: "\(viewModel.sunnahList[2].title)")))
            }
        }.padding(16)
    }
}

#Preview {
    HomeDetailView(detailType: .life)
}
