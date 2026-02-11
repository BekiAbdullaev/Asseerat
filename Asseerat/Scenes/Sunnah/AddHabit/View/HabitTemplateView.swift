//
//  HabitTemplateView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 12/07/25.
//

import SwiftUI

struct HabitTemplateView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = AddHabitViewModel()
    @State var isActiveBtn:Bool = true
    private var sunnahTemplates:[AddHabitModel.SunnahTemplatesRows]?
    private var onBack:(AddHabitModel.SunnahTemplatesRows?) -> Void
    
    init(sunnahTemplates: [AddHabitModel.SunnahTemplatesRows]? = nil, onBack: @escaping (AddHabitModel.SunnahTemplatesRows?) -> Void) {
        self.sunnahTemplates = sunnahTemplates
        self.onBack = onBack
    }
    
    var body: some View {
        VStack(alignment:.leading,spacing:10){
            
            TextFactory.text(type: .medium(text: Localize.addNewSunnah, font: .med18)).padding(.horizontal).padding(.top, 24)
            ScrollView(.vertical, showsIndicators: false){
                HStack {
                    TextFactory.text(type: .regular(text: Localize.standart.uppercased(), font: .reg12, color: .seccondary, line: 1))
                    Spacer()
                }.padding(.horizontal, 16)
                self.habitTemplateGridView()
            }.padding(.top,16)
            Spacer()
            ButtonFactory.button(type: .primery(text: Localize.createCustomSunnah, isActive: $isActiveBtn, onClick: {
                self.presentationMode.wrappedValue.dismiss()
                self.onBack(nil)
            })).padding([.horizontal, .bottom], 16)
        }.background(Colors.background)
    }
    
    @ViewBuilder
    private func habitTemplateGridView() -> some View {
        LazyVGrid(columns: viewModel.templateGridColumns, spacing: 8) {
            ForEach(sunnahTemplates ?? [], id: \.self) { item in
                HabitTemplateItemView(item: item)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                        self.onBack(item)
                    }
           }
        }.padding(.horizontal, 16)
    }
}

