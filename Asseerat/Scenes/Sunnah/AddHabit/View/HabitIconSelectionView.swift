//
//  HabitIconSelectionView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 09/08/25.
//

import SwiftUI

struct HabitIconSelectionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = AddHabitViewModel()
    private var onClick:(String) -> Void
    @State private var selectedIcon: String? = nil{
        didSet {
            self.setIconItem(icon: selectedIcon)
        }
    }
    
    init( selectedIcon:String, onClick: @escaping (String) -> Void){
        self.selectedIcon = selectedIcon
        self.onClick = onClick
    }
    
    var body: some View {
        VStack {
            self.navigationView()
            self.iconGridView()
            Spacer()
        }.background(Colors.background)
    }
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            TextFactory.text(type: .regular(text: Localize.chooseIcon, font: .reg20))
            
            HStack(alignment:.center, spacing:10){
                ButtonFactory.button(type: .roundedWhite(image: "ic_gray_cancel", onClick: {
                    self.presentationMode.wrappedValue.dismiss()
                })).padding(.leading, 14)
                Spacer()
            }
        }.frame(height: 42).frame(maxWidth:.infinity).padding(.top,16).padding(.bottom,36)
    }
    
    @ViewBuilder
    private func iconGridView() -> some View {
        LazyVGrid(columns: viewModel.iconGridColumns, spacing: 12) {
            ForEach(viewModel.habitIconList, id: \.self) { icon in
                HabitIconSelectionItem(image: icon, isSelected: selectedIcon == icon, action: {selectedIcon = icon})
            }
        }.padding(.horizontal,14)
    }
    
    private func setIconItem(icon:String?) {
        if let icon = icon {
            self.onClick(icon)
        }
    }
}


// Custom HabitIconSelectionItem View
struct HabitIconSelectionItem: View {
    let image:String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        }.frame(width: 60, height: 60, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Colors.green)
                    .stroke(isSelected ? Colors.btnColor : Colors.green, lineWidth: 1)
            ).onTapGesture { action()}
    }
}
