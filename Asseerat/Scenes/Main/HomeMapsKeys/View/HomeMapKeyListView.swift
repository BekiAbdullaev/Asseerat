//
//  HomeMapKeyListView.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 14/10/25.
//

import Foundation
import SwiftUI

struct HomeMapKeyListView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = HomeMapKeyViewModel()
    @State private var mapAndKeysList:[HomeMapKeyModel.Response.HomeMapKeyListRows] = []
    
    var body: some View {
        VStack(alignment: .leading){
            if self.mapAndKeysList.isEmpty {
                EmptyView(title: Localize.mapAndKeyLocEmityTitle, subtitle: Localize.mapAndKeyLocEmitySubtitle)
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    self.setARItems()
                }
            }
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.mapAndKeyLocNavTitle)
            .onDidLoad {
                self.viewModel.getMapsAndLocationsAll {items in
                    self.mapAndKeysList = items
                }
            }
    }
    
    @ViewBuilder
    private func setARItems() -> some View {
        VStack(alignment:.leading, spacing:10){
            HStack(alignment: .center) {
                TextFactory.text(type: .medium(text: Localize.mapAndKeyLocList, font: .med18, color: .seccondary, line: 1))
                    .padding(.top,16).padding(.bottom, 8)
                Spacer()
            }
            
            ForEach(self.mapAndKeysList, id: \.self) { item in
                HomeDetailCellView(item: HomeDetailItem(title: item.name_uz ?? "Unknown", subtitle: item.description_uz ?? "Unknown"), onClick: {
                    self.coordinator.navigate(type: .home(.homeMapKeyDetail(title: item.name_uz ?? Localize.mapAndKeyLocNavTitle, id: item.id ?? 0)))
                })
            }
        }.padding(.horizontal,16)
    }
}
