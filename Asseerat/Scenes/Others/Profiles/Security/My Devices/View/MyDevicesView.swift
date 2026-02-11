//
//  MyDevicesView.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 07/09/25.
//

import SwiftUI

struct MyDevicesView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = MyDeviceViewModel()
   
    @State private var myDeviceName:String = Localize.unknown
    @State private var myDeviceID:String = SecurityBean.shared.getDeviceID()
    
    var body: some View {
        VStack(alignment:.leading,spacing:16){
            TextFactory.text(type: .regular(text: Localize.yourDevices.uppercased(), font: .reg12, color: .seccondary, line: 1)).padding([.top, .horizontal], 16)
            self.deviceItems(title: myDeviceName, subtitle: myDeviceID)
            ScrollView(.vertical, showsIndicators: false){
               
            }.padding(.top,16)
        
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.myDevices)
            .onDidLoad {
                self.viewModel.getDeviceList { devices in
                    self.setDeviceItem(devices: devices)
                }
            }
    }
    

    func setDeviceItem(devices:MyDeviceModel.DeviceResponse?){
//        let myDeviceCode = SecurityBean.shared.getDeviceID()
//        if let devices = devices?.rows {
//        }
    }
    
    
    @ViewBuilder
    func deviceItems(title:String, subtitle:String) -> some View {
        ZStack {
            Colors.green
            HStack(alignment:.center, spacing: 18){
                VStack(alignment:.leading, spacing: 4){
                    TextFactory.text(type: .regular(text: title, font: .med16, line: 1))
                    TextFactory.text(type: .regular(text: subtitle, font: .reg12, color: .seccondary, line: 1))
                }.padding(.leading,16)
               
                Spacer()
                Image("ic_white_row")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(.trailing,16)
            }
        }.frame(maxWidth:.infinity).frame(height: 54)
            .cornerRadius(15, corners: .allCorners)
            .padding(.horizontal)
    }
}



