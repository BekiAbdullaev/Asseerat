//
//  ProfileView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var userName:String = "Unknown"
    @State private var login:String = "unknown@example.com"
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @State var notificationState:Bool = false
    @State private var refreshID = UUID()
    
    var body: some View {
        VStack{
            self.bodyView()
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.profile)
            .id(refreshID)
            .onReceive(NotificationCenter.default.publisher(for: .updateLanguage)) { _ in
                refreshID = UUID()
            }
            .onDidLoad {
                let info = MainBean.shared.userInfo
                if info != nil {
                    userName = "\(info?.name ?? "") \(info?.surname ?? "")"
                    if info?.login_type == CompMethod.PHONE {
                        let phone = info?.phone ?? ""
                        login = "+998 \(String(phone.dropFirst(3)).reformatAsPhone9())"
                    } else {
                        login = info?.email ?? ""
                    }
                }
            }
    }
    
    
    //@ViewBuilder
    private func bodyView() -> some View {
        VStack(spacing:10){
            ScrollView(.vertical, showsIndicators: false){
                ProfileUserView(title: userName, subtitle: login,) {
                    self.coordinator.navigate(type: .other(.editProfile))
                }
                ProfileItemView(icon: "ic_ball", title: Localize.notification, hasSwich: true, togleState: $notificationState)
                ProfileItemView(icon: "ic_globus", title: Localize.lang) {
                    self.coordinator.navigate(type: .other(.lang))
                }
                ProfileItemView(icon: "ic_theme", title: Localize.theme) {
                    self.coordinator.navigate(type: .other(.theme))
                }
                ProfileItemView(icon: "ic_privacy", title: Localize.security) {
                    self.coordinator.navigate(type: .other(.security))
                }
                ProfileItemView(icon: "ic_help", title: Localize.help)
               
            }.padding(.top,16)
            Spacer()
            ProfileItemView(icon: "ic_logout", title: Localize.logOut, onClick: {
                infoActionAlert(title: Localize.logOut, subtitle: Localize.logOutDetail, lBtn: Localize.back, rBtn: Localize.yes) {
                    UDManager.shared.clear()
                    self.coordinator.popToRoot()
                }
            }).padding(.bottom,16)
        }
    }
}

#Preview {
    ProfileView()
}
