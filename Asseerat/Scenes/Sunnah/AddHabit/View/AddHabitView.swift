//
//  AddHabitView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 12/07/25.
//

import SwiftUI

struct AddHabitView: View {
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    private let viewModel = AddHabitViewModel()
    private var isActiveBtn:Bool {
        return checkEmptyField()
    }
    @State private var navTitle:String = ""
    
    private var tempItem:AddHabitModel.SunnahTemplatesRows?
    private var editItem:SunnahModel.GetClientHabitsRows?
    private var sunnahList: [SunnahTypeRows]?
   
    // Input views
    @State var habitName = String()
    @State var habitNameImage = String()
    @State var needHabitNameImage: Bool = false
    @State var habitDescription = String()
    
    @State var habitType = Int()
    @State var habitTypeName = String()
    @State var needHabitType: Bool = false
    
    @State var habitFrequency = String()
    @State var habitFrequencyValue = [Int]()
    @State var needHabitHowOften: Bool = false
    
    @State var showRemindMe: Bool = false
    @State var habitRemindMe = String()
    @State var needHabitRemindMe: Bool = false
    @State var habitCount:Int = 1
    
    
    init(tempItem: AddHabitModel.SunnahTemplatesRows? = nil, editItem:SunnahModel.GetClientHabitsRows? = nil, sunnahList:[SunnahTypeRows]? = nil) {
        self.tempItem = tempItem
        self.editItem = editItem
        self.sunnahList = sunnahList
    }
    
    var body: some View {
        VStack(spacing:16){
            ScrollView(.vertical, showsIndicators: false){
                nameHabit
                descriptionHabit
                listHabit
                howOftenHabit
                remindMeHabit
                goalCountHabit
                addHabitButton
            }.padding(.horizontal,16)
        }.background(Colors.background)
            .navigationTitle(navTitle)
            .navigationBarHidden(false)
            .onTapGesture {keyboardEndEditing()}
            .onAppear{ self.setInitItems() }
            .presentModal(displayPanModal: $needHabitNameImage) {
                HabitIconSelectionView(selectedIcon: habitNameImage) { icon in
                    habitNameImage = icon
                }
            }
            .presentModal(displayPanModal: $needHabitType) {
                HabitListSelectionView(listId: habitType, vm: self.viewModel) { id in
                    habitType = id
                    self.habitTypeName = self.viewModel.getHabitTypeNameById(id: id)
                }
            }
            .presentModal(displayPanModal: $needHabitHowOften, viewHeight: 0.9) {
                HabitHowOftenView(frequency: habitFrequency,frequencyValue: habitFrequencyValue) { freq, freqValue in
                    self.habitFrequency = freq
                    self.habitFrequencyValue = freqValue
                }
            }
            .presentModal(displayPanModal: $needHabitRemindMe) {
                HabitRemindMeView { time in
                    habitRemindMe = time
                }
            }
    }
    
    
    private func setInitItems() {
        
        let habitTypes = self.sunnahList?.filter({$0.id != 0}) ?? []
        self.viewModel.habitListTypes = habitTypes
        
        if let item = self.editItem {
            navTitle = Localize.editSunnah
            self.habitType = item.type?.id ?? 0
            self.habitTypeName = item.type?.name_en ?? ""
            self.habitName = item.name ?? ""
            self.habitNameImage = item.icon_name ?? "ic_target"
            self.habitDescription = item.description_uz ?? ""
            self.habitFrequency = item.frequency_type ?? ""
            self.habitFrequencyValue = item.frequency_value ?? []
            self.habitCount = item.required_count ?? 0
            self.showRemindMe = item.alert_state != "P"
            self.habitRemindMe = item.alert_time ?? MainBean.shared.getCurrentTime()
            
        } else if let item = self.tempItem {
            navTitle = Localize.addSunnah
        
            self.habitType = habitTypes.first?.id ?? 0
            self.habitTypeName = habitTypes.first?.name_en ?? ""
            self.habitName = item.name_en ?? ""
            self.habitNameImage = item.icon_name ?? "ic_target"
            self.habitDescription = item.description_en ?? ""
            self.habitFrequency = item.frequency_type ?? ""
            self.habitFrequencyValue = item.frequency_value ?? []
            self.habitCount = item.required_count ?? 0
            self.showRemindMe = item.alert_state != "P"
            self.habitRemindMe = item.alert_time ?? MainBean.shared.getCurrentTime()
        } else {
            navTitle = Localize.addSunnah
            self.habitType = habitTypes.first?.id ?? 0
            self.habitTypeName = habitTypes.first?.name_en ?? ""
            self.habitNameImage = "ic_target"
            self.habitCount = 1
            self.habitFrequency = self.viewModel.habitFrequencyList.first ?? ""
            self.habitFrequencyValue = []
            self.habitRemindMe = MainBean.shared.getCurrentTime()
        }
    }
}

