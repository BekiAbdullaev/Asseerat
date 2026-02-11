//
//  SignUpView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/06/25.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var name = ""
    @State var validName:Bool = false
    @State private var surname = ""
    @State var validSurname:Bool = false
    @State private var date = ""
    @State var validDate:Bool = false
    @State private var dateHasError:Bool = false
    @State private var selectedSegment = 0
    @State private var phone = ""
    @State var validPhone:Bool = false
    private var isActiveRegistration:Bool {
        return validDate && validPhone
    }
    
    @ObservedObject private var viewModel = SignUpViewModel()
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    
    var body: some View {
        VStack {
            self.navigationView()
            ScrollView(.vertical, showsIndicators: false){
                self.bodyView()
            }.onTapGesture {
                keyboardEndEditing()
            }
        }.background(Colors.background)
            .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            HStack{
                Spacer()
                Button(action: clickSkip) {
                    TextFactory.text(type: .medium(text: Localize.skip, font: .med18, line: 1))
                }.padding(.trailing,16)
            }
        }.frame(height: 50).frame(maxWidth:.infinity)
    }
    
    @ViewBuilder
    private func bodyView() -> some View {
        VStack(alignment:.leading, spacing: 16) {
            TextFactory.text(type: .medium(text: Localize.joinUs, font: .med28, line: 1)).padding(.top, 16)
            TextFactory.text(type: .regular(text: Localize.joinUsDetail, font: .reg14, color: .seccondary, line: 3)).padding(.trailing, 40).lineSpacing(6)
                .padding(.top, 10)
            
        
            TextFieldFactory.textField(type: .defaultTF(title: Localize.name, text: $name)).padding(.top,40)
            TextFieldFactory.textField(type: .defaultTF(title: Localize.lastName, text: $surname)).padding(.top,8)
        
            self.segmentView().padding(.top,8)
            TextFieldFactory.textField(type: .phone9(title: Localize.telephone, number: $phone, isValid: $validPhone)).padding(.top, 8)
            TextFieldFactory.textField(type: .date(title: Localize.date, date: $date, isValid: $validDate, hasError: $dateHasError)).padding(.top,8)
            
            Spacer()
            
            ButtonFactory.button(type: .primery(text: Localize.register, isActive: MainBean.shared.changeToBindingBool(bool: isActiveRegistration), onClick: clickRegisteration))
                .padding(.vertical, 16)
        
            TextFactory.text(type: .link(text: Localize.registerTerm, linkText: Localize.privacyPolicy, color: Colors.seccondary, linkColor: Colors.white, url: "https://www.apple.com/privacy"))
                .frame(maxWidth:.infinity).padding(.horizontal,45).lineSpacing(6)
                .multilineTextAlignment(.center)
        
            Divider().background(Colors.seccondary).padding(.top, 18)
            
            ButtonFactory.button(type: .textBtn(text: Localize.areURegistered, btnText: Localize.logIn, onClick: clickLogin)).padding(.bottom, 16)
        }.padding(.horizontal,16)
    }
    
    @ViewBuilder
    private func segmentView() -> some View {
        VStack{
            CustomSegmentedControl(preselectedIndex: $selectedSegment,
                                   options: [Localize.male, Localize.female])
        }
    }
    
    func clickSkip() {
        self.coordinator.navigate(type: .auth(.tabView))
    }
    
    func clickRegisteration() {
        if isActiveRegistration {
            let name = name
            let surname = surname
            let sex = selectedSegment == 0 ? CompMethod.MALE : CompMethod.FEMALE
            let phone = "998\(phone)"
            let birthdate = date
            
            self.coordinator.navigate(type: .auth(.setPassword(type: .setPassword(name: name, lastname: surname, sex: sex, phone: phone, birthdate: birthdate))))
        }
    }
    
    func clickLogin(){
        self.coordinator.pop()
    }
}

#Preview {
    SignUpView()
}
