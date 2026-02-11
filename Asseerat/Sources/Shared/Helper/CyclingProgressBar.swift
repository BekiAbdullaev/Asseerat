//
//  CyclingProgressBar.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 19/06/25.
//

import SwiftUI

struct CyclingProgressBar: View {
    @State private var progress: CGFloat
    private var cycleItem:CycleItems
    
    init(cycleItem:CycleItems, progress:CGFloat) {
        self.cycleItem = cycleItem
        self.progress = progress
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(cycleItem.lineBgColor, style: StrokeStyle(lineWidth: cycleItem.lineWith, lineCap: .round))
                .frame(width: cycleItem.size, height: cycleItem.size)
                .background(
                    Circle().fill(progress == 1 ? cycleItem.lineColor : .clear)
                )

            Circle()
                .trim(from: 0, to: cycleItem.progress)
                .stroke(cycleItem.lineColor, style: StrokeStyle(lineWidth: cycleItem.lineWith, lineCap: .round))
                .frame(width: cycleItem.size, height: cycleItem.size)
                .rotationEffect(.degrees(-90))
            
            TextFactory.text(type: .medium(text: cycleItem.title, font: .sem14, color: (progress == 0.0 || progress == 1.0) ? .background : .white, line: 1))
        }
    }
}
