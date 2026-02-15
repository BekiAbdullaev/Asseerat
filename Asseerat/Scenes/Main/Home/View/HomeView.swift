//
//  HomeView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel:HomeViewModel
    @ObservedObject private var vmPrayerTime:PrayerTimeViewModel
    
    @ObservedObject private var locationManager = LocationManager()

    @State private var namazTime: String = ""
    @State private var namazLocation: String = ""
    @State private var prayerAdress: PrayerAddress?
    @State private var isLocLoader = false
    @State private var needSaveMemory = true
    @State private var isLocationAllowed = true
    @State private var currentLocation = [Double]()
    @State private var imagedata:[Data]?
        
    init(viewModel:HomeViewModel, vmPrayerTime:PrayerTimeViewModel) {
        self.viewModel = viewModel
        self.vmPrayerTime = vmPrayerTime
    }
    
    var body: some View {
        VStack {
            self.navigationView()
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing:14) {
                    HomeHorizontalView(item:  HomeItems(title: Localize.home11Title, description: Localize.home11Subtitle, icon: "ic_circle_row", image: "img_first"), onClick: { self.pushToDetail(type: .life) })
                       
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing:8){
                            HomeVerticalView(item: HomeItems(title: Localize.home21Title, description: Localize.home21Subtitle, icon: "ic_shamail"), onClick: {
                                self.pushToDetail(type: .shamail)
                            })
                            HomeVerticalView(item: HomeItems(title: Localize.home22Title, description: Localize.home22Subtitle, icon: "ic_ar_exp"), onClick: {
                                self.coordinator.navigate(type: .home(.homeAR))
                            })
                            HomeVerticalView(item: HomeItems(title: Localize.home23Title, description: Localize.home23Subtitle, icon: "ic_map_key"), onClick: {
                                self.coordinator.navigate(type: .home(.homeMapAndKey))
                            })
                        }.padding(.horizontal,16)
                    }
                    
                    HomeHorizontalView(item:  HomeItems(title: Localize.home31Title, description: Localize.home31Subtitle, icon: "ic_circle_row", image: "img_second"), onClick: { self.pushToDetail(type: .companion)})
                        .onTapGesture {  }
                    HomeHorizontalView(item:  HomeItems(title: Localize.home41Title, description: Localize.home41Subtitle, icon: "ic_circle_row", image: "img_third"), onClick: { self.pushToDetail(type: .family) })
                    
                    HomeHorizontalView(item:  HomeItems(title: Localize.home51Title, description: Localize.home51Subtitle, icon: "ic_circle_row", image: "img_fourth"), onClick: { self.pushToDetail(type: .sunnah)})
                    
                    HomeProgressView(onClick: {
                    })
                }.padding(.vertical,16)
                
            }
        }.background(Colors.background)
            .navigationBarHidden(true)
            .onTapGesture { keyboardEndEditing() }
            .onDidLoad {
                self.imagedata = UDManager.shared.getObject(key: .profileImage)
                locationManager.getLocation { location in
                    let long:Double = Double(location.longitude)
                    let lati:Double = Double(location.latitude)
                    self.currentLocation = [lati, long]
                    self.getNamazTimes(long: long, lati: lati)
                }
                self.onNotificationParmissionChange()
                self.setNotification()
            }
    }
    
    
    private func onNotificationParmissionChange() {
        locationManager.onPermissionAllowed = {
            isLocationAllowed = true
            locationManager.getLocation { location in
                let long:Double = Double(location.longitude)
                let lati:Double = Double(location.latitude)
                self.currentLocation = [lati, long]
                self.getNamazTimes(long: long, lati: lati)
            }
        }
        
        locationManager.onPermissionDenied = {
           isLocationAllowed = false
        }
    }
    
    
    private func getNamazTimes(long:Double, lati:Double ) {
        let todayDate = MainBean.shared.getTodayDate()
        let lastPrayerAddress:[Double] = UDManager.shared.getObject(key: .lastPrayerAddress) ?? []
        var distance:Double = 0.0
        if !lastPrayerAddress.isEmpty && lastPrayerAddress.count == 2 {
            let dis = locationManager.distanceInKM(latStart: lastPrayerAddress[0], lonStart: lastPrayerAddress[1], latEnd: lati, lonEnd: long)
            distance = dis
        }
            
        if  distance < 3.0 && distance != 0.0 {
            
            if let prayerTimes:[PrayerData] = UDManager.shared.getObject(key: .prayerTimes), let address:[PrayerAddress] = UDManager.shared.getObject(key: .prayerAddress) , let prayerAdress = address.first {
                self.prayerAdress = prayerAdress
                if prayerTimes.count > 1 {
                    self.vmPrayerTime.prayerTimes = prayerTimes
                    let todayTime = prayerTimes[0]
                    let nextDayTime = prayerTimes[1]
                    
                    self.namazTime = vmPrayerTime.getNamazTimeAndName(today: todayTime, tomorrow: nextDayTime, address: prayerAdress).0
                    self.namazLocation = vmPrayerTime.getNamazTimeAndName(today: todayTime, tomorrow: nextDayTime, address: prayerAdress).1
                }
            }
            
        } else {
            let nextDate = MainBean.shared.convertDateToString(date: MainBean.shared.getNextDate(date: Date(), interval: 2))
            self.isLocLoader = true
            
            self.vmPrayerTime.getPrayingTimesRanges(lati: lati, long: long, startDate:todayDate, endDate: nextDate) { results in
                
                guard let times = results.body?.data else { return }
                guard let address = results.body?.address else { return }
                self.prayerAdress = address
                if times.count > 1 {
                    self.vmPrayerTime.prayerTimes = times
                    let todayTime = times[0]
                    let nextDayTime = times[1]
                    if needSaveMemory {
                        UDManager.shared.removeObejct(key: .prayerTimes)
                        UDManager.shared.removeObejct(key: .prayerAddress)
                        UDManager.shared.removeObejct(key: .lastPrayerAddress)
                        UDManager.shared.setObject(key: .prayerTimes, object: times)
                        UDManager.shared.setObject(key: .prayerAddress, object: [address])
                        UDManager.shared.setObject(key: .lastPrayerAddress, object: [lati, long])
                    }
                   
                    self.namazTime = vmPrayerTime.getNamazTimeAndName(today: todayTime, tomorrow: nextDayTime, address: address).0
                    self.namazLocation = vmPrayerTime.getNamazTimeAndName(today: todayTime, tomorrow: nextDayTime, address: address).1
                    
                    self.isLocLoader = false
                }
            }
        }
    }
    
    private func pushToDetail(type:HomeDetailType) {
        self.coordinator.navigate(type: .home(.homeDetail(detailType: type)))
    }
                     
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            HStack(alignment:.center, spacing:10){
                ZStack{
                    if isLocLoader {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.0)
                    } else {
                        VStack(alignment: .leading,spacing: 4) {
                            if isLocationAllowed {
                                TextFactory.text(type: .medium(text: namazTime, font: .med16, line: 1))
                                    .onTapGesture(perform: pushToPrayerTime)
                                
                                HStack(alignment:.center, spacing:2) {
                                    Image("ic_small_location")
                                        .resizable().frame(width: 14, height: 14, alignment: .center)
                                    TextFactory.text(type: .regular(text: namazLocation, font: .reg12, color: .seccondary, line: 1))
                                    Image("ic_small_row")
                                        .resizable().frame(width: 14, height: 14, alignment: .center)
                                }.onTapGesture(perform: pushToLocations)
                            } else {
                                HStack(alignment:.center, spacing:6) {
                                    Image("ic_small_location")
                                        .resizable().frame(width: 18, height: 18, alignment: .center)
                                    TextFactory.text(type: .regular(text: Localize.allowLocationAccess, font: .reg12, color: .seccondary, line: 2))
                                }.onTapGesture(perform: allowLocation)
                            }
                        }
                    }
                }.padding(.leading,16)
    
                Spacer()
                ButtonFactory.button(type: .roundedWhite(image: "ic_globus", onClick: pushToLanguage))
                ButtonFactory.button(type: .roundedWhite(image: "ic_ball", onClick: pushToNotification))
                profileView()
            }
        }.frame(height: 42).frame(maxWidth:.infinity).padding(.top,8)
    }
    
    @ViewBuilder
    private func profileView() -> some View {
        if let imageIn = imagedata?.first, let image = UIImage(data: imageIn)  {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 42, height: 42)
                .cornerRadius(42, corners: .allCorners).padding(.trailing, 16)
                .onTapGesture(perform: pushToProfile)
        } else {
            ZStack{
                Image("ic_profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30 , height:30)
            }.frame(width: 42, height: 42, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 21, style: .continuous).fill(Colors.green)
                ).padding(.trailing, 16)
                .onTapGesture(perform: pushToProfile)
        }
    }
    
    private func pushToLanguage() {
        self.coordinator.navigate(type: .other(.lang ))
    }
    
    private func pushToProfile() {
        self.coordinator.navigate(type: .home(.profile))
    }
    
    private func pushToNotification() {
        self.coordinator.navigate(type: .home(.notifications))
    }
    
    private func pushToLocations() {
        self.needSaveMemory = false
        self.coordinator.navigate(type: .home(.locations(prayerAdress: self.prayerAdress, onClick: { loc in
            self.getNamazTimes(long: loc.longitude ?? 0.0, lati: loc.latitude ?? 0.0)
            self.currentLocation = [loc.longitude ?? 0.0, loc.latitude ?? 0.0]
        })))
    }
    
    private func pushToPrayerTime() {
        self.coordinator.navigate(type: .home(.prayerTimes(prayerTimes: self.vmPrayerTime.prayerTimes, location: self.currentLocation)))
    }
    
    private func allowLocation() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(forName: .updateProfileImage, object: nil, queue: .main) { _ in
            self.imagedata = UDManager.shared.getObject(key: .profileImage)
        }
    }
}
