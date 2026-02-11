//
//  ProfileLanguageViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 29/06/25.
//

import Foundation
import SwiftUI

struct LanguageItem:Hashable {
    let tittle:String
    let image:String
    let code:String
}

struct ProfileLanguageViewModel {
    let langes = [LanguageItem(tittle: "O'zbek", image: "ic_uz", code: "uz"),
                  LanguageItem(tittle: "English", image: "ic_en", code: "en"),
                  LanguageItem(tittle: "Русский", image: "ic_ru", code: "ru")]
    let columns = [ GridItem(.flexible())]
}
