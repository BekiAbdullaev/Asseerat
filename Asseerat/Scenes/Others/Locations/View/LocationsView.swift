//
//  LocationsView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

struct LocationsView: View {
    
    @State private var selectedLocation: String? = nil
    @State private var isFocused:Bool = false
    @State private var isActiveBtn:Bool = true
    @ObservedObject private var viewModel = LocationViewModel()
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    private let columns = [ GridItem(.flexible()) ]
    @State private var cities:[LocationModel.CitiesRows] = []
    private var address:PrayerAddress?
    @State private var city:String = ""
    @State private var country:String = ""
    public var onClick:(LocationModel.CitiesRows) -> Void
    
    
    init(prayerAddres:PrayerAddress?, onClick: @escaping (LocationModel.CitiesRows) -> Void) {
        self.address = prayerAddres
        self.onClick = onClick
    }
    
    var body: some View {
        VStack {
            SearchView(placeholder:Localize.yourLocation, isFocused: $isFocused, onChange: { text in
                checkInput(text: text)
            }).padding(.top,16).padding(.bottom, 8)
            
            HStack(alignment:.center, spacing:6) {
                Image("ic_small_location")
                    .resizable().frame(width: 18, height: 18, alignment: .center)
                TextFactory.text(type: .regular(text: "\(self.city), \(self.country)", font: .reg12, color: .seccondary, line: 2))
                Spacer()
            }.padding([.horizontal, .bottom], 16)
            
            ScrollView(.vertical, showsIndicators: false){
                self.locationGridView()
            }.onTapGesture { keyboardEndEditing() }
            .onAppear {
                if let initLocation = self.viewModel.locationList.first?.title {
                    self.selectedLocation = initLocation
                }
                if let prayerAddress = self.address {
                    self.city = prayerAddress.address?.county ?? ""
                    self.country = prayerAddress.address?.country ?? ""
                }
            }
            ButtonFactory.button(type: .primery(text: Localize.detactAutomatically, isActive: $isActiveBtn, onClick: {
                self.coordinator.pop()
            })).padding([.horizontal, .bottom], 16)
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.location)
    }
    
    @ViewBuilder
    private func locationGridView() -> some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(cities, id: \.self) { item in
                LocationItemView(item: item).onTapGesture {
                    self.onClick(item)
                    self.coordinator.pop()
                }
           }
        }
    }
    
    private func checkInput(text:String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.getLocation(name: text) { cities in
                self.cities = cities
            }
        }
    }
}
