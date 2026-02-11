//
//  HomeModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import Foundation

struct HomeItems {
    let title:String
    let description:String
    let icon:String
    let image:String?
    
    init(title: String, description: String, icon: String, image: String? = nil) {
        self.title = title
        self.description = description
        self.icon = icon
        self.image = image
    }
}

enum HomeDetailType {
    case life
    case shamail
    case companion
    case family
    case sunnah
}


struct HomeModel {
    
}
