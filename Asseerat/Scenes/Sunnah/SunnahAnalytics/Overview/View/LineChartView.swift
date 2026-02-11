//
//  LineChartView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 08/08/25.
//

import SwiftUI

struct LineChartView: View {
    
    private let data: [Double]
    private let maxY:Double
    private let minY:Double
    private let lineColor:Color
    private var viewModel:AnalyticsOverviewViewModel?
    @State private var lineChartPercent:CGFloat = 0
    @State private var days = [String]()
    
    init(model:AnalyticsOverviewViewModel) {
        viewModel = model
        data = model.persentages
        maxY = data.max() ?? 0.0
        minY = data.min() ?? 0.0
        let perChanges = (data.last ?? 0) - (data.first ?? 0)
        lineColor = perChanges >= 0 ? Colors.btnColor : Colors.alertError
    }
    
    var body: some View {
        VStack(spacing:10){
            VStack {
                chartView.frame(height: 200)
            }.padding(.leading, 40).padding(.trailing, 13)
            .overlay (chartYAxis, alignment: .leading)
            chartXAxis
        }
        .onAppear {
            days = viewModel?.pastSevenDaysInfo().days ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.linear(duration: 2.0)) {
                    lineChartPercent = 1
                }
            }
        }
    }
    
}

extension LineChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x:xPosition, y:yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: lineChartPercent)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0.3), radius: 5, x: 0.0, y: 5)
            .shadow(color: lineColor.opacity(0.1), radius: 5, x: 0.0, y: 10)
          
        }
    }
    
    private var chartYAxis: some View {
        VStack{
            TextFactory.text(type: .regular(text: "100%", font: .reg14, color: .seccondary))
            Spacer()
            TextFactory.text(type: .regular(text: "75%", font: .reg14, color: .seccondary))
            Spacer()
            TextFactory.text(type: .regular(text: "50%", font: .reg14, color: .seccondary))
            Spacer()
            TextFactory.text(type: .regular(text: "25%", font: .reg14, color: .seccondary))
            Spacer()
            TextFactory.text(type: .regular(text: "0%", font: .reg14, color: .seccondary))
        }.padding(.leading, 16)
    }
    
    private var chartXAxis: some View {
        HStack {
            ForEach(days.indices, id:\.self) { i in
                TextFactory.text(type: .regular(text: days[i], font: .reg12, color: .seccondary))
                if days[i] != "Today" {
                    Spacer()
                }
            }
        }.padding(.trailing, 13).padding(.bottom, 16).padding(.leading, 50)
    }
    
}


