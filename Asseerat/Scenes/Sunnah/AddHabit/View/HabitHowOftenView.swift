//
//  HabitHowOftenView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 09/08/25.
//

import SwiftUI

struct HabitHowOftenView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel = AddHabitViewModel()
    private var onClick:(String, [Int]) -> Void
    @State private var frequency: String? = nil{
        didSet {
            self.setFrequency(type: frequency)
        }
    }
    @State private var frequencyValueName: String = ""
    @State private var frequencyValues: [Int]? = nil{
        didSet {
            self.setFrequencyValue(values: frequencyValues)
        }
    }
    @State private var periodIndex:Int = 0
    @State private var needWeekDays:Bool = false
    @State private var needSaveGoals: Bool = true
    
    init(frequency:String? = nil, frequencyValue:[Int]? = nil, onClick: @escaping (String, [Int]) -> Void){
        self.frequency = frequency
        self.frequencyValues = frequencyValue
        self.onClick = onClick
    }
    
    var body: some View {
        VStack {
            self.navigationView()
            self.periodView()
            self.repeatView()
            if needWeekDays {
                self.selectWeekDays()
            }
            Spacer()
            self.saveGoals()
        }.background(Colors.background)
            .onDidLoad {
                setFrequency(type: self.frequency)
            }
    }
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            TextFactory.text(type: .regular(text: Localize.howOften, font: .reg20))
            
            HStack(alignment:.center, spacing:10){
                ButtonFactory.button(type: .roundedWhite(image: "ic_gray_cancel", onClick: {
                    self.presentationMode.wrappedValue.dismiss()
                })).padding(.leading, 14)
                Spacer()
            }
        }.frame(height: 42).frame(maxWidth:.infinity).padding(.top,16).padding(.bottom, 16)
    }
    
    @ViewBuilder
    private func periodView() -> some View {
        VStack(alignment: .leading){
            TextFactory.text(type: .regular(text: Localize.period.uppercased(), font: .reg14, color: .seccondary))
                .padding([.leading, .top], 16)
            LazyVGrid(columns: viewModel.listGridColumns, spacing: 12) {
                ForEach(viewModel.habitFrequencyList, id: \.self) { type in
                    HabitListSelectionItem(title: MainBean.shared.getHabitType(type: type), isSelected: frequency == type, isLast: checkIsLastFrequency(type: type), action: {frequency = type})
                }
            }
        }
    }
    
    @ViewBuilder
    private func repeatView() -> some View {
        VStack(alignment: .leading){
            TextFactory.text(type: .regular(text: Localize.repeats.uppercased(), font: .reg14, color: .seccondary))
                .padding(.leading, 16).padding(.top,45)
            LazyVGrid(columns: viewModel.listGridColumns, spacing: 12) {
                ForEach(viewModel.habitFrequencyValueList[periodIndex], id: \.self) { name in
                    HabitHowOftenRepeatItem(title: name, isSelected: frequencyValueName == name, isLast: checkIsLastFrequencyValue(type: name), action: {
                        frequencyValueName = name
                        if frequency == "D" {
                            self.needWeekDays = name != self.viewModel.habitFrequencyValueList.first?.first
                        }
                    })
                }
            }
        }
    }
    
    @ViewBuilder
    private func selectWeekDays() -> some View {
        HStack {
            ForEach(["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"], id: \.self) { day in
                Button(action: {
                    if viewModel.habitSelectionWeekDays.contains(day) {
                        viewModel.habitSelectionWeekDays.removeAll { $0 == day }
                    } else {
                        viewModel.habitSelectionWeekDays.append(day)
                    }
                }) {
                    VStack(spacing:4) {
                        Image(viewModel.habitSelectionWeekDays.contains(day) ? "ic_cercle_select" : "ic_cercle_unselect")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 34, height: 34)
                        TextFactory.text(type: .regular(text: day, font: .reg12))
                    }.padding([.horizontal, .top], 5)
                }
            }
        }
    }
    
    @ViewBuilder
    private func saveGoals() -> some View {
        VStack(alignment: .leading){
            ButtonFactory.button(type: .primery(text: Localize.saveGoals, isActive: $needSaveGoals, onClick: {
                var freqValue = [Int]()
                if self.needWeekDays {
                    freqValue = convertWeekToDigit(self.viewModel.habitSelectionWeekDays)
                }
                self.onClick(frequency ?? "", freqValue)
                self.presentationMode.wrappedValue.dismiss()
            })).padding()
        }
    }
    
    private func setFrequency(type:String?) {
        if let type = type {
            
            if let index = self.viewModel.habitFrequencyList.firstIndex(where: {$0 == type}) {
                self.periodIndex = index
                var innerIndex = 0
                if !(self.frequencyValues?.isEmpty ?? false) {
                    setFrequencyValue(values: self.frequencyValues)
                    innerIndex = 1
                    self.needWeekDays = type == "D"
                }
                self.frequencyValueName = viewModel.habitFrequencyValueList[index][type == "D" ? innerIndex : 0]
            }
        }
    }
    
    private func setFrequencyValue(values:[Int]?) {
        if let values = values {
            self.needWeekDays = !values.isEmpty
            self.viewModel.habitSelectionWeekDays = convertWeekToDays(days: values)
        }
    }

    func convertWeekToDays(days:[Int]) -> [String] {
        let weekSymbols = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
        return days.compactMap { day in
            guard (1...7).contains(day) else { return nil }
            return weekSymbols[day - 1]
        }
    }
    
    func convertWeekToDigit(_ letters: [String]) -> [Int] {
        let weekSymbols = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
        let days = letters.compactMap { weekSymbols.firstIndex(of: $0).map { $0 + 1 } }
        return days.sorted()
    }
    
    private func checkIsLastFrequency(type:String) -> Bool {
        return viewModel.habitFrequencyList.last == type
    }
    
    private func checkIsLastFrequencyValue(type:String) -> Bool {
        return viewModel.habitFrequencyValueList[periodIndex].last == type
    }
}


struct HabitHowOftenRepeatItem: View {
    let title: String
    let isSelected: Bool
    let isLast: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Colors.background
            VStack {
                HStack(alignment:.center) {
                    TextFactory.text(type: .regular(text: title, font: .reg16)).padding(.leading,20)
                    Spacer()
                    
                    Image(isSelected ? "ic_check" : "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 22, height: 22)
                        .padding(.trailing,20)

                }.frame(height: 40).frame(maxWidth: .infinity)
                if !isLast {
                    Divider().background(Colors.seccondary).padding(.horizontal,16)
                }
            }
        }
        .onTapGesture { action()}
    }
}
