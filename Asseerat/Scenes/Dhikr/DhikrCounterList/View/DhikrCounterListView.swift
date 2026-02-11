//
//  DhikrCounterListView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 29/06/25.
//

import SwiftUI

struct DhikrCounterListView: View {
    
    @ObservedObject private var viewModel = DhikrCounterViewModel()
    @State var addDhikr:Bool = false
    @State var dhikrTemList = [DhikrCounterModel.Response.DhikrTemplateRows]()
    @State var bindedDhikrs = [DhikrsModel.Response.BindedDhikrsRows]()
    
    var body: some View {
        VStack(spacing:8){
            ScrollView(.vertical, showsIndicators: false){
                self.langGridView()
            }.padding(.top,16)
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.counterList)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    ButtonFactory.button(type: .roundedWhite(image: "ic_white_add", onClick: {
                        self.addDhikr.toggle()
                    }))
                }
            })
            .onDidLoad {
                self.viewModel.getBindedDhikrs { bindedDhikrs in
                    self.bindedDhikrs = bindedDhikrs
                    self.getDhikrs()
                }
            }
            .onDisappear{
                NotificationCenter.default.post(name: .updateBindedDhikr, object: nil)
            }
            .presentModal(displayPanModal: $addDhikr, viewHeight: 0.7) {
                AddNewDhikrView { dhikr in
                    self.viewModel.addDhikrTemplate(text: dhikr) {
                        self.getDhikrs()
                    }
                }
            }
    }
    
    @ViewBuilder
    private func langGridView() -> some View {
        LazyVGrid(columns: viewModel.columns, spacing: 12) {
            ForEach(self.dhikrTemList, id: \.self) { item in
                let isBinded = getBindedItemInfo(id: item.id ?? 0).0
                let count = getBindedItemInfo(id: item.id ?? 0).1
                DhikrCounterListItemView(item:item, isSelected: isBinded, count: count, onDelete: {
                    self.deleteDhikr(item: item)
                }) {
                    self.changeBindStatus(item: item)
                }
            }
        }.padding(.horizontal,14)
    }
    
    private func getDhikrs() {
        self.viewModel.getDhikrTemplates { teplates in
            self.dhikrTemList = teplates
        }
    }
    
    private func getBindedItemInfo(id:Int)->(Bool, Int, Int) {
        if let item = self.bindedDhikrs.filter({$0.template_id == id}).first {
            return(true, item.count ?? 0, item.id ?? 0)
        }
        return(false, 0, 0)
    }
    
    private func deleteDhikr(item:DhikrCounterModel.Response.DhikrTemplateRows) {
        infoActionAlert(title: "\(Localize.delete) \(item.text ?? "\(Localize.item)")", subtitle: "\(Localize.areYouSureToDelete) \(item.text ?? "\(Localize.thisItem)")?", lBtn: "\(Localize.no)", rBtn: "\(Localize.delete)", rBtnOnClick: {
            let id:String = String(item.id ?? 0)
            self.viewModel.deleteDhikrTemplate(id: id) {
                self.getDhikrs()
            }
        })
    }
    
    private func changeBindStatus(item:DhikrCounterModel.Response.DhikrTemplateRows) {
        let isBinded = getBindedItemInfo(id: item.id ?? 0).0

        if isBinded {
            let bindedId:String = String(getBindedItemInfo(id: item.id ?? 0).2)
            if bindedDhikrs.count > 1 {
                self.viewModel.unbindDhikr(dhikrID: bindedId) {
                    self.viewModel.getBindedDhikrs { bindedDhikrs in
                        self.bindedDhikrs = bindedDhikrs
                        self.dhikrTemList = self.dhikrTemList.map(\.self)
                    }
                }
            } else {
                showTopAlert(title: "\(Localize.youMustHaveOneDhikr)", status: .warning)
            }
            
        } else {
            let dhikrID:String = String(item.id ?? 0)
            let clientId = SecurityBean.shared.userId
            let reqBody = DhikrsModel.Request.DhikrBind(client_id: clientId, template_id: dhikrID)
            self.viewModel.bindDhikr(reqBody: reqBody) {
                self.viewModel.getBindedDhikrs { bindedDhikrs in
                    self.bindedDhikrs = bindedDhikrs
                    self.dhikrTemList = self.dhikrTemList.map(\.self)
                }
            }
        }
    }
}

