//
//  LocationItemView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 23/06/25.
//

import SwiftUI

struct LocationItemView: View {
    
    private var item:LocationModel.CitiesRows
    init(item: LocationModel.CitiesRows) {
        self.item = item
    }
    
    var body: some View {
        ZStack {
            Colors.green
            HStack(alignment:.center, spacing: 12){
                VStack(alignment:.leading, spacing: 6) {
                    TextFactory.text(type: .regular(text: item.name ?? "", font: .reg16))
                    TextFactory.text(type: .regular(text: item.region_name ?? Localize.unknown, font: .reg10, color: .seccondary))
                }.padding(.leading)
                Spacer()
            }
        }.frame(maxWidth:.infinity).frame(height: 54)
            .cornerRadius(15, corners: .allCorners)
            .padding(.horizontal)
    }
}
