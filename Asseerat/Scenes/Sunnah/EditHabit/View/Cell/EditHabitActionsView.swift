//
//  EditHabitActionsView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 05/10/25.
//

import Foundation
import SwiftUI

struct EditHabitActionsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var onClick:(EditHabtType) -> Void
    private var itemsList:[EditHabtItemModel]
    init(items:[EditHabtItemModel], onClick: @escaping (EditHabtType) -> Void){
        self.itemsList = items
        self.onClick = onClick
    }
    
    var body: some View {
        VStack {
            self.navigationView()
            ScrollView(.vertical, showsIndicators: false){
                self.itemListView()
            }
        }.background(Colors.background)
    }
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            TextFactory.text(type: .regular(text: Localize.editSunnah, font: .reg20))
            
            HStack(alignment:.center, spacing:10){
                ButtonFactory.button(type: .roundedWhite(image: "ic_gray_cancel", onClick: {
                    self.presentationMode.wrappedValue.dismiss()
                })).padding(.leading, 14)
                Spacer()
            }
        }.frame(height: 42).frame(maxWidth:.infinity).padding(.vertical,16)
    }
    
    @ViewBuilder
    private func itemListView() -> some View {
        ForEach(itemsList.indices, id:\.self) { i in
            EditHabitActionsItem(image: itemsList[i].image, title: itemsList[i].title, isLast: itemsList[i].title == itemsList.last?.title) {
                self.onClick(itemsList[i].type)
                self.presentationMode.wrappedValue.dismiss()
            }
        }.padding(.horizontal,14)
    }
}


struct EditHabitActionsItem: View {
    let image:String
    let title: String
    let isLast: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Colors.background
            VStack {
                HStack(alignment:.center) {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 22, height: 22)
                        .padding(16)
                    TextFactory.text(type: .regular(text: title, font: .reg16))
                    Spacer()
                }.frame(height: 45).frame(maxWidth: .infinity)
                if !isLast {
                    Divider().background(Colors.seccondary).padding(.horizontal,16)
                }
            }
        }.onTapGesture { action()}
    }
}
