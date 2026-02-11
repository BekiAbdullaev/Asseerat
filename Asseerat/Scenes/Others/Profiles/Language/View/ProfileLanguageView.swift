//
//  ProfileLanguageView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 22/06/25.
//

import SwiftUI

struct ProfileLanguageView: View {
    
    private let viewModel = ProfileLanguageViewModel()
    
    @State private var selectedLang: String? = nil{
        didSet {
            self.setLangItem(lang: selectedLang)
        }
    }

    var body: some View {
        VStack(spacing:8){
            ScrollView(.vertical, showsIndicators: false){
                self.langGridView()
            }.padding(.top,16)
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.lang)
            .onAppear {
                selectedLang = UDManager.shared.getString(key: .currentLanguageKey)
            }
    }
    
    @ViewBuilder
    private func langGridView() -> some View {
        LazyVGrid(columns: viewModel.columns, spacing: 12) {
            ForEach(viewModel.langes, id: \.self) { item in
                ProfileLangRBtn(title: item.tittle,
                                code: item.code,
                                image: item.image,
                                isSelected: selectedLang == item.code,
                                action: { selectedLang = item.code }
               )
           }
        }.padding(.horizontal,14)
    }
    
    private func setLangItem(lang:String?) {
        UDManager.shared.setSting(key: .currentLanguageKey, object: lang ?? "en")
        Bundle.setLanguage(lang ?? "en")
        NotificationCenter.default.post(name: .updateLanguage, object: nil)
    }
}

// Custom ProfileThemeRBtn View
struct ProfileLangRBtn: View {
    let title: String
    let code:String
    let image:String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        
        HStack(alignment:.center,spacing: 16) {
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .foregroundColor(isSelected ? Colors.btnColor : .gray)
                .font(.system(size: 20)).padding(.leading,16)
            
            ZStack{
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 18)
            }.frame(width: 44, height: 44, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                ).foregroundColor(Colors.background)
            
            TextFactory.text(type: .regular(text: title, font: .reg14))
            Spacer()

        }.frame(height: 64)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Colors.green)
        ).onTapGesture { action()}
    }
}

#Preview {
    ProfileLanguageView()
}
