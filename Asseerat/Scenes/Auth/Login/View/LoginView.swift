//
//  LoginView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 15/06/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var phone = ""
    @State private var password = ""
    @State var passwordValidationString = Localize.passwordValidationString
    @State var validPhone:Bool = false
    @State var validPassword:Bool = false
    
    private var isActiveBtn:Bool {
        return validPhone && validPassword
    }
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = LoginViewModel()
    @StateObject private var authManager = AuthManager()
    
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
            .onDidLoad {
                UDManager.shared.setBool(key: .isLaunched, object: true)
                
            }
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
            TextFactory.text(type: .medium(text: Localize.logIn, font: .med28, line: 1)).padding(.top, 16)
            TextFactory.text(type: .regular(text: Localize.loginDetail, font: .reg14, color: .seccondary, line: 3))
                .padding(.trailing, 40).padding(.top, 10).lineSpacing(6)
            
            TextFieldFactory.textField(type: .phone9(title: Localize.telephone, number: $phone, isValid: $validPhone)).padding(.top, 60)
            TextFieldFactory.textField(type: .password(title: Localize.password, text: $password, isValid: $validPassword, passwordValidationString: $passwordValidationString)).padding(.top, 8)
            ButtonFactory.button(type: .primery(text: Localize.login, isActive: MainBean.shared.changeToBindingBool(bool: isActiveBtn), onClick: clicklogin))
                .padding(.top, 16)
            HStack{
                Spacer()
                TextFactory.text(type: .medium(text:Localize.forgetPassword, font: .med16, line: 1)).onTapGesture {
                    clickForgetPassword()
                }
                Spacer()
            }.padding(.top,16)
            Divider().background(Colors.seccondary).padding(.vertical)
            
            TextFactory.text(type: .regular(text: Localize.loginWith, font: .reg14, color: .seccondary, line: 1))
                .frame(maxWidth:.infinity)
            
            HStack(spacing:10){
                ButtonFactory.button(type: .bordered(image: "ic_gmail", onClick: clickGmail))
                ButtonFactory.button(type: .bordered(image: "ic_apple", onClick: clickApple))
            }.padding(.vertical,20)
            
            Divider().background(Colors.seccondary).padding(.top,16)
            
            ButtonFactory.button(type: .textBtn(text: Localize.dontHaveAccount, btnText: Localize.signUp, onClick: clickSignUp )).padding(.bottom, 16)
        }.padding(.horizontal,16)
    }
    
    
    func clickSkip() {
        self.coordinator.navigate(type: .auth(.tabView))
    }
    
    func clicklogin(){
        if validPhone {
            let phone = "998\(phone)"
            let password = password
            let loginType = CompMethod.PHONE
            
            self.signIn(login: phone, password: password, loginType: loginType)
        }
    }
    
    
    private func signIn(login:String, password:String, loginType:String) {
        
        let reqBody = LoginModel.Request.SignIn(login: login, password: password, login_type:loginType)
        
        self.viewModel.postSignIn(reqBody: reqBody) {
            
            UDManager.shared.setSting(key: .userLogin, object: login)
            UDManager.shared.setSting(key: .userPassword, object: password)
            UDManager.shared.setSting(key: .userLoginType, object: loginType)
            self.coordinator.navigate(type: .auth(.tabView))
        }
    }
    
    func clickForgetPassword() {
        self.coordinator.navigate(type: .auth(.forgetPassword(passInitType: .forgetPassword)))
    }
    func clickGmail() {
        let vc = topMostController()
        authManager.signInWithGoogle(presenting: vc) { result in
            switch result {
            case .success(let gmail):
                print("Google sign in ID:", gmail.uid)
                print("Google sign in email:", gmail.email ?? "")
                print("Google sign in displayName:", gmail.displayName ?? "")
                
                signUpWithEmail(userName: gmail.displayName, email: gmail.email, password: gmail.uid)
                
            case .failure(let error):
                print("Google sign in error:", error.localizedDescription)
            }
        }
    }
    
    func clickApple(){
        authManager.signInWithApple { result in
            switch result {
            case .success(let apple):
                
                print("Apple sign in ID:", apple.uid)
                print("Apple sign in email:", apple.email ?? "")
                print("Apple sign in displayName:", apple.providerData.first?.displayName ?? "")
                
                signUpWithEmail(userName: apple.providerData.first?.displayName, email: apple.email, password: apple.uid)
            case .failure(let failure):
                print("Apple sign in error:", failure.localizedDescription)
            }
        }
    }
    
    private func signUpWithEmail(userName:String?, email:String?, password:String) {
        
        let userName = userName ?? email ?? "Unknown"
        let netParams = NetworkParamsHelper.shared.getNetworkParams()
        
        let reqBody = SignUpModel.Request.Registration(login: email ?? "",
                                                       password: password,
                                                       name: userName,
                                                       surname: "",
                                                       phone: "",
                                                       email: email ?? "",
                                                       sex: CompMethod.MALE,
                                                       birthday: "",
                                                       ip: NetworkParamsHelper.shared.getIpAddress(),
                                                       login_type: CompMethod.EMAIL,
                                                       device_type: netParams.device_type,
                                                       device_code: SecurityBean.shared.getDeviceID(),
                                                       device_name: netParams.deviceName,
                                                       app_version: 1)
        
        self.viewModel.postRegistration(reqBody: reqBody) { response in
            SecurityBean.shared.token = response.token ?? ""
            SecurityBean.shared.userId = response.client_id ?? ""
            MainBean.shared.userInfo = UserInfo(login: response.user?.login ?? "", name: response.user?.name ?? "", surname: response.user?.surname ?? "", phone: response.user?.phone ?? "", email: response.user?.email ?? "", state: response.user?.state ?? "", sex: response.user?.sex ?? "", birthday: response.user?.birthday ?? "", login_type: response.user?.login_type ?? "")
            
            UDManager.shared.setSting(key: .userLogin, object: email ?? "")
            UDManager.shared.setSting(key: .userPassword, object: password)
            UDManager.shared.setSting(key: .userLoginType, object: CompMethod.EMAIL)
            
            showTopAlert(title: response.msg ?? "", status: .success)
            self.coordinator.navigate(type: .auth(.tabView))
        } onError: {
            self.signIn(login: email ?? "", password: password, loginType: CompMethod.EMAIL)
        }
    }
    
    func clickSignUp(){
        self.coordinator.navigate(type: .auth(.signUp))
    }
}
