//
//  HomeARListView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 07/10/25.
//

import SwiftUI

struct HomeARListView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = HomeARViewModel()
    @State private var arList:[HomeARModel.Response.HomeARListRows] = []
    
    var body: some View {
        VStack(alignment: .leading){
            if arList.isEmpty {
                EmptyView(title: Localize.arEmtpyTitle, subtitle: Localize.arEmtpySubtitle)
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    self.setARItems()
                }
            }
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.arNavTitle)
            .onDidLoad {
                self.viewModel.getARList { items in
                    arList = items
                }
            }
    }
    
    @ViewBuilder
    private func setARItems() -> some View {
        VStack(alignment:.leading, spacing:10){
            HStack(alignment: .center) {
                TextFactory.text(type: .medium(text: Localize.arList, font: .med18, color: .seccondary, line: 1))
                    .padding(.top,16).padding(.bottom, 8)
                Spacer()
            }
            
            ForEach(self.arList, id: \.self) { item in
                HomeDetailCellView(item: HomeDetailItem(title: item.name_uz ?? Localize.unknown, subtitle: item.description_uz ?? Localize.unknown), onClick: {
                    self.coordinator.navigate(type: .home(.homeARDetail(title: item.name_uz ?? Localize.arNavTitle)))
                })
            }
        }.padding(.horizontal,16)
    }
}

#Preview {
    HomeARListView()
}
