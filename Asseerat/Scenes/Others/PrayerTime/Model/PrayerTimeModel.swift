//
//  PrayerTimeModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 06/09/25.
//

import Foundation

enum PrayerTimeModel {
    struct Request{
        struct Time: Codable {
            let latitude: Double
            let longitude: Double
            let date: String
           
            init(latitude: Double, longitude: Double, date: String) {
                self.latitude = latitude
                self.longitude = longitude
                self.date = date
            }
        }
    }
    
    struct Response {
        struct Times:APIData {
            var code: Int?
            var msg: String?
            var body: PrayerBodys?
        }
        
        struct Time:APIData {
            var code: Int?
            var msg: String?
            var body: PrayerBody?
        }
    }
}

struct PrayerBody:Codable, Hashable {
    let data:PrayerData?
    let address:PrayerAddress?
    init(data: PrayerData?, address: PrayerAddress?) {
        self.data = data
        self.address = address
    }
}

struct PrayerBodys:Codable, Hashable {
    let data:[PrayerData]?
    let address:PrayerAddress?
    init(data: [PrayerData]?, address: PrayerAddress?) {
        self.data = data
        self.address = address
    }
}

struct PrayerAddress:Codable, Hashable {
    let address:PrayerAddressDetail?
    init(address: PrayerAddressDetail?) {
        self.address = address
    }
}

struct PrayerAddressDetail:Codable, Hashable {
    let county:String?
    let postcode:String?
    let country:String
    let country_code:String?
    init(county: String?, postcode: String?, country: String, country_code: String?) {
        self.county = county
        self.postcode = postcode
        self.country = country
        self.country_code = country_code
    }
}


struct PrayerData:Codable, Hashable {
    let timings:PrayerTimings?
    let date:PrayerDate?
    init(timings: PrayerTimings?, date: PrayerDate?) {
        self.timings = timings
        self.date = date
    }
}

struct PrayerTimings:Codable, Hashable {
    let Fajr:String?
    let Sunrise:String?
    let Dhuhr:String?
    let Asr:String?
    let Maghrib:String?
    let Isha:String?
    
    init(Fajr: String?, Sunrise: String?, Dhuhr: String?, Asr: String?, Maghrib: String?, Isha: String?) {
        self.Fajr = Fajr
        self.Sunrise = Sunrise
        self.Dhuhr = Dhuhr
        self.Asr = Asr
        self.Maghrib = Maghrib
        self.Isha = Isha
    }
}

struct PrayerDate:Codable, Hashable {
    let readable: String?
    let hijri: PrayerDateHijri?
    init(readable: String?, hijri: PrayerDateHijri?) {
        self.readable = readable
        self.hijri = hijri
    }
}

struct PrayerDateHijri:Codable, Hashable {
    let day:String?
    let month:PrayerDateHijriMonth?
    let year:String?
    init(day: String?, month: PrayerDateHijriMonth?, year: String?) {
        self.day = day
        self.month = month
        self.year = year
    }
}

struct PrayerDateHijriMonth:Codable, Hashable {
    let number: Int?
    let en: String?
    let ar: String?
    let days: Int?
    init(number: Int?, en: String?, ar: String?, days: Int?) {
        self.number = number
        self.en = en
        self.ar = ar
        self.days = days
    }
}


struct TimingItem {
    let name:String
    let time:String
    
    init(name: String, time: String) {
        self.name = name
        self.time = time
    }
}

