//
//  ProfileUserView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 20/06/25.
//

import SwiftUI

struct ProfileUserView: View {
    
    private var title:String
    private var subtitle:String
    private var profileImage:String
    private var onClick:() -> Void
    
    init(title: String, subtitle: String, profileImage: String, onClick: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.profileImage = profileImage
        self.onClick = onClick
    }
    
    var body: some View {
        ZStack {
            Colors.green
            HStack(alignment:.center){
                ZStack{
                    Image(profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }.frame(width: 56, height: 56, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                    ).foregroundColor(Colors.background).padding(.leading, 14)
                
                VStack(alignment:.leading, spacing: 4) {
                    TextFactory.text(type: .regular(text: title, font: .sem18, line: 2))
                    TextFactory.text(type: .regular(text: subtitle, font: .reg12, color: .seccondary, line: 4))
                }.padding(.leading,6)
                Spacer()
                
                ZStack{
                    Image("ic_new_chat")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24, alignment: .center)
                }.frame(width: 40, height: 40, alignment: .center).padding(.trailing,14)
                    .onTapGesture {
                        self.onClick()
                    }
            }
        }.frame(maxWidth:.infinity).frame(height: 84)
            .cornerRadius(15, corners: .allCorners)
            .padding(.horizontal)
    }
}
