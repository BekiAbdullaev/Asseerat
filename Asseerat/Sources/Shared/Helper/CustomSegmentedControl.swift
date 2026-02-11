//
//  CustomSegmentedControl.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

struct CustomSegmentedControl: View {
    
    @Binding var preselectedIndex: Int
    var options: [String]
    
    var body: some View {
        HStack(spacing: 0) {
           ForEach(options.indices, id:\.self) { index in
               ZStack {
                   Rectangle()
                       .fill(Colors.green)

                   Rectangle()
                       .fill(Colors.inputStroke)
                       .cornerRadius(7)
                       .padding(4)
                       .opacity(preselectedIndex == index ? 1 : 0.01)
                       .onTapGesture {
                            withAnimation(.interactiveSpring()) {
                                preselectedIndex = index
                            }
                        }
               }
               .overlay(
                    TextFactory.text(type: .regular(text: options[index], font: .reg16, color: preselectedIndex == index ? .white : .seccondary))
               )
           }
       }
       .frame(height: 40)
       .cornerRadius(12)
    }
}
