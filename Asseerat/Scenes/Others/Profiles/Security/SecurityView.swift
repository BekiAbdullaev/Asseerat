//
//  SecurityView.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 07/09/25.
//

import SwiftUI

struct SecurityView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
   
    var body: some View {
        VStack(spacing:16){
            ScrollView(.vertical, showsIndicators: false){
                self.securityItems(title: Localize.changePassword)
                    .onTapGesture {
                        self.coordinator.navigate(type: .auth(.forgetPassword(passInitType: .changePassw)))
                    }
                self.securityItems(title: Localize.myDevices).padding(.top,4)
                    .onTapGesture {
                        self.coordinator.navigate(type: .other(.myDevices))
                    }
            }.padding(.top,16)
        
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.security)
    }
    
    @ViewBuilder
    func securityItems(title:String) -> some View {
        ZStack {
            Colors.green
            HStack(alignment:.center, spacing: 18){
                TextFactory.text(type: .regular(text: title, font: .sem16, line: 1)).padding(.leading,16)
                Spacer()
                Image("ic_white_row")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(.trailing,16)
            }
        }.frame(maxWidth:.infinity).frame(height: 54)
            .cornerRadius(15, corners: .allCorners)
            .padding(.horizontal)
    }
}



