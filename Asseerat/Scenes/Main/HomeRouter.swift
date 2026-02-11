//
//  HomeRouter.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

extension MainRouter {
    enum Home {
        case profile
        case notifications
        case locations(prayerAdress:PrayerAddress?, onClick:(LocationModel.CitiesRows) -> Void)
        case prayerTimes(prayerTimes:[PrayerData]?, location:[Double])
        case homeDetail(detailType:HomeDetailType)
        case homeAR
        case homeARDetail(title:String)
        case homeMapAndKey
        case homeMapKeyDetail(title:String, id:Int)
    }
    
    @ViewBuilder
    public func HomeRoute(_ type: Home)-> some View {
        switch type {
        case .profile:
            ProfileView()
        case .notifications:
            NotificationsView()
        case .locations(let address, let onClick):
            LocationsView(prayerAddres: address, onClick: onClick)
        case .homeDetail(let detailType):
            HomeDetailView(detailType: detailType)
        case .homeAR:
            HomeARListView()
        case .homeARDetail(let title):
            HomeARView(navTitle: title)
        case .homeMapAndKey:
            HomeMapKeyListView()
        case .homeMapKeyDetail(let title, let id):
            HomeMapKeyDetailView(title: title, id: id)
        case .prayerTimes(let prayerTimes, let location):
            PrayerTimeView(prayerTimes: prayerTimes,location: location)
        }
    }
}
