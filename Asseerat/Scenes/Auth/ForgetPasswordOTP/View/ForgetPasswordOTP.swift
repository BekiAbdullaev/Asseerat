//
//  ForgetPasswordOTP.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/06/25.
//

import SwiftUI

struct ForgetPasswordOTP: View {
    
    @State private var otp = ""
    @State var validOTP:Bool = false
    @State private var isActiveConfirm = false
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    private var phone:String
    
    @State private var timeRemaining = 60
    @State private var timer: Timer?
    @State private var isRunning = false
    @State private var needResent = false
    
    init(phone: String) {
        self.phone = phone
    }
   
    var body: some View {
        VStack {
            self.bodyView()
        }.background(Colors.background)
            .navigationBarHidden(false)
            .onTapGesture { keyboardEndEditing()}
            .onDidLoad {
                startTimer()
            }
    }
    
    @ViewBuilder
    private func bodyView() -> some View {
        VStack(alignment:.leading, spacing: 16) {
            TextFactory.text(type: .medium(text: Localize.enterOTPCode, font: .med28, line: 1)).padding(.top, 25)
            TextFactory.text(type: .regular(text: Localize.enterOTPCodeDetail, font: .reg14, color: .seccondary, line: 3))
                .padding(.trailing, 40).lineSpacing(6)
            
          
            TextFieldFactory.textField(type: .sms(code: $otp, isValid: $validOTP)).padding(.top, 60)
            Spacer()
            HStack(alignment:.center){
                ButtonFactory.button(type: .bordered(text: formattedTime(), onClick: clickSentNew))
                    .frame(width: UIScreen.main.bounds.width * 0.3)
                ButtonFactory.button(type: .primery(text: Localize.confirm, isActive: $validOTP, onClick: clickConfirm))
            }
        }.padding([.horizontal,.bottom],16)
    }
    
    func clickConfirm(){
        if otp.isNotEmpty {
            self.coordinator.navigate(type: .auth(.setPassword(type: .ressetPassword(smsCode: otp, phone: self.phone))))
        }
    }
    
    func clickSentNew(){
        if needResent {
            timeRemaining = 60
            startTimer()
            needResent = false
            otp = ""
        }
    }
    
    private func formattedTime() -> String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        let time = String(format: "%01d:%02d", minutes, seconds)
        return time == "0:00" ? Localize.sentNew : time
    }

    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                needResent = true
                stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
}
