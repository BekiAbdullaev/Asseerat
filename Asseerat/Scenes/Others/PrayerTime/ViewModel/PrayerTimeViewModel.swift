//
//  PrayerTimeViewModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 06/09/25.
//

import Foundation

class PrayerTimeViewModel: ObservableObject {
    
    var prayerTimes:[PrayerData]?
    var timeList = [TimingItem]()
    var selectedDate = Date()
        
    func getNamazTimeAndName(today:PrayerData, tomorrow:PrayerData, address:PrayerAddress) -> (String, String) {
        
        var prayerType = ""
        var prayerTime = ""
        var city = ""
        var country = ""
        let fajr:String = String((today.timings?.Fajr ?? "").prefix(5))
        let sunrise:String = String((today.timings?.Sunrise ?? "").prefix(5))
        let dhuhr:String = String((today.timings?.Dhuhr ?? "").prefix(5))
        let asr:String = String((today.timings?.Asr ?? "").prefix(5))
        let maghrib:String = String((today.timings?.Maghrib ?? "").prefix(5))
        let isha:String = String((today.timings?.Isha ?? "").prefix(5))
        let nextDayFajr:String = String((tomorrow.timings?.Fajr ?? "").prefix(5))
       
        if checkIfCurrentTimeIsBetween(startTime: fajr, endTime: sunrise) {
            prayerType = "Sunrise"
            prayerTime = sunrise
        } else if checkIfCurrentTimeIsBetween(startTime: sunrise, endTime: dhuhr) {
            prayerType = "Dhuhr"
            prayerTime = dhuhr
        } else if checkIfCurrentTimeIsBetween(startTime: dhuhr, endTime: asr) {
            prayerType = "Asr"
            prayerTime = asr
        } else if checkIfCurrentTimeIsBetween(startTime: asr, endTime: maghrib) {
            prayerType = "Maghrib"
            prayerTime = maghrib
        } else if checkIfCurrentTimeIsBetween(startTime: maghrib, endTime: fajr) {
            prayerType = "Isha"
            prayerTime = isha
        }  else if checkIfCurrentTimeIsBetween(startTime:isha, endTime: "23:59") || checkIfCurrentTimeIsBetween(startTime: "00:00", endTime: nextDayFajr) {
            prayerType = "Fajr"
            prayerTime = checkIfCurrentTimeIsBetween(startTime:isha, endTime: "23:59") ? nextDayFajr : fajr
        }
        city = address.address?.county ?? ""
        country = address.address?.country ?? ""
        
        return ("\(prayerTime) - \(prayerType)","\(country), \(city)")
    }
    
    func checkIfCurrentTimeIsBetween(startTime: String, endTime: String) -> Bool {
        guard let start = Formatter.today.date(from: startTime),
              let end = Formatter.today.date(from: endTime) else {
            return false
        }
        if end >= start {
            let interval = DateInterval(start: start, end: end)
            if interval.contains(Date()) {
                return true
            }
        }
        return false
    }
    
    
    func getPrayingTime(lati:Double, long:Double, date:String, onComplete:@escaping((PrayerTimeModel.Response.Time)->())) {
        NetworkManager(hudType: .noHud).request(OtherAPI.getPrayTiming(lati: lati, long: long, date: date)) { (response:PrayerTimeModel.Response.Time) in
            onComplete(response)
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func getPrayingTimesRanges(lati:Double, long:Double, startDate:String, endDate:String, onComplete:@escaping((PrayerTimeModel.Response.Times)->())) {
        NetworkManager(hudType: .noHud).request(OtherAPI.getPrayTimingRange(lati: lati, long: long, startDate: startDate, endDate: endDate)) { (response:PrayerTimeModel.Response.Times) in
            onComplete(response)
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}



