//
//  DhikrRatingItemView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 30/06/25.
//

import SwiftUI
struct DhikrRatingItemView: View {
    
    private let item:DhikrRatingModel.Response.DhikrRatingRows
    private let index:Int
    
    init(item: DhikrRatingModel.Response.DhikrRatingRows, index:Int) {
        self.item = item
        self.index = index
    }
    
    var body: some View {
        HStack(alignment:.center, spacing: 14){
            TextFactory.text(type: .regular(text: "\(index+1)", font: .reg16)).frame(width: 25).padding(.leading,14)
            Rectangle()
                .fill(Colors.inputStroke)
                .frame(width: 1, height: 32)
            ZStack{
                Image("ic_profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
            }.frame(width: 44, height: 44, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                ).foregroundColor(Colors.background)
            
            VStack(alignment:.leading, spacing: 4) {
                TextFactory.text(type: .regular(text: "\(item.name ?? "") \(item.surname ?? "")", font: .reg16))
                TextFactory.text(type: .regular(text: "\(Localize.count): \(item.summ ?? 0)", font: .reg12, color: .seccondary))
            }.padding(.leading,6)
            Spacer()
            
        }.frame(height: 66)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Colors.green)
                    .stroke(/*item.isActive ? Colors.btnColor : */Colors.green, lineWidth: 1)
            ).padding(.top,3)
    }
}
