//
//  HabitListSelectionView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 09/08/25.
//

import SwiftUI

struct HabitListSelectionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var viewModel:AddHabitViewModel
    private var onClick:(Int) -> Void
    @State private var listId: Int? = nil{
        didSet {
            self.setListId(id: listId)
        }
    }
    
    init(listId:Int, vm:AddHabitViewModel, onClick: @escaping (Int) -> Void){
        self.listId = listId
        self.onClick = onClick
        self.viewModel = vm
    }
    
    
    var body: some View {
        VStack {
            self.navigationView()
            self.listGridView()
            Spacer()
        }.background(Colors.background)
    }
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            TextFactory.text(type: .regular(text: Localize.list, font: .reg20))
            
            HStack(alignment:.center, spacing:10){
                ButtonFactory.button(type: .roundedWhite(image: "ic_gray_cancel", onClick: {
                    self.presentationMode.wrappedValue.dismiss()
                })).padding(.leading, 14)
                Spacer()
            }
        }.frame(height: 42).frame(maxWidth:.infinity).padding(.top,16).padding(.bottom, 24)
    }
    
    @ViewBuilder
    private func listGridView() -> some View {
        LazyVGrid(columns: viewModel.listGridColumns, spacing: 12) {
            ForEach(viewModel.habitListTypes, id: \.self) { type in
                HabitListSelectionItem(title: type.name_en ?? "", isSelected: listId == type.id, isLast: checkIsLast(typeId: type.id ?? 0), action: {listId = type.id})
            }
        }
    }
    
    private func setListId(id:Int?) {
        if let id = id {
            self.onClick(id)
        }
    }
    
    private func checkIsLast(typeId:Int) -> Bool {
        return viewModel.habitListTypes.last?.id == typeId
    }
}

struct HabitListSelectionItem: View {
    let title: String
    let isSelected: Bool
    let isLast: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Colors.background
            VStack {
                HStack(alignment:.center) {
                    TextFactory.text(type: .regular(text: title, font: .reg16)).padding(.leading,20)
                    Spacer()
                    
                    Image(isSelected ? "ic_check" : "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 22, height: 22)
                        .padding(.trailing,20)

                }.frame(height: 40).frame(maxWidth: .infinity)
                if !isLast {
                    Divider().background(Colors.seccondary).padding(.horizontal,16)
                }
            }
        }.onTapGesture { action()}
    }
}
