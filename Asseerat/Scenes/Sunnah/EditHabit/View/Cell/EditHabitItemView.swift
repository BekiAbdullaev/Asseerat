//
//  EditHabitItemView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 12/07/25.
//

import Foundation
import SwiftUI

struct EditHabitItemView: View {
    let item:SunnahModel.GetClientHabitsRows
    let onEdit:() -> Void
    init(item: SunnahModel.GetClientHabitsRows, onEdit: @escaping () -> Void) {
        self.item = item
        self.onEdit = onEdit
    }
    
    var body: some View {
        HStack(alignment:.center,spacing: 10) {
            ZStack{
                Image(item.icon_name ?? "")
                    .renderingMode(.template)
                    .foregroundColor(item.status == 2 ? .seccondary : .white)
                    .frame(width: 22, height: 22)
            }.frame(width: 44, height: 44, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                ).foregroundColor(Colors.background).padding(.leading, 10)
            VStack(alignment:.leading, spacing: 4) {
                TextFactory.text(type: .regular(text: item.name ?? "", font: .reg18, color: item.status == 2 ? .seccondary :.white))
                HStack(alignment: .center) {
                    TextFactory.text(type: .regular(text: "\(Localize.goal): \(item.required_count ?? 0)\t", font: .reg12, color: .seccondary.opacity(item.status == 2 ? 0.5 : 1)))
                    TextFactory.text(type: .regular(text: "\(Localize.type): \(item.type?.name_en ?? "")", font: .reg12, color: .seccondary.opacity(item.status == 2 ? 0.5 : 1)))
                }
            }
            
            Spacer()
            ButtonFactory.button(type: .roundedWhite(image: "ic_more", needShedow: false, onClick: {
                self.onEdit()
            })).padding(.trailing, 5)
        }.frame(height: 64)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Colors.green)
        ).padding(.horizontal,16)
    }
}
