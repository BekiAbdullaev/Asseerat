//
//  NotificationItemView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 23/06/25.
//

import SwiftUI

struct NotificationItemView: View {
    
    private let item:NotifyItem
    private let fReqOnClick:()->Void
    init(item: NotifyItem, fReqOnClick:@escaping(()->Void) = {}) {
        self.item = item
        self.fReqOnClick = fReqOnClick
    }
    
    var body: some View {
        ZStack {
            Colors.green
            HStack(alignment:.center){
                ZStack{
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                }.frame(width: 40, height: 40, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                    ).foregroundColor(Colors.background).padding(.leading, 6)
                
                if item.type == .friendRequest {
                    TextFactory.text(type: .regular(text: item.title, font: .sem14, line: 2)).lineSpacing(4).padding(.trailing,16).padding(.leading,8)
                        .onTapGesture { self.fReqOnClick() }
                } else  {
                    TextFactory.text(type: .regular(text: item.title, font: .sem14, line: 2)).lineSpacing(4).padding(.trailing,16).padding(.leading,8)
                }
            }
        }.frame(maxWidth:.infinity).frame(height: 68)
            .cornerRadius(15, corners: .allCorners)
            .padding(.horizontal)
    }
}
