//
//  DhikrCounterListItemView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 29/06/25.
//

import SwiftUI

// Custom ProfileThemeRBtn View
struct DhikrCounterListItemView: View {
    private var item:DhikrCounterModel.Response.DhikrTemplateRows
    private let isSelected:Bool
    private let count:Int
    private let onDelete:() -> Void
    private let onAction:() -> Void
    
    init(item: DhikrCounterModel.Response.DhikrTemplateRows, isSelected:Bool, count:Int, onDelete: @escaping () -> Void, onAction: @escaping () -> Void) {
        self.item = item
        self.isSelected = isSelected
        self.count = count
        self.onDelete = onDelete
        self.onAction = onAction
    }
    
    
    var body: some View {
        
        HStack(alignment:.center,spacing: 14) {
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .foregroundColor(isSelected ? Colors.btnColor : .gray)
                .font(.system(size: 20)).padding(.leading,16)
            
            Rectangle()
                .fill(Colors.inputStroke)
                .frame(width: 1, height: 32)
           
            VStack(alignment:.leading,spacing:7){
                HStack{
                    TextFactory.text(type: .regular(text: item.text ?? Localize.unknown, font: .reg14))
                    Spacer()
                }
                HStack(spacing:12) {
                    TextFactory.text(type: .regular(text: "\(Localize.count): \(self.count)", font: .reg12, color: .seccondary))
                    TextFactory.text(type: .regular(text: "\(Localize.rounds): \(0)", font: .reg12, color: .seccondary))
                    Spacer()
                }
            }
            if item.type == "CUSTOM" {
                ZStack{
                    Image("ic_gray_delete")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }.frame(width: 44, height: 44, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 22, style: .continuous).fill(Colors.green)
                    ).padding(.trailing, 6)
                    .onTapGesture { self.onDelete() }
            }
        }.frame(height: 64)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Colors.green)
        ).onTapGesture { onAction() }
    }
}
