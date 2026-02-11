//
//  AddFriendsView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 30/06/25.
//

import SwiftUI

struct AddFriendsView: View {
    @State private var selectedUser: String? = nil
    @State private var isFocused:Bool = false
    private let columns = [ GridItem(.flexible()) ]
    private let viewModel = AddFriendsViewModel()
    
    var body: some View {
        VStack{
            SearchView(placeholder:Localize.emailOrPhoneNumber, isFocused: $isFocused, onChange: { text in
                
            }).padding([.vertical,.top],16)
            ScrollView(.vertical, showsIndicators: false){
                self.userGridView()
            }
        }.background(Colors.background)
            .navigationTitle(Localize.addFriends)
            .onTapGesture {
                keyboardEndEditing()
            }
            .onAppear {
                if let initUser = self.viewModel.userList.first?.title {
                    self.selectedUser = initUser
                }
            }
    }
    
    @ViewBuilder
    private func userGridView() -> some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(isFocused ? viewModel.userList : viewModel.userRecentList, id: \.self) { item in
                //LocationItemView(item: item, isSelected: selectedUser == item.title)
           }
        }
    }
}

#Preview {
    AddFriendsView()
}
