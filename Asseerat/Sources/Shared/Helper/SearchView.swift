//
//  SearchView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 23/06/25.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText:String = ""
    @FocusState private var isInputFocused: Bool {
        didSet {
            isFocused = isInputFocused
        }
    }
    @Binding var isFocused: Bool
    var placeholder:String
    private var onChange:(String) -> Void
    
    
    init(placeholder:String, isFocused: Binding<Bool>, onChange: @escaping (String) -> Void) {
        self.placeholder = placeholder
        self._isFocused = isFocused
        self.onChange = onChange
    }
    
    var body: some View {
        ZStack {
            Colors.green
            HStack(alignment:.center, spacing: 12){
                Image("ic_search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                    .padding(.leading,16)
                ZStack {
                    if searchText.isEmpty {
                        if !isInputFocused {
                            HStack {
                                TextFactory.text(type: .regular(text: placeholder, font: .reg16, color: .seccondary, line: 1))
                                Spacer()
                            }
                        }
                    }
                    TextField("", text: $searchText)
                        .foregroundColor(Colors.white)
                        .background(.clear)
                        .focused($isInputFocused)
                        .frame(maxWidth:.infinity).frame(height: 60)
                        .onChange(of: searchText) { _,newValue in
                            self.onChange(newValue)
                        }
                   
                }
                Spacer()
                if isInputFocused {
                    Image("ic_gray_cancel")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .padding(.trailing,16)
                        .onTapGesture {
                            self.searchText = ""
                            isInputFocused.toggle()
                        }
                }
            }
        }.frame(maxWidth:.infinity).frame(height: 54)
            .cornerRadius(15, corners: .allCorners)
            .padding(.horizontal)
    }
}
