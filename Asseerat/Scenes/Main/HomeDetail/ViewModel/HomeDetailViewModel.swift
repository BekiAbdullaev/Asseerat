//
//  HomeDetailViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 19/06/25.
//

import Foundation

struct HomeDetailViewModel {
    
    let lifeList = [HomeDetailItem(title: Localize.lifeList1Title, subtitle: Localize.lifeList1Subtitle),
                    HomeDetailItem(title: Localize.lifeList2Title, subtitle: Localize.lifeList2Subtitle),
                    HomeDetailItem(title: Localize.lifeList3Title, subtitle: Localize.lifeList3Subtitle),
                    HomeDetailItem(title: Localize.lifeList4Title, subtitle: Localize.lifeList4Subtitle)]
    
    
    let shamailList = [HomeDetailItem(title: Localize.shamailList1Title, subtitle: Localize.shamailList1Subtitle),
                       HomeDetailItem(title: Localize.shamailList2Title, subtitle: Localize.shamailList2Subtitle),
                       HomeDetailItem(title: Localize.shamailList3Title, subtitle: Localize.shamailList3Subtitle),
                       HomeDetailItem(title: Localize.shamailList4Title, subtitle: Localize.shamailList4Subtitle),
                       HomeDetailItem(title: Localize.shamailList5Title, subtitle: Localize.shamailList5Subtitle),
                       HomeDetailItem(title: Localize.shamailList6Title, subtitle: Localize.shamailList6Subtitle)]
    
    
    let companionList = [HomeDetailItem(title: Localize.companionList1Title, subtitle: Localize.companionList1Subtitle),
                         HomeDetailItem(title: Localize.companionList2Title, subtitle: Localize.companionList2Subtitle),
                         HomeDetailItem(title: Localize.companionList3Title, subtitle: Localize.companionList3Subtitle),
                         HomeDetailItem(title: Localize.companionList4Title, subtitle: Localize.companionList4Subtitle),
                         HomeDetailItem(title: Localize.companionList5Title, subtitle: Localize.companionList5Subtitle),
                         HomeDetailItem(title: Localize.companionList6Title, subtitle: Localize.companionList6Subtitle),
                         HomeDetailItem(title: Localize.companionList7Title, subtitle: Localize.companionList7Subtitle)]
    
    
    let familyList = [HomeDetailItem(title: Localize.familyList1Title, subtitle: Localize.familyList1Subtitle),
                      HomeDetailItem(title: Localize.familyList2Title, subtitle: Localize.familyList2Subtitle),
                      HomeDetailItem(title: Localize.familyList3Title, subtitle: Localize.familyList3Subtitle),
                      HomeDetailItem(title: Localize.familyList4Title, subtitle: Localize.familyList4Subtitle)]
    
    
    let sunnahList = [HomeDetailItem(title: Localize.sunnahList1Title, subtitle: Localize.sunnahList1Subtitle),
                      HomeDetailItem(title: Localize.sunnahList2Title, subtitle: Localize.sunnahList2Subtitle),
                      HomeDetailItem(title: Localize.sunnahList3Title, subtitle: Localize.sunnahList3Subtitle),
                      HomeDetailItem(title: Localize.sunnahList4Title, subtitle: Localize.sunnahList4Subtitle),
                      HomeDetailItem(title: Localize.sunnahList5Title, subtitle: Localize.sunnahList5Subtitle),
                      HomeDetailItem(title: Localize.sunnahList6Title, subtitle: Localize.sunnahList6Subtitle),
                      HomeDetailItem(title: Localize.sunnahList7Title, subtitle: Localize.sunnahList7Subtitle),
                      HomeDetailItem(title: Localize.sunnahList8Title, subtitle: Localize.sunnahList8Subtitle),
                      HomeDetailItem(title: Localize.sunnahList9Title, subtitle: Localize.sunnahList9Subtitle)]
    
    
    func getHomeDetailNavTitle(type:HomeDetailType) -> String {
        switch type {
        case .life:
            return Localize.lifeListNavTitle
        case .shamail:
            return Localize.shamailListNavTitle
        case .companion:
            return Localize.companionListNavTitle
        case .family:
            return Localize.familyListNavTitle
        case .sunnah:
            return Localize.sunnahListNavTitle
        }
    }
}
