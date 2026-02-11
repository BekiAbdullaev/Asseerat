//
//  DhikrRatingView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 30/06/25.
//

import SwiftUI

struct DhikrRatingView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = DhikrRatingViewModel()
    @State private var selectedSegment = 0
    @State private var retingList = [DhikrRatingModel.Response.DhikrRatingRows]()
 
    var body: some View {
        VStack{
            self.topView()
            ScrollView(.vertical, showsIndicators: false){
                ForEach(retingList.indices, id: \.self) { i in
                    DhikrRatingItemView(item: retingList[i], index: i).padding(.horizontal,16)
                }
            }
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.dhikrRating)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    ButtonFactory.button(type: .roundedWhite(image: "ic_add_contact", onClick: {
                        self.coordinator.navigate(type: .dhikr(.addFriend))
                    }))
                }
            })
            .onDidLoad {
                self.getStatistics(period: "TODAY")
            }
            .onChange(of: selectedSegment) { _,newValue in
                switch newValue {
                case 0:
                    self.getStatistics(period: "TODAY")
                case 1:
                    self.getStatistics(period: "WEEKLY")
                default:
                    self.getStatistics(period: "ALL")
                }
            }
    }
    
    private func getStatistics(period:String) {
        self.viewModel.getBindedDhikrsStatistics(period:period) { retings in
            self.retingList = retings
        }
    }
    
    @ViewBuilder
    private func topView() -> some View {
        VStack{
            CustomSegmentedControl(preselectedIndex: $selectedSegment,
                                   options: [Localize.today, Localize.weekly, Localize.allTime]).padding(.vertical,16)
        }.padding(.horizontal,16)
    }
    
}
