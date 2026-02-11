//
//  DhikrsView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

struct DhikrSavedItem:Codable, Identifiable {
    var id = UUID()
    var name:String
    var counts:[DhikrCountItem]
    var round:Int
    var isActive:Bool
}

struct DhikrCountItem:Codable {
    var count:Int
    var date:String
}

struct DhikrsView: View {
    
    private var prograssSize:CGFloat = biometricType() == .face ? 300 : 240
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    
    @ObservedObject private var viewModel:DhikrsViewModel
    
    let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    @State var todayCount:String = "0"
    @State var allCount:String = "0"
    @State var localCount:Int = 0
    @State var progress:CGFloat = 0.0
    @State var dhikr:DhikrSavedItem? {
        didSet {
            if let dhikr = dhikr {
                todayCount = getTodayCount(curItem: dhikr)
                allCount = getAllCount(curItem: dhikr)
            }
        }
    }
    @State private var bindedDhikrs = [DhikrsModel.Response.BindedDhikrsRows]()
    
    init(viewModel:DhikrsViewModel) {
        self.viewModel = viewModel
    }
   
    var body: some View {
        VStack {
            self.navigationView()
            if MainBean.shared.userSignedIn() {
                self.headerView()
                self.bodyView()
            } else {
                EmptyView(title: Localize.registerRequiredTitle, subtitle: Localize.registerRequiredSubtitle,type: .signIn) {
                    UDManager.shared.clear()
                    self.coordinator.popToRoot()
                }
            }
        }.background(Colors.background)
            .navigationBarHidden(true)
            .onDidLoad {
                if MainBean.shared.userSignedIn() {
                    self.setNotification()
                    self.getBindedDhikrs()
                }
            }
    }
    
