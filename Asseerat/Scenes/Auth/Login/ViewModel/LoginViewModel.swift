//
//  LoginViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 15/06/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    func postSignIn(reqBody:LoginModel.Request.SignIn, isLaunch:Bool = false, onComplete:@escaping(()->()), onError:@escaping(()->()) = {}) {
        NetworkManager(hudType: isLaunch ? .noHud : .authorized).request(AuthAPI.login(body: reqBody)) { (response:SignUpModel.SignInUpResponse) in
            SecurityBean.shared.token = response.token ?? ""
            SecurityBean.shared.userId = response.client_id ?? ""
            MainBean.shared.userInfo = UserInfo(login: response.user?.login ?? "", name: response.user?.name ?? "", surname: response.user?.surname ?? "", phone: response.user?.phone ?? "", email: response.user?.email ?? "", state: response.user?.state ?? "", sex: response.user?.sex ?? "", birthday: response.user?.birthday ?? "", login_type: response.user?.login_type ?? "")
            onComplete()
        } failure: { error in
            if isLaunch {
                onError()
            } else {
                showTopAlert(title: error?.reason ?? "Something wrong...")
            }
        }
    }
        
    func checkVersion(onComplete:@escaping((String, String)->())) {
        let appVersion:Int = Int(NetworkParamsHelper.shared.getNetworkParams().appVersion) ?? 0
        let dbVersion = MainBean.shared.getDBVersion()
        
    
        let versionRequest = LoginModel.Request.VersionCheck(app_version: appVersion, device_type: "I", db_version: dbVersion)
        NetworkManager(hudType: .noHud).request(AuthAPI.chackVersion(body: versionRequest)) { (response:LoginModel.Response.VersionCheckResponse) in
            onComplete(response.db_update ?? "", response.app_update ?? "")
        } failure: { error in
            onComplete("","")
        }
    }
    
    func postRegistration(reqBody:SignUpModel.Request.Registration, onComplete:@escaping((SignUpModel.SignInUpResponse)->()), onError:@escaping(()->()) = {}) {
        
        NetworkManager(hudType: .authorized).request(AuthAPI.registration(body: reqBody)) { (response:SignUpModel.SignInUpResponse) in
            onComplete(response)
        } failure: { error in
            if error?.reason == "User already exists" {
                onError()
            } else {
                showTopAlert(title: error?.reason ?? "Something wrong...")
            }
        }
    }
}
