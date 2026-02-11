//
//  AssistentAITypeView.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 14/11/25.
//

import SwiftUI

struct AssistentAITypeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var viewModel:AssistantAIViewModel
    private var onClick:(String) -> Void
    @State private var listId: String? = nil{
        didSet {
            self.setListId(id: listId)
        }
    }
    
    init(listId:String, vmModel:AssistantAIViewModel, onClick: @escaping (String) -> Void){
        self.listId = listId
        self.viewModel = vmModel
        self.onClick = onClick
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
            TextFactory.text(type: .regular(text: Localize.aiTypes, font: .reg20))
            
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
            ForEach(viewModel.listAITypes, id: \.self) { type in
                HabitListSelectionItem(title: type.name, isSelected: listId == type.id, isLast: checkIsLast(typeId: type.id), action: {listId = type.id})
            }
        }
    }
    
    private func setListId(id:String?) {
        if let id = id {
            self.onClick(id)
        }
    }
    
    private func checkIsLast(typeId:String) -> Bool {
        return viewModel.listAITypes.last?.id == typeId
    }
}
