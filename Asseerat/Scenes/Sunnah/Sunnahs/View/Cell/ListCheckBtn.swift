//
//  ListCheckBtn.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 09/07/25.
//

import Foundation
import SwiftUI

// Custom ListCheckBtn View
struct ListCheckBtn: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Colors.green
            HStack(alignment:.center){
                TextFactory.text(type: .regular(text: title, font: .reg16, line: 1))
                Spacer()
                Image( isSelected ? "ic_check" : "").resizable().frame(width: 24, height: 24)
            }
        }.padding(.horizontal,16)
            .frame(height: 46).onTapGesture { action()}
    }
}
