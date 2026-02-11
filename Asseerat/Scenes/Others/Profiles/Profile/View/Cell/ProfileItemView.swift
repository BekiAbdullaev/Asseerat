//
//  ProfileItemView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 20/06/25.
//

import SwiftUI

struct ProfileItemView: View {
    
    private var icon:String
    private var title:String
    private var hasSwich:Bool
    private var onClick:() -> Void
    @Binding var togleState: Bool
    
    init(icon: String, title: String, hasSwich:Bool = false, onClick: @escaping () -> Void = {}, togleState: Binding<Bool> = .constant(false) ) {
        self.icon = icon
        self.title = title
        self.hasSwich = hasSwich
        self.onClick = onClick
        self._togleState = togleState
    }
    
    
    var body: some View {
        ZStack {
            Colors.green
            HStack(alignment:.center, spacing: 18){
                Image(icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(.leading,18)
                
                Rectangle()
                    .fill(Colors.inputStroke)
                    .frame(width: 1, height: 32)
                
                TextFactory.text(type: .regular(text: title, font: .sem16, line: 1))
                Spacer()
                if hasSwich {
                    Toggle("", isOn: $togleState)
                        .frame(width: 47, height: 28)
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                        .tint(.white)
                        .padding(.trailing, 24)
                }
            }
        }.frame(maxWidth:.infinity).frame(height: 54)
            .cornerRadius(15, corners: .allCorners)
            .padding(.horizontal)
            .onTapGesture {
                self.onClick()
            }
    }
}

