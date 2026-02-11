//
//  HabitTemplateItemView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 12/07/25.
//

import SwiftUI

struct HabitTemplateItemView: View {
    
    private var item:AddHabitModel.SunnahTemplatesRows
    init(item: AddHabitModel.SunnahTemplatesRows) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment:.center,spacing: 13) {
            ZStack{
                Image(item.icon_name ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }.frame(width: 36, height: 36, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                ).foregroundColor(Colors.background).padding(.top, 12)
            
            TextFactory.text(type: .regular(text: item.name_en ?? "", font: .reg12, line: 1))
                .padding(.bottom, 16)
            
        }.frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Colors.green)
        )
    }
}

