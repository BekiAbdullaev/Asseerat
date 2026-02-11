//
//  HomeProgressView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 19/06/25.
//

import SwiftUI

struct HomeProgressView: View {
    private var viewModel = HomeViewModel()
    @State private var isPressed = false
    private var onClick:() -> Void
    
    init( onClick: @escaping () -> Void){
        self.onClick = onClick
    }
    
    
    var body: some View {
        ZStack {
            Colors.green
            VStack(alignment:.leading) {
                HStack {
                    TextFactory.text(type: .semibold(text: Localize.dailySunnahAnalytics, font: .sem16, line: 2))
                        .lineSpacing(2).padding([.horizontal,.top], 14)
                }
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:12){
                        ForEach(0 ..< viewModel.daysProgress.count, id: \.self) { index in
                            CyclingProgressBar(cycleItem: viewModel.daysProgress[index], progress: viewModel.daysProgress[index].progress)
                        }
                    }.padding([.horizontal, .bottom], 16).padding(.top,3)
                }
            }
        }.frame(maxWidth:.infinity).frame(height: 110)
            .cornerRadius(16, corners: .allCorners)
            .padding(.horizontal, 16)
            .onTapGesture {
                self.onClick()
            }
    }
}

