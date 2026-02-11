//
//  TitleSegmentItem.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 15/07/25.
//

import PagerTabStripView
import SwiftUI

public class SegmentViewTheme: ObservableObject {
    
    @Published var textColor = Colors.white
    @Published var backgroundColor = Colors.green
    @Published var selectedItemColor = Colors.inputStroke
    
    public init(textColor:Color = Colors.white, backgroundColor:Color = Colors.green, selectedItemColor:Color = Colors.inputStroke) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.selectedItemColor = selectedItemColor
    }
}

public struct TitleSegmentItem: View, PagerTabViewDelegate {
    let title: String
    let isFirstItem: Bool
    let isLastItem: Bool
    
    @ObservedObject fileprivate var theme = SegmentViewTheme()
    public init(title: String, isFirstItem: Bool = false, isLastItem: Bool = false, theme: SegmentViewTheme = SegmentViewTheme()) {
        self.title = title
        self.isFirstItem = isFirstItem
        self.isLastItem = isLastItem
        self.theme = theme
    }
    
    public var body: some View {
        Color.clear.padding(.leading, 0).frame(width: 10)
        
        Text(title.localized)
            .padding(.horizontal, 16)
            .padding(.vertical, 9)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(theme.textColor)
            .background(theme.backgroundColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
            .overlay(
                Capsule()
                    .strokeBorder(theme.selectedItemColor, lineWidth: 1)
            )
        
        Color.clear.padding(.trailing, 0).frame(width: 10)
    }
    
    public func setState(state: PagerTabViewState) {
        switch state {
        case .selected:
            self.theme.textColor = Colors.white
            self.theme.backgroundColor = Colors.green
            self.theme.selectedItemColor = .clear
        case .highlighted:
            self.theme.textColor = .clear
        default:
            self.theme.textColor = Colors.white
            self.theme.backgroundColor = .green
            self.theme.selectedItemColor = Colors.inputStroke
        }
    }
}