    private func getBindedDhikrs() {
        
        self.viewModel.getBindedDhikrs { bindedDhikrs in
            if bindedDhikrs.isEmpty {
                self.viewModel.getDhikrTemplates { templates in
                    if let initDhikr = templates.filter({$0.type == "TEMPLATE"}).last {
                        let clientId = SecurityBean.shared.userId
                        let tempId:String = String(initDhikr.id ?? 0)
                        let reqBody = DhikrsModel.Request.DhikrBind(client_id: clientId, template_id: tempId)
                        self.viewModel.bindDhikr(reqBody: reqBody) {
                            self.viewModel.getBindedDhikrs { dhikrs in
                                self.bindedDhikrs = dhikrs
                            }
                        }
                    }
                }
            } else {
                self.bindedDhikrs = bindedDhikrs
            }
        }
    }
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            HStack(alignment:.center, spacing:10){
                TextFactory.text(type: .regular(text: Localize.dhikr, font: .reg24, line: 1)).padding(.leading,16)
                Spacer()
                ButtonFactory.button(type: .roundedWhite(image: "ic_voice", onClick: {}))
                ButtonFactory.button(type: .roundedWhite(image: "ic_refresh", onClick: {
                    localCount = 0
                    incrementProgress()
                })).padding(.trailing, 16)
            }
        }.frame(height: 42).frame(maxWidth:.infinity).padding(.top,8)
    }
    
    
    @ViewBuilder
    private func headerView() -> some View {
        HStack{
            self.infoView(todayCount,Localize.today)
            self.infoView(allCount,Localize.allTheTime)
            self.rateView(Localize.dhikrRating).onTapGesture {
                self.coordinator.navigate(type: .dhikr(.dhikrRating))
            }
        }.padding(.horizontal,16).padding(.top, biometricType() == .face ? 16 : 10)
    }
    
    
    @ViewBuilder
    private func bodyView() -> some View {
        TabView {
            ForEach(bindedDhikrs, id: \.self) { item in
                dhikrInfoView(item: item)
            }
        }.tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .automatic))
    }
    
    
    @ViewBuilder
    private func infoView(_ title:String, _ subtitle:String) -> some View {
        HStack {
            VStack(alignment:.leading, spacing: 8) {
                TextFactory.text(type: .medium(text: title, font: .med20))
                TextFactory.text(type: .regular(text: subtitle, font: .reg12, color: .seccondary))
            }.padding(.leading,14)
            Spacer()
        }.frame(height: 73).frame(maxWidth:.infinity)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Colors.green)
            )
    }
    
    
    
    @ViewBuilder
    private func rateView(_ title:String) -> some View {
        HStack {
            VStack(spacing: 8) {
                HStack(spacing:-8){
                    ForEach(0 ..< 3){i in
                        Image("img_rate\(i)")
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                }
                TextFactory.text(type: .regular(text: title, font: .reg12, color: .seccondary))
            }.padding(.leading,14)
            Spacer()
        }.frame(height: 73).frame(maxWidth:.infinity)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Colors.green)
            )
    }
    
    
    
    @ViewBuilder
    private func dhikrInfoView(item:DhikrsModel.Response.BindedDhikrsRows) -> some View {
        VStack {
            VStack {
                HStack{
                    HStack(alignment:.bottom,spacing:0){
                        TextFactory.text(type: .medium(text: "\(localCount)", font: .med36))
                        TextFactory.text(type: .regular(text: "/33", font: .reg16)).padding(.bottom,6)
                    }.padding(.leading, 14).padding(.top,10)
                    Spacer()
                    HStack(alignment:.center){
                        TextFactory.text(type: .regular(text: Localize.rounds, font: .reg12, color: .seccondary)).padding(.leading,12)
                        Spacer()
                        TextFactory.text(type: .regular(text: "1", font: .reg14))
                            .padding(.vertical,5).padding(.horizontal,8)
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Colors.green)
                            ).padding(.trailing, 2)
                    }.frame(width: 100,height: 34)
                        .background(
                            RoundedRectangle(cornerRadius: 17, style: .continuous)
                                .fill(Colors.background)
                        ).padding(.trailing,14).padding(.top,8)
                    
                }
                Spacer()
                Divider().background(Colors.seccondary).padding(.bottom,10)
                Spacer()
                HStack(alignment:.center){
                    TextFactory.text(type: .regular(text: item.text ?? Localize.unknown, font: .reg16))
                    Spacer()
                    Image("ic_white_row")
                        .resizable()
                        .frame(width: 18, height: 18)
                }.padding(.horizontal, 14).padding(.bottom, 16)
            }.frame(height: 117).frame(maxWidth:.infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Colors.green)
                )
                .onTapGesture {
                    self.coordinator.navigate(type: .dhikr(.dhikrCounter))
                }
            
            self.dhikrCount()
        } .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(Color.clear)
        ).padding(.horizontal, 16).padding(.top, 6).padding(.bottom,10)
    }
    
    @ViewBuilder
    private func dhikrCount() -> some View {
        VStack(alignment: .center) {
            Spacer()
            ZStack {
                Circle()
                    .stroke(Colors.green, style: StrokeStyle(lineWidth: 25, lineCap: .round))
                    .frame(width: prograssSize, height: prograssSize)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Colors.btnColor, style: StrokeStyle(lineWidth: 25, lineCap: .round))
                    .frame(width: prograssSize, height: prograssSize)
                    .rotationEffect(.degrees(-90))
                
                TextFactory.text(type: .medium(text: "\(localCount)", font: .med60))
                    .frame(width: prograssSize-25, height: prograssSize-25)
                    .background(
                        Circle().fill(Colors.background)
                    )
            }.onTapGesture {
                impactFeedback.impactOccurred()
                self.incrementLocalCount()
                self.incrementProgress()
            }
            Spacer()
        }
    }
    
    
    func getTodayCount(curItem:DhikrSavedItem) -> String {
        var todayCount = 0
        for item in curItem.counts {
            if item.date == Date().ddmmyyyy{
                todayCount = item.count
            }
        }
        
        return String(todayCount)
    }
    
    func getAllCount(curItem:DhikrSavedItem) -> String {
        var allCount = 0
        for item in curItem.counts {
            allCount += item.count
        }
        return String(allCount)
    }
    
    func incrementProgress() {
        withAnimation(.easeInOut(duration: 0.4)) {
            progress = localCount == 0 ? 0.0 : CGFloat(Float(localCount)/33)
        }
    }
    
    func incrementLocalCount() {
        localCount = (localCount % 33) + 1
        self.incrementLifetimeCount()
    }
    
    func incrementLifetimeCount() {
        guard let dhikr = self.dhikr else { return }
        var count = 0
        var counts = dhikr.counts
        
        for item in counts {
            if item.date == Date().ddmmyyyy {
                count = item.count
            }
        }
        count += 1
        
        if counts.contains(where: {$0.date == Date().ddmmyyyy}) {
            counts.removeAll(where: {$0.date == Date().ddmmyyyy})
            counts.append(.init(count: count, date: Date().ddmmyyyy))
        } else {
            counts.append(.init(count: count, date: Date().ddmmyyyy))
        }
        
        let tempItem = DhikrSavedItem(name: dhikr.name, counts: counts, round: dhikr.round, isActive: dhikr.isActive)
        self.dhikr = tempItem
        
        if var items:[DhikrSavedItem] = UDManager.shared.getObject(key: .dhikrCount) {
            items.removeAll(where: {$0.isActive == true})
            items.append(tempItem)
            UDManager.shared.setObject(key: .dhikrCount, object: items)
        }
    }
}

extension DhikrsView {
    func setNotification() {
        NotificationCenter.default.addObserver(
            forName: .updateBindedDhikr,
            object: nil,
            queue: .main) { _ in
                self.getBindedDhikrs()
            }
    }
}


