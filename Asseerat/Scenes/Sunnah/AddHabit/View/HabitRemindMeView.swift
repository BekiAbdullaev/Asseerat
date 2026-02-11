//
//  HabitRemindMeView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 09/08/25.
//

import SwiftUI

struct HabitRemindMeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedTime = Date()
    @State var needSaveTime: Bool = true
    private var onClick:(String) -> Void
    
    init(onClick: @escaping (String) -> Void){
        self.onClick = onClick
    }
    var body: some View {
        VStack {
            self.navigationView()
            DatePicker(Localize.selectTime,selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel) // Use wheel style for a time picker look
                .labelsHidden() // Optional
                .colorInvert()
                .colorMultiply(Colors.white)
                .frame(height:180)
            Spacer()
            ButtonFactory.button(type: .primery(text: Localize.saveTime, isActive: $needSaveTime, onClick: {
                self.onClick(formattedTime)
                self.presentationMode.wrappedValue.dismiss()
            })).padding()
        }.background(Colors.background)
    }
    
    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: selectedTime)
    }
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            TextFactory.text(type: .regular(text: Localize.setYourDailyReminder, font: .reg20))
            
            HStack(alignment:.center, spacing:10){
                ButtonFactory.button(type: .roundedWhite(image: "ic_gray_cancel", onClick: {
                    self.presentationMode.wrappedValue.dismiss()
                })).padding(.leading, 14)
                Spacer()
            }
        }.frame(height: 42).frame(maxWidth:.infinity).padding(.top,16)
    }
}
