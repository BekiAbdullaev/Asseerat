//
//  HomeDetailCellView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 19/06/25.
//

import SwiftUI


struct HomeDetailCellView: View {
    
    private var item:HomeDetailItem
    private var height:CGFloat?
    private var onClick:() -> Void
    
    init(item: HomeDetailItem, height:CGFloat = 134, onClick: @escaping () -> Void) {
        self.item = item
        self.height = height
        self.onClick = onClick
    }
    
    var body: some View {
        ZStack {
            Colors.green
            HStack {
                VStack(alignment:.leading, spacing: 5) {
                    TextFactory.text(type: .semibold(text: item.title, font: .sem18, line: 2))
                        .lineSpacing(5).padding([.horizontal,.top], 16)
                    if item.subtitle.isNotEmpty {
                        TextFactory.text(type: .regular(text: item.subtitle, font: .reg12, color: .seccondary, line: 4))
                            .lineSpacing(2).padding([.horizontal], 16)
                    }
                    Spacer()
                    Image("ic_circle_row")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24, alignment: .center)
                        .padding([.leading,.bottom], 16)
                }
                Spacer()
            }
        }.frame(maxWidth:.infinity).frame(height: height)
            .cornerRadius(16, corners: .allCorners)
            .onTapGesture {
                self.onClick()
            }
    }
}
