//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 10/06/25.
//

import SwiftUI

public func keyboardEndEditing(){
    if let windowScene = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first {
        windowScene.windows.filter { $0.isKeyWindow }.first?.endEditing(true)
    }
}
