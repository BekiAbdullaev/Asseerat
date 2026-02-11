//
//  ForgetPasswordView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/06/25.
//

import SwiftUI

enum PasswordInitType {
    case forgetPassword
    case changePassw
}

struct ForgetPasswordView: View {
    
    @State private var phone = ""
    @State private var passInitText = ""
    @State var validPhone:Bool = false
    @State private var isActiveVarify = false
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = ForgetPasswordViewModel()
    private var passInitType: PasswordInitType
    
    init(type:PasswordInitType) {
        self.passInitType = type
    }
    
    var body: some View {
        VStack {
            self.bodyView()
        }.background(Colors.background)
            .navigationBarHidden(false)
            .onTapGesture { keyboardEndEditing() }
            .onDidLoad {
                passInitText = passInitType == .forgetPassword ? Localize.forgetPassword : Localize.changePassword
            }
    }
    
    @ViewBuilder
    private func bodyView() -> some View {
        VStack(alignment:.leading, spacing: 16) {
            TextFactory.text(type: .medium(text: passInitText, font: .med28, line: 1))
                .padding(.top, 25)
            TextFactory.text(type: .regular(text: Localize.enterPassDetail, font: .reg14, color: .seccondary, line: 3)).padding(.trailing, 40).lineSpacing(6)
                .padding(.top, 10)
          
            TextFieldFactory.textField(type: .phone9(title: Localize.telephone, number: $phone, isValid: $validPhone)).padding(.top, 60)
            Spacer()
            ButtonFactory.button(type: .primery(text: Localize.verify, isActive: $validPhone, onClick: clickVerify))
        
        }.padding([.horizontal,.bottom],16)
    }
    
    func clickVerify(){
        if validPhone{
            let reqBody = ForgetPasswordModel.Request.Password(login: "998\(self.phone)", login_type: CompMethod.PHONE)
            
            self.viewModel.resetPassword(reqBody: reqBody) {
                self.coordinator.navigate(type: .auth(.forgetPasswordOTP(phone: "+998 \(self.phone.reformatAsPhone9())")))
            }
        }
    }
}
