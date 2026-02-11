//
//  NotificationsView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

struct NotificationsView: View {
    
    let viewModel = NotificationViewModel()
    var body: some View {
        VStack(spacing: 10){
            ScrollView(.vertical, showsIndicators: false){
                self.notifyList().padding(.vertical,16)
            }.onTapGesture {
                keyboardEndEditing()
            }
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.notification)
    }
    
    @ViewBuilder
    private func notifyList() -> some View {
        ForEach(viewModel.notificationList, id: \.self) { item in
            if item.type == .friendRequest {
                NotificationItemView(item: item) {
                    infoActionAlert(title: "Friendship Request", subtitle: "Here’s some alert text. It can span multiple lines if needed!", lBtn: "No", rBtn: "Yes") {
                    }
                }
            } else {
                NotificationItemView(item: item)
            }
       }
    }
}

#Preview {
    NotificationsView()
}
