//
//  SunnahsView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

struct SunnahsView: View {
    
    @State var needTypeList:Bool = false
    @State var needDetail:Bool = false
    @State var needAdd:Bool = false
    @ObservedObject private var viewModel:SunnahsViewModel
    
    @State var selectedHabit:SunnahModel.GetClientHabitsRows?
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @State private var selectedListId: Int? = nil
    @State private var habitLists: [[SunnahModel.GetClientHabitsRows]] = []
    @State private var sunnahTemplates: [AddHabitModel.SunnahTemplatesRows] = []
    
    init(viewModel:SunnahsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                self.navigationView()
                if MainBean.shared.userSignedIn() {
                    if self.habitLists.isEmpty {
                        EmptyView(title: Localize.createSunnahEmpityTitle, subtitle: Localize.createSunnahEmpitySubtitle,type: .create) {
                            self.addSunnah()
                        }
                    } else {
                        ScrollView(.vertical, showsIndicators: false){
                            self.sunnahsList()
                        }
                    }
                } else {
                    EmptyView(title: Localize.registerRequiredTitle, subtitle: Localize.registerRequiredSubtitle, type: .signIn) {
                        UDManager.shared.clear()
                        self.coordinator.popToRoot()
                    }
                }
            }.background(Colors.background)
            if needTypeList {
                self.listView()
            }
        }.navigationBarHidden(true)
            .onTapGesture {
                if needTypeList {
                    needTypeList.toggle()
                }
            }
            .onDidLoad {
                if MainBean.shared.userSignedIn() {
                    self.viewModel.getSunnahTypes()
                    self.getClientSunnahs()
                    self.setNotification()
                }
            }
            .presentModal(displayPanModal: $needAdd, viewHeight: 0.55){
                HabitTemplateView (sunnahTemplates: sunnahTemplates) { template in
                    self.coordinator.navigate(type: .sunnah(.newHabit(item: template, types: self.viewModel.sunnahList)))
                }
            }
            .presentModal(displayPanModal: $needDetail, viewHeight: 0.55) {
                self.openSunnahDetail()
            }
    }
    
    private func getClientSunnahs() {
        self.viewModel.getClientHabits { habits in
            self.habitLists = habits
            self.viewModel.setInitProgress()
        }
    }
    
    
    private func addSunnah() {
        self.viewModel.getSunnahTemplates { templates in
            if !templates.isEmpty {
                self.sunnahTemplates = templates
                self.needAdd.toggle()
            } else {
                self.coordinator.navigate(type: .sunnah(.newHabit(item: nil, types: self.viewModel.sunnahList)))
            }
        }
    }
    
    
    @ViewBuilder
    private func openSunnahDetail() -> some View {
        if let selectedHabit = self.selectedHabit {
            SunnahDetailView(item: selectedHabit, vm: self.viewModel) { type in
                
                if type == .edit {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        self.coordinator.navigate(type: .sunnah(.editHabit(item: selectedHabit, types: self.viewModel.sunnahList)))
                    }
                } else if type == .update {
                    self.getClientSunnahs()
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func sunnahsList() -> some View {
        
        VStack(spacing: 20) {
            if let dailyHabits = self.habitLists.first(where: { $0.first?.frequency_type == "D" }) {
                self.sunnahProgres(title: Localize.daily)
                self.setHabitsListItem(title:"", items: dailyHabits)
                if let weeklyHabits = self.habitLists.first(where: { $0.first?.frequency_type == "W" }) {
                    self.setHabitsListItem(title:Localize.weeklyGoals, items: weeklyHabits)
                    
                     if let monthlyHabits = self.habitLists.first(where: { $0.first?.frequency_type == "M" }) {
                         self.setHabitsListItem(title:Localize.monthlyGoals, items: monthlyHabits)
                    }
                }
                
            } else if let weeklyHabits = self.habitLists.first(where: { $0.first?.frequency_type == "W" }) {
                self.sunnahProgres(title: Localize.weeklyGoals)
                self.setHabitsListItem(title:"", items: weeklyHabits)
                if let monthlyHabits = self.habitLists.first(where: { $0.first?.frequency_type == "M" }) {
                    self.setHabitsListItem(title:Localize.monthlyGoals, items: monthlyHabits)
                }
                
            } else if let monthlyHabits = self.habitLists.first(where: { $0.first?.frequency_type == "M" }) {
                self.sunnahProgres(title: Localize.monthlyGoals)
                self.setHabitsListItem(title:"", items: monthlyHabits)
            }
        }
    }
    
    
    @ViewBuilder
    private func setHabitsListItem(title:String, items:[SunnahModel.GetClientHabitsRows]) -> some View {
        VStack(alignment: .leading){
            if title.isNotEmpty {
                TextFactory.text(type: .medium(text: title, font: .med18)).padding([.bottom, .horizontal])
            }
            ForEach(items.indices, id:\.self) { i in
                SunnahsItemView(item: items[i]).onTapGesture {
                    self.selectedHabit = items[i]
                    self.needDetail.toggle()
                }
            }
        }.padding(.bottom, 16)
    }
    
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            HStack(alignment:.center, spacing:10){
                HStack(alignment:.center, spacing:2) {
                    TextFactory.text(type: .regular(text: self.viewModel.getListNameById(id: self.selectedListId ?? 0), font: .reg16, line: 1))
                    Image("ic_bottom_row")
                        .resizable().frame(width: 18, height: 18, alignment: .center)
                        .rotationEffect(.degrees(needTypeList ? 180 : 0))
                }.padding(.vertical, 10).padding(.horizontal,14)
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                    ).foregroundColor(Colors.green).padding(.leading,16)
                    .onTapGesture {
                        self.needTypeList.toggle()
                    }
                Spacer()
                ButtonFactory.button(type: .roundedWhite(image: "ic_edit", onClick: {
                    self.coordinator.navigate(type: .sunnah(.edit(habits: self.habitLists)))
                }))
                ButtonFactory.button(type: .roundedWhite(image: "ic_analytics", onClick: {
                    self.coordinator.navigate(type: .sunnah(.analytics))
                }))
                
                ButtonFactory.button(type: .rounded(image: "ic_add", size: 42, onClick: {
                    self.addSunnah()
                })).padding(.trailing, 16)
            }
        }.frame(height: 42).frame(maxWidth:.infinity).padding(.top,8)
    }
    
    @ViewBuilder
    private func sunnahProgres(title:String) -> some View {
        VStack(alignment: .center) {
            HStack {
                TextFactory.text(type: .medium(text: title, font: .med28))
                Spacer()
            }.padding([.horizontal, .bottom])
            
            ZStack {
                Circle()
                    .stroke(Colors.green, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .frame(width: 150, height: 150)
                Circle()
                    .trim(from: 0, to: self.viewModel.progressCount)
                    .stroke(Colors.btnColor, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                
                TextFactory.text(type: .medium(text: "\(self.viewModel.progressPercent) %", font: .med28))
                    .frame(width: 135, height: 135)
                    .background(
                        Circle().fill(Colors.background)
                    )
            }.padding()
        }.padding(.vertical)
    }
}

// Sunnah Type list
extension SunnahsView {
    @ViewBuilder
    private func listView() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    self.listGridView()
                }.frame(width: 180, height: CGFloat(self.viewModel.sunnahList.count * 48))
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Colors.green)).padding(.top, 55).padding(.leading, 16)
                Spacer()
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func listGridView() -> some View {
        LazyVGrid(columns: viewModel.columns, spacing: 0) {
            ForEach(viewModel.sunnahList, id: \.self) { item in
                ListCheckBtn(title: item.name_en ?? "", isSelected: selectedListId == item.id, action: {
                    selectedListId = item.id
                    self.setListID(id: item.id)
                    self.needTypeList = false
                })
                if item != viewModel.sunnahList.last {
                    Divider().background(Colors.seccondary).padding(.horizontal, 14)
                }
           }
        }
    }
    
    private func setListID(id:Int?) {
        let filtered = self.viewModel.filterHabitsByTypeId(typeId: id ?? 0, habitLists: self.viewModel.habitList)
        self.habitLists = filtered
    }
}

extension SunnahsView {
    func setNotification() {
        NotificationCenter.default.addObserver(forName: .updateHabitList, object: nil, queue: .main) { _ in
            self.getClientSunnahs()
        }
        
        NotificationCenter.default.addObserver(forName: .updateSunnahItem, object: nil, queue: .main) { notification in
            guard let sunnah = notification.userInfo?["sunnah"] as? SunnahModel.GetClientHabitsRows else { return }
            
            self.viewModel.updateHabit(sunnah: sunnah) { sunnahs in
                self.habitLists = sunnahs
            }
        }
    }
}
