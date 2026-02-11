//
//  PrayerTimeView.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 06/09/25.
//

import SwiftUI

struct PrayerTimeView: View {
    
    @ObservedObject private var viewModel = PrayerTimeViewModel()
    private var prayerTimes:[PrayerData]?
    @State var location:[Double]
    @State private var date:String = ""
    @State private var hijriDate:String = ""
   
    init(prayerTimes:[PrayerData]?, location:[Double]){
        self.prayerTimes = prayerTimes
        self.location = location
    }
    
    var body: some View {
        VStack {
            self.timeHeaderView()
            ScrollView(.vertical, showsIndicators: false){
                self.timeBodyView()
            }
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.prayerTimes)
            .onAppear {
                if let prayerTime = self.prayerTimes?.first {
                    self.setNamazItems(prayerTimes: prayerTime)
                }
            }
    }
    
    @ViewBuilder
    private func timeHeaderView() -> some View {
        HStack(alignment:.center){

            ZStack{
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.white)
            }.frame(width: 65, height: 65, alignment: .center)
                .onTapGesture {
                    ImpactGenerator.panModal.generateImpact()
                    let date = MainBean.shared.getPreviousDate(date: self.viewModel.selectedDate)
                    self.viewModel.selectedDate = date
                    self.getNamazTimes(date: date)
                }
               

            Spacer()
            VStack(spacing:4){
                TextFactory.text(type: .medium(text: hijriDate, font: .med16))
                TextFactory.text(type: .medium(text: date, font: .reg12))
            }
            Spacer()
            
            ZStack{
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.white)
            }.frame(width: 65, height: 65, alignment: .center)
                .onTapGesture {
                    ImpactGenerator.panModal.generateImpact()
                    let date = MainBean.shared.getNextDate(date: self.viewModel.selectedDate, interval: 1)
                    self.viewModel.selectedDate = date
                    self.getNamazTimes(date: date)
                }
               

        }.background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Colors.inputBackground)
            ).padding([.horizontal, .top], 16)
    }
    
    @ViewBuilder
    private func timeBodyView() -> some View {
        VStack{
            ForEach(viewModel.timeList.indices, id: \.self) { i in
                self.timeBodyItemView(item: viewModel.timeList[i])
            }
        }.padding(.top,10)
    }
    
    @ViewBuilder
    private func timeBodyItemView(item:TimingItem) -> some View {
        HStack(alignment:.center){
            TextFactory.text(type: .medium(text: item.name, font: .reg18)).padding([.vertical,.leading], 16)
            Spacer()
            TextFactory.text(type: .medium(text: item.time, font: .med18)).padding([.vertical,.trailing], 16)
        }.background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Colors.inputBackground)
            ).padding(.horizontal, 16)
    }
    
    func getNamazTimes(date:Date) {
       
        if location.count > 1 {
            let lati:Double = location[0]
            let long:Double = location[1]
            let date = MainBean.shared.convertDateToString(date: date)
            
            self.viewModel.getPrayingTime(lati: lati, long: long, date: date) { response in
                guard let time = response.body?.data else { return }
                self.setNamazItems(prayerTimes: time)
            }
        }
    }
    
    func setNamazItems(prayerTimes:PrayerData) {
        
        viewModel.timeList.removeAll()
        hijriDate = "\(prayerTimes.date?.hijri?.day ?? "") \(prayerTimes.date?.hijri?.month?.en ?? ""), \(prayerTimes.date?.hijri?.year ?? "")"
        date = prayerTimes.date?.readable ?? ""
    
        viewModel.timeList.append(TimingItem(name: "Fajr", time: String((prayerTimes.timings?.Fajr ?? "").prefix(5))))
        viewModel.timeList.append(TimingItem(name: "Sunrise", time: String((prayerTimes.timings?.Sunrise ?? "").prefix(5))))
        viewModel.timeList.append(TimingItem(name: "Dhuhr", time: String((prayerTimes.timings?.Dhuhr ?? "").prefix(5))))
        viewModel.timeList.append(TimingItem(name: "Asr", time: String((prayerTimes.timings?.Asr ?? "").prefix(5))))
        viewModel.timeList.append(TimingItem(name: "Maghrib", time: String((prayerTimes.timings?.Maghrib ?? "").prefix(5))))
        viewModel.timeList.append(TimingItem(name: "Isha'a", time: String((prayerTimes.timings?.Isha ?? "").prefix(5))))
    }
}