extension AddHabitView {
    private var nameHabit: some View {
        VStack(alignment: .leading, spacing: 6){
            TextFactory.text(type: .regular(text: Localize.name, font: .reg14))
            HStack(alignment:.center) {
                TextFieldFactory.textField(type: .defaultTF(title: Localize.egMorningMeditator,  text: $habitName))
                ZStack {
                    Image(habitNameImage)
                        .resizable()
                        .frame(width: 22, height: 22)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Colors.inputBackground)
                                .stroke( Colors.inputStroke, lineWidth: 1)
                                .frame(width: 50, height: 50)
                        ).padding(.trailing, 1)
                }.frame(width: 50, height: 50)
                    .onTapGesture {
                        self.needHabitNameImage.toggle()
                    }
            }
        }.padding(.top, 16)
    }
    
    private var descriptionHabit: some View {
        VStack(alignment: .leading, spacing: 6){
            TextFactory.text(type: .regular(text: Localize.description, font: .reg14))
            TextFieldFactory.textField(type: .defaultTF(title: Localize.description,  text: $habitDescription))
        }.padding(.top, 16)
    }
    
    private var listHabit: some View {
        VStack(alignment: .leading, spacing: 6){
            TextFactory.text(type: .regular(text: Localize.list, font: .reg14))
            Spacer()
            ZStack {
                HStack(alignment:.center){
                    TextFactory.text(type: .regular(text: self.habitTypeName, font: .reg16)).padding(.leading, 16)
                    Spacer()
                    Image("ic_white_row")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 10)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Colors.inputBackground)
                        .stroke( Colors.inputStroke, lineWidth: 1)
                        .frame(height: 50)
                )
            }.padding(.horizontal,1)
                .onTapGesture {self.needHabitType.toggle()}
        }.padding(.top, 16)
    }
    
    private var howOftenHabit: some View {
        VStack(alignment: .leading, spacing: 6){
            TextFactory.text(type: .regular(text: Localize.howOften, font: .reg14))
            Spacer()
            ZStack {
                HStack(alignment:.center){
                    TextFactory.text(type: .regular(text: MainBean.shared.getHabitType(type: self.habitFrequency), font: .reg16)).padding(.leading, 16)
                    Spacer()
                    Image("ic_white_row")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 10)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Colors.inputBackground)
                        .stroke( Colors.inputStroke, lineWidth: 1)
                        .frame(height: 50)
                )
            }.padding(.horizontal,1)
                .onTapGesture {self.needHabitHowOften.toggle()}
        }.padding(.top, 24)
    }
    
    private var remindMeHabit: some View {
        VStack(alignment: .leading, spacing: 6){
            HStack(alignment:.center){
                TextFactory.text(type: .regular(text: Localize.remindMe, font: .reg16))
                Spacer()
                Toggle("", isOn: $showRemindMe)
                    .frame(width: 46, height: 28)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                    .tint(.white)
                    .padding(.trailing, 16)
            }.padding(.bottom, 10)
            if showRemindMe {
                Spacer()
                ZStack {
                    HStack(alignment:.center){
                        TextFactory.text(type: .regular(text: habitRemindMe, font: .reg16)).padding(.leading, 16)
                        Spacer()
                        Image("ic_white_row")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 10)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Colors.inputBackground)
                            .stroke( Colors.inputStroke, lineWidth: 1)
                            .frame(height: 50)
                    )
                }.padding(.horizontal,1)
                    .onTapGesture {self.needHabitRemindMe.toggle()}
            }
            
        }.padding(.top, 24)
    }
    
    private var goalCountHabit: some View {
        VStack(alignment: .leading, spacing: 6){
            TextFactory.text(type: .regular(text: Localize.myDailyCount, font: .reg14))
            Spacer()
            ZStack {
                HStack(alignment:.center){
                    TextFactory.text(type: .regular(text: "\(habitCount)", font: .reg16)).padding(.leading,16)
                      
                    Spacer()
                    
                    HStack(alignment:.center, spacing: 1){
                        Button {
                            if habitCount == 1 {
                                habitCount = 1
                            } else {
                                habitCount -= 1
                            }
                        } label: { TextFactory.text(type: .regular(text: "-", font: .reg24))}
                            .frame(width: 60, height: 35).padding(.bottom, 4)
                        Rectangle()
                            .fill(Colors.inputStroke)
                            .frame(width: 1, height: 27)
                        Button {
                            habitCount += 1
                        } label: { TextFactory.text(type: .regular(text: "+", font: .reg24))}
                            .frame(width: 60, height: 35).padding(.bottom, 4)
                    }.background(
                        RoundedRectangle(cornerRadius: 17.5, style: .continuous)
                            .fill(Colors.background)
                            .frame(height: 35)
                    ).padding(.trailing,14)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Colors.inputBackground)
                        .stroke( Colors.inputStroke, lineWidth: 1)
                        .frame(height: 50)
                )
            }.padding(.horizontal,1)
                .onTapGesture {}
        }.padding(.top, showRemindMe ? 24 : 1)
    }
    
    private var addHabitButton: some View {
        
        
        
        ButtonFactory.button(type: .primery(text: navTitle, isActive: MainBean.shared.changeToBindingBool(bool: isActiveBtn), onClick: {
            if MainBean.shared.userSignedIn() {
                addHabit()
            } else {
                showTopAlert(title: Localize.registerRequiredSubtitle, status: .warning)
            }
        })).padding(.vertical,24)
    }
    
    private func addHabit() {
        let freqValue = habitFrequencyValue.isEmpty ? nil : habitFrequencyValue
        if let item = self.editItem {
            
            let editBody = EditHabitModel.Request.EditHabit(
                id: item.id ?? 0,
                orderId: item.order_id ?? 0,
                state: item.state ?? "A",
                name: habitName,
                description_uz: habitDescription,
                frequency_type: habitFrequency,
                client_id: SecurityBean.shared.userId,
                frequency_value: freqValue,
                required_count: habitCount,
                alert_state: showRemindMe ? "A" : "P",
                alert_time: habitRemindMe,
                icon_name: habitNameImage,
                type_id: habitType)
            
            self.viewModel.editHabit(reqBody: editBody) {
                showTopAlert(title:Localize.successefullyEdited, status: .success)
                NotificationCenter.default.post(name: .updateHabitList, object: nil)
                self.coordinator.pop()
            }
            
            
        } else {
            let addBody = AddHabitModel.Request.Add(
                name: habitName,
                description_uz: habitDescription,
                frequency_type: habitFrequency,
                client_id: SecurityBean.shared.userId,
                frequency_value: freqValue,
                required_count: habitCount,
                alert_state: showRemindMe ? "A" : "P",
                alert_time: habitRemindMe,
                icon_name: habitNameImage,
                type_id: habitType)
            
            self.viewModel.addSunnah(reqBody: addBody) {
                showTopAlert(title:Localize.successefullyAdded, status: .success)
                NotificationCenter.default.post(name: .updateHabitList, object: nil)
                self.coordinator.pop()
            }
        }
    }
    
    
    private func checkEmptyField() -> Bool {
        return habitName.isNotEmpty && habitDescription.isNotEmpty
    }
}
