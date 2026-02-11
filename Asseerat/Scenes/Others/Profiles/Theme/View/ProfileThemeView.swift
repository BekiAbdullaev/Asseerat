//
//  ProfileThemeView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 22/06/25.
//

import SwiftUI

struct ProfileThemeItem:Hashable {
    let tittle:String
    let image:String
}

struct ProfileThemeView: View {
    @State private var selectedItem: String? = nil{
        didSet {
            self.setThemeItem(theme: selectedItem)
        }
    }
    private let items = [ProfileThemeItem(tittle: Localize.green, image: "img_theme_green"),
                         ProfileThemeItem(tittle: Localize.gray, image: "img_theme_gray")]
    private let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    @State private var currentTheme: Theme = UserDefaults.standard.theme
  
    
    var body: some View {
        VStack(spacing:8){
            ScrollView(.vertical, showsIndicators: false){
                self.themeGridView()
            }.padding(.top,16)
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.theme)
            .onAppear {
                let theme = UserDefaults.standard.theme
                selectedItem = theme == .dark ? Localize.gray : Localize.green
            }
        
    }
    
    @ViewBuilder
    private func themeGridView() -> some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(items, id: \.self) { item in
                ProfileThemeRBtn(title: item.tittle,
                                 image: item.image,
                                 isSelected: selectedItem == item.tittle,
                                 action: { selectedItem = item.tittle }
               )
           }
        }.padding(.horizontal,14)
    }
    
    private func setThemeItem(theme:String?) {
        if let theme = theme {
            if theme == "Green"{
                currentTheme = .light
            } else {
                currentTheme = .dark
            }
            UserDefaults.standard.theme = currentTheme
//            UIApplication.shared.windows.forEach { window in
//                window.overrideUserInterfaceStyle = currentTheme.userInterfaceStyle
//            }
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .forEach { windowScene in
                    windowScene.windows.forEach { window in
                        window.overrideUserInterfaceStyle = currentTheme.userInterfaceStyle
                    }
                }
        }
    }
}

// Custom ProfileThemeRBtn View
struct ProfileThemeRBtn: View {
    let title: String
    let image:String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(alignment:.center, spacing: 8) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:(UIScreen.main.bounds.width-70)/2, height: 104)
                .padding(.top,13)
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isSelected ? Colors.btnColor : .gray)
                    .font(.system(size: 20))
                TextFactory.text(type: .regular(text: title, font: .reg14))
                Spacer()
            }.padding([.bottom, .horizontal],14).padding(.top, 8)
        }.background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Colors.green)
        ).onTapGesture { action()}
    }
}


#Preview {
    ProfileThemeView()
}
