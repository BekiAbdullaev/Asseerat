//
//  DhikrsView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI
import AVFoundation

struct DhikrsView: View {
    
    private var prograssSize:CGFloat = biometricType() == .face ? 300 : 240
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel:DhikrsViewModel
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    
    @State private var bindedDhikrs = [DhikrsModel.Response.BindedDhikrsRows]()
    @State private var currentDhikr:DhikrsModel.Response.BindedDhikrsRows?
    @State private var saveCounter: Task<Void, Never>? = nil
    @State var todayCount:String = "0"
    @State var allCount:String = "0"
    @State var localCount:Int = 0
    @State var counter:Int = 0
    @State var lastSavedcounter:Int = 0
    @State var progress:CGFloat = 0.0
    @State private var currentDhikrIndex: Int = 0
    @State private var isMuted: Bool = true
    @State private var audioPlayer: AVAudioPlayer?
    
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
}

// Header view
extension DhikrsView {
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            HStack(alignment:.center, spacing:10){
                TextFactory.text(type: .regular(text: Localize.dhikr, font: .reg24, line: 1)).padding(.leading,16)
                Spacer()
                
                ZStack{
                    Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                        .resizable()
                        .foregroundStyle(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                }.frame(width: 42, height: 42, alignment: .center)
                    .background( RoundedRectangle(cornerRadius: 21, style: .continuous).fill(Colors.green) )
                    .onTapGesture {
                        isMuted.toggle()
                    }
        
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
}


// Body view
extension DhikrsView {
    @ViewBuilder
    private func bodyView() -> some View {
        TabView(selection:$currentDhikrIndex) {
            ForEach(bindedDhikrs.indices, id: \.self) { index in
                dhikrInfoView(item: bindedDhikrs[index])
                    .tag(index)
            }
        }.tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .automatic))
            .onChange(of: currentDhikrIndex) { _,newIndex in
                if counter > 0 {
                    self.incrementSelectedDhikr()
                }
                let curDihkr = bindedDhikrs[newIndex]
                self.setInitDhkir(dhikr: curDihkr)
                lastSavedcounter = 0
                counter = 0
                localCount = 0
                incrementProgress()
            }
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
                            .padding(.vertical,5).padding(.horizontal,10)
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Colors.green)
                            ).padding(.trailing, 2)
                    }.frame(width: 110,height: 34)
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
                if !isMuted {
                    playTouch()
                }
            }
            Spacer()
        }
    }
}


extension DhikrsView {
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
                                self.setInitDhkir(dhikr: self.bindedDhikrs.first)
                            }
                        }
                    }
                }
            } else {
                self.bindedDhikrs = bindedDhikrs
                self.setInitDhkir(dhikr: self.bindedDhikrs.first)
            }
        }
    }
    

    private func incrementSelectedDhikr() {
        
        let clientId = SecurityBean.shared.userId
        let id:Int = self.currentDhikr?.id ?? 0
        let count = self.counter - self.lastSavedcounter
        
        // Increment today count
        if var items:[DhikrSavedItem] = UDManager.shared.getObject(key: .dhikrCount), let item = items.filter({$0.id == id}).first {
            let newItem = DhikrSavedItem(id: id, count: item.count + count, date: Date().ddmmyyyy)
            items.removeAll(where: {$0.id == id})
            items.append(newItem)
            UDManager.shared.setObject(key: .dhikrCount, object: items)
        }
        
        // Increment all count
        let reqBody = DhikrsModel.Request.DhikrIncrement(id: id, count: count, client_id: clientId)
        self.viewModel.incrementDhikr(reqBody: reqBody) {
            self.lastSavedcounter = counter
        }
    }
    
    func playTouch() {
        guard let url = Bundle.main.url(forResource: "tasbeh_voice", withExtension: "mp3") else { return }
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }
}


extension DhikrsView {
    func setNotification() {
        NotificationCenter.default.addObserver(forName: .updateBindedDhikr, object: nil, queue: .main) { _ in
            self.getBindedDhikrs()
        }
    }
    
    private func setInitDhkir(dhikr:DhikrsModel.Response.BindedDhikrsRows?) {
        if let initDhikr = dhikr {
            self.currentDhikr = initDhikr
            self.allCount = String(initDhikr.count ?? 0)
            self.getLocalCount(id: initDhikr.id ?? 0)
        }
    }
    

    func incrementProgress() {
        withAnimation(.easeInOut(duration: 0.4)) {
            progress = localCount == 0 ? 0.0 : CGFloat(Float(localCount)/33)
        }
    }
    
    func incrementLocalCount() {
        localCount = (localCount % 33) + 1
        counter += 1
        self.incrementCountBySchedule()
        self.incrementCountForLocal()
    }
    
    func incrementCountBySchedule() {
        saveCounter?.cancel()
        saveCounter = Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            guard !Task.isCancelled else { return }
            self.incrementSelectedDhikr()
            print("Counter saved: \(counter)")
        }
    }
        
    func incrementCountForLocal(){
        let curAllCount = Int(self.allCount) ?? 0
        self.allCount = String(curAllCount + 1)
        
        let curTodayCount = Int(self.todayCount) ?? 0
        self.todayCount = String(curTodayCount + 1)
    }
    
    
    func getLocalCount(id:Int) {
        if var items:[DhikrSavedItem] = UDManager.shared.getObject(key: .dhikrCount){
            if let item = items.filter({$0.id == id}).first {
                if item.date != Date().ddmmyyyy {
                    self.todayCount = "0"
                    let newItem = DhikrSavedItem.init(id: item.id, count: 0, date: Date().ddmmyyyy)
                    items.removeAll(where: {$0.id == id})
                    items.append(newItem)
                    UDManager.shared.setObject(key: .dhikrCount, object: items)
                } else {
                    self.todayCount = String(item.count)
                }
            } else {
                items.append(DhikrSavedItem(id: id, count: 0, date: Date().ddmmyyyy))
                UDManager.shared.setObject(key: .dhikrCount, object: items)
            }
        
        } else {
            var items = [DhikrSavedItem]()
            items.append(DhikrSavedItem(id: id, count: 0, date: Date().ddmmyyyy))
            UDManager.shared.setObject(key: .dhikrCount, object: items)
        }
    }
}


