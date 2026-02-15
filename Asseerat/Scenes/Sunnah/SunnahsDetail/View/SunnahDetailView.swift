//
//  SunnahDetailView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 12/07/25.
//

import SwiftUI
import PanModal

struct SunnahDetailView: View {
    
    @State var isActiveComplete:Bool = true
    @State private var progressPercent: CGFloat = 0.0
    @State private var progressCount: Int = 0
    @State private var isTapped = false
    @State private var needSound = false
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var needUpdate:(SunnahDetailBackType) -> Void
    private var viewModel:SunnahsViewModel?
    private let item:SunnahModel.GetClientHabitsRows
    
    init(item: SunnahModel.GetClientHabitsRows, vm: SunnahsViewModel, needUpdate: @escaping (SunnahDetailBackType) -> Void) {
        self.item = item
        self.viewModel = vm
        self.needUpdate = needUpdate
    }
    
    var body: some View {
        VStack(spacing:5){
            self.header()
            self.itembody()
            Spacer()
            self.footer()
           
        }.background(Colors.background)
            .onAppear {
                if item.status == 2 {
                    self.isActiveComplete = false
                } else if (item.required_count == item.current_count) {
                    self.isActiveComplete = false
                }
                self.progressCount = item.current_count ?? 0
                self.progressPercent = CGFloat(item.current_count ?? 0) / CGFloat(item.required_count ?? 0)
            }
            .onDisappear {
                if self.progressCount != item.current_count {
                    changeCount()
                }
            }
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack(alignment: .center){
            Spacer()
            ButtonFactory.button(type: .roundedWhite(image: "ic_edit", needShedow: false, onClick: {
                self.needUpdate(.edit)
                self.presentationMode.wrappedValue.dismiss()
            }))
            
            ButtonFactory.button(type: .roundedWhite(image: "ic_white_delete", needShedow: false, onClick: {
                infoActionAlert(title: Localize.deleteHabit, subtitle: Localize.deleteHabitDetail, lBtn: Localize.back, rBtn: Localize.delete) {
                    self.viewModel?.deleteHabit(habitId: "\(item.id ?? 0)") {
                        self.needUpdate(.update)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }))
        }.padding(.horizontal,16).padding(.top, 12)
    }
    
    @ViewBuilder
    private func itembody() -> some View {
        VStack{
            TextFactory.text(type: .bold(text: item.name ?? Localize.unknown, font: .med28, color: item.status == 2  ? .seccondary : .white, line: 1)).padding(.top,5)
            TextFactory.text(type: .regular(text: "\(MainBean.shared.getHabitType(type: item.frequency_type ?? "")): \(item.required_count ?? 0)", font: .reg14, color: item.status == 2  ? .seccondary : .white))
            
            self.progres()
        }
    }
    
    @ViewBuilder
    private func footer() -> some View {
        VStack{
            PrimeryButton(btnTitle: Localize.complete, isActive: $isActiveComplete) {
                self.progressCount = self.item.required_count ?? 0
                self.changeProgress(recCount: item.required_count ?? 0, curCount: progressCount)
                self.isActiveComplete = false
                self.changeCount()
            }.padding(.horizontal, 32)
            
            TextFactory.text(type: .medium(text: item.status == 2 ? Localize.unfreeze : Localize.freeze, font: .med16, color: isActiveComplete ? .white : .seccondary)).padding(16).onTapGesture {
                if item.status == 2 {
                    self.viewModel?.unskipHabit(habitId: "\(item.id ?? 0)") {
                        self.needUpdate(.update)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    if isActiveComplete {
                        self.viewModel?.skipHabit(habitId: "\(item.id ?? 0)") {
                            self.needUpdate(.update)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func progres() -> some View {
        HStack(alignment: .center, spacing: 16) {
            
            ButtonFactory.button(type: .roundedWhite(image: "ic_decreament", onClick: {
                if item.status != 2 {
                    ImpactGenerator.panModal.generateImpact()
                    withAnimation(.easeInOut(duration: 0.4)) {
                        if progressCount > 0 {
                            self.progressCount -= 1
                            self.changeProgress(recCount: item.required_count ?? 0, curCount: progressCount)
                            self.isActiveComplete = true
                        }
                    }
                }
            }))
            
            ZStack {
                Circle()
                    .stroke(Colors.green, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .frame(width: 150, height: 150)
                Circle()
                    .trim(from: 0, to: self.progressPercent)
                    .stroke(Colors.btnColor, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                
                if item.required_count != progressCount {
                    TextFactory.text(type: .medium(text: "\(progressCount)", font: .med28, color: item.status == 2  ? .seccondary : .white))
                        .frame(width: 135, height: 135)
                       
                } else {
                    CheckMarkerWithSound(needSound: self.needSound)
                }
            }.padding()
                .scaleEffect(isTapped ? 1.1 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isTapped)
                .onTapGesture {
                    if item.status != 2 {
                        ImpactGenerator.panModal.generateImpact()
                        withAnimation {
                            isTapped = true
                            if progressCount < item.required_count ?? 0 {
                                self.progressCount += 1
                                self.needSound = progressCount == item.required_count ?? 0
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    self.changeProgress(recCount: item.required_count ?? 0, curCount: progressCount)
                                }
                                self.isActiveComplete = !(progressCount == item.required_count ?? 0)
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation { isTapped = false }
                        }
                    }
                }
            
            ButtonFactory.button(type: .roundedWhite(image: "ic_increament", onClick: {
                if item.status != 2  {
                    ImpactGenerator.panModal.generateImpact()
                    if progressCount < item.required_count ?? 0 {
                        self.progressCount += 1
                        self.needSound = progressCount == item.required_count ?? 0
                        withAnimation(.easeInOut(duration: 0.4)) {
                            self.changeProgress(recCount: item.required_count ?? 0, curCount: progressCount)
                        }
                        self.isActiveComplete = !(progressCount == item.required_count ?? 0)
                    }
                }
            }))
        }.padding(.vertical)
    }
    
    
    private func changeProgress(recCount:Int, curCount:Int){
        self.progressCount = curCount
        self.progressPercent = CGFloat(curCount) / CGFloat(recCount)
        self.viewModel?.changeProgress(curCount: curCount, frequencyType: self.item.frequency_type ?? "", id: self.item.id ?? 0)
    }
    
    private func changeCount() {
        let date = MainBean.shared.getTodayDate()
        let userId = SecurityBean.shared.userId
        let count = self.progressCount - (self.item.current_count ?? 0)
        
        var changedItem = self.item
        changedItem.current_count = self.progressCount
        NotificationCenter.default.post(name: .updateSunnahItem, object: self, userInfo: ["sunnah":changedItem])
        
        let reqBody = SunnahModel.Request.IncrementHabitRecord(count: count, date: date, client_id: userId, habit_id: item.id ?? 0)
        
        self.viewModel?.incrementHabitRecord(reqBody: reqBody) {
            self.needUpdate(.update)
        }
    }
}




