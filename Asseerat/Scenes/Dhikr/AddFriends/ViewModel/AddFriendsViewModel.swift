//
//  AddFriendsViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 30/06/25.
//

import Foundation

struct AddFriendsViewModel {
    let userRecentList = [SearchItem(title: "Alisher Khudoerov", subtile: "", isRecent: true),
                              SearchItem(title: "Robert Jobson", subtile: "", isRecent: true),
                              SearchItem(title: "Kim Richard", subtile: "", isRecent: true)]
    
    let userList = [SearchItem(title: "Alisher Khudoerov", subtile: "+7 (415) 555-0123", isRecent: false),
                        SearchItem(title: "Alisher Khudoerov", subtile: "+7 (415) 555-0123", isRecent: false)]
}
