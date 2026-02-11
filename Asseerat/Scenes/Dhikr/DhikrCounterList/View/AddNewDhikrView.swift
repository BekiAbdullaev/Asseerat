//
//  AddNewDhikrView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 30/06/25.
//

import SwiftUI

struct AddNewDhikrView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var dhikrTitle:String = ""
    private var isActiveBtn:Bool {
        return isValidInput()
    }
    public var onClick:(String) -> Void
    var body: some View {
        VStack{
            TextFieldFactory.textField(type: .defaultTF(title: "\(Localize.dhikr)",  text: $dhikrTitle)).padding(.horizontal,16).padding(.top, 32)
            TextFactory.text(type: .regular(text: "\(Localize.dhikrRequirment)", font: .reg14, color: .seccondary, line: 4)).lineSpacing(8).padding(16)
            Spacer()
            HStack(alignment: .center){
                ButtonFactory.button(type: .bordered(text: "\(Localize.back)", onClick: {
                    self.presentationMode.wrappedValue.dismiss()
                }))
                ButtonFactory.button(type: .primery(text: Localize.add, isActive: MainBean.shared.changeToBindingBool(bool: isActiveBtn), onClick: {
                    onClick(dhikrTitle)
                    self.presentationMode.wrappedValue.dismiss()
                }))
            }.padding([.horizontal, .bottom], 16)
        }.background(Colors.background)
            .onTapGesture { keyboardEndEditing() }
            .onAppear {
            }
    }
    
    private func isValidInput() -> Bool {
        return dhikrTitle.count > 3
    }
}

