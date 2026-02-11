//
//  ResetPasswordView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/06/25.
//

import SwiftUI

enum PasswordType {
    case ressetPassword(smsCode:String, phone:String)
    case setPassword(name:String, lastname:String, sex:String, phone:String, birthdate:String)
}

struct ResetPasswordView: View {
    
    @State private var passTitle = ""
    @State private var passSubTitle = ""
    @State private var passButton = ""
    
    @State private var password1 = ""
    @State var validPassword1:Bool = false
    @State var passwordValidationString = Localize.passwordValidationString
    @State private var password2 = ""
    @State var validPassword2:Bool = false
    
    private var isActiveReset:Bool {
        return validPassword1 && validPassword2 && (password1 == password2)
    }
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = SignUpViewModel()
    @ObservedObject private var vmForgetPassword = ForgetPasswordViewModel()
    private var passwordType: PasswordType
    
    init(type:PasswordType) {
        self.passwordType = type
    }
    
    var body: some View {
        VStack {
            self.bodyView()
        }.background(Colors.background)
            .navigationBarHidden(false)
            .onTapGesture { keyboardEndEditing() }
            .onAppear {
                setInitItem()
            }
    }
    
    @ViewBuilder
    private func bodyView() -> some View {
        VStack(alignment:.leading, spacing: 16) {
            TextFactory.text(type: .medium(text: passTitle, font: .med28, line: 1))
                .padding(.top, 25)
            TextFactory.text(type: .regular(text: passSubTitle, font: .reg14, color: .seccondary, line: 3)).padding(.trailing, 40).lineSpacing(6).padding(.top, 10)
            
            TextFieldFactory.textField(type: .password(title: Localize.createPassword, text: $password1, isValid: $validPassword1, passwordValidationString: $passwordValidationString)).padding(.top, 60)
            
            TextFieldFactory.textField(type: .password(title: Localize.confirmPassword, text: $password2, isValid: $validPassword2, passwordValidationString: $passwordValidationString)).padding(.top, 16)
            
            Spacer()
            ButtonFactory.button(type: .primery(text: passButton, isActive: MainBean.shared.changeToBindingBool(bool: isActiveReset), onClick: setPassword))
        
        }.padding([.horizontal,.bottom],16)
    }
    
    func setInitItem() {
        switch passwordType {
        case .ressetPassword:
            self.passTitle = Localize.resetPassword
            self.passSubTitle = Localize.resetPasswordDetail
            self.passButton = Localize.resetPassword
        case .setPassword(_,_,_,let phone,_):
            self.passTitle = Localize.setPassword
            self.passSubTitle = Localize.setPasswordDetail
            self.passButton = Localize.setPassword
        }
    }
    
    func setPassword(){
        switch passwordType {
        case .ressetPassword(let smscode, let phone):
           
            let reqBody = ForgetPasswordModel.Request.PasswordVerify(login: phone.removePlus().removeSpaces(), login_type: CompMethod.PHONE, new_password: password1, sms_code: smscode)

            self.vmForgetPassword.resetPasswordVerify(reqBody: reqBody) { result in
                if result.code == 0 {
                    showTopAlert(title: result.msg ?? "", status: .success)
                    self.coordinator.popToRoot()
                }
            }
            
            
        case .setPassword(let name, let lastname, let sex, let phone, let birthdate):
            let loginType = CompMethod.PHONE
            let netParams = NetworkParamsHelper.shared.getNetworkParams()
            let password = password1
            
            let reqBody = SignUpModel.Request.Registration(login: phone,
                                                           password: password,
                                                           name: name,
                                                           surname: lastname,
                                                           phone: phone,
                                                           email: "",
                                                           sex: sex,
                                                           birthday: birthdate,
                                                           ip: NetworkParamsHelper.shared.getIpAddress(),
                                                           login_type: loginType,
                                                           device_type: netParams.device_type,
                                                           device_code: SecurityBean.shared.getDeviceID(),
                                                           device_name: netParams.deviceName,
                                                           app_version: 1)
            
            self.viewModel.postRegistration(reqBody: reqBody) { response in
                
                SecurityBean.shared.token = response.token ?? ""
                SecurityBean.shared.userId = response.client_id ?? ""
                MainBean.shared.userInfo = UserInfo(login: response.user?.login ?? "", name: response.user?.name ?? "", surname: response.user?.surname ?? "", phone: response.user?.phone ?? "", email: response.user?.email ?? "", state: response.user?.state ?? "", sex: response.user?.sex ?? "", birthday: response.user?.birthday ?? "", login_type: response.user?.login_type ?? "")
                
                UDManager.shared.setSting(key: .userLogin, object: phone)
                UDManager.shared.setSting(key: .userPassword, object: password)
                UDManager.shared.setSting(key: .userLoginType, object: loginType)
                
                showTopAlert(title: response.msg ?? "", status: .success)
                self.coordinator.navigate(type: .auth(.tabView))
            }
        }
    }
}
