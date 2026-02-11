//
//  ArchivedInfoItemView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/07/25.
//

import SwiftUI

struct ArchivedInfoItemView: View {
    
    @State private var date: Date
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter
    private let item:SunnahModel.GetClientHabitsRows
    
    private var onClick:(ArchivedHabitType) -> Void
    

    init(item:SunnahModel.GetClientHabitsRows, onClick: @escaping (ArchivedHabitType) -> Void){
        self.item = item
        self.onClick = onClick
        self._date = State(initialValue: Date())
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "MMMM yyyy"
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 8) {
            HStack {
                ZStack{
                    Image(item.icon_name ?? "ic_target")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }.frame(width: 40, height: 40, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                    ).foregroundColor(Colors.background)
                
                VStack(alignment:.leading, spacing: 4) {
                    TextFactory.text(type: .medium(text: item.name ?? Localize.unknown, font: .med16))
                    
                    TextFactory.text(type: .regular(text: "\(Localize.period): \(CompMethod().getPeriod(type: item.frequency_type ?? "0"))   \(Localize.required): \(item.required_count ?? 0)   \(Localize.completed): \(item.current_count ?? 0)", font: .reg12, color: .seccondary, line: 2))
                }
                Spacer()
            }.padding([.horizontal,.top],16)
            
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"], id: \.self) { day in
                        TextFactory.text(type: .regular(text: day, font: .reg14, color: .seccondary))
                    }
                }
                .padding([.horizontal, .top],16)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                    ForEach(daysInMonth(), id: \.self) { day in
                        if let day = day {
                            TextFactory.text(type: .regular(text: "\(day)", font: isToday(day: day) ? .sem14 : .reg14, color: isToday(day: day) ? .background : .seccondary))
                                .frame(width: 30, height: 30)
                                .background(isToday(day: day) ? .btn : Color.clear)
                                .clipShape(Circle())
                        } else {
                            Text("")
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                .padding()
            }.background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Colors.background)
                    .stroke(Colors.inputStroke, lineWidth: 1)
                    
            ).padding([.horizontal,.top])
            
           
            self.footerView()
            
        }.frame(height: 410).frame(maxWidth:.infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Colors.green)
        ).padding(.horizontal,16).padding(.top, 8)
    }
    
    @ViewBuilder
    private func footerView() -> some View {
        VStack(spacing:16){
            HStack {
                Spacer()
                HStack(alignment:.center, spacing: 8){
                    Image("ic_white_delete")
                        .resizable()
                        .frame(width: 18, height: 18)
                    TextFactory.text(type: .regular(text: Localize.delete, font: .reg14))
                }.onTapGesture {
                    self.onClick(.delete)
                }
                Spacer()
                Rectangle()
                    .fill(Colors.inputStroke)
                    .frame(width: 1, height: 24)
                Spacer()
                HStack(alignment:.center, spacing: 8){
                    Image("ic_return")
                        .resizable()
                        .frame(width: 18, height: 18)
                    TextFactory.text(type: .regular(text: Localize.unarchive, font: .reg14))
                }.onTapGesture {
                    self.onClick(.unarchive)
                }
                Spacer()
            }.frame(height: 44).frame(maxWidth:.infinity)
                .padding([.horizontal, .bottom], 10).padding(.top,4)
        }
    }
    
    private func daysInMonth() -> [Int?] {
        guard let range = calendar.range(of: .day, in: .month, for: date),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else {
            return []
        }
        
        let numberOfDays = range.count
        let firstWeekday = (calendar.component(.weekday, from: firstDay) + 5) % 7 + 1
        var days: [Int?] = Array(repeating: nil, count: firstWeekday - 1)
        days.append(contentsOf: (1...numberOfDays).map { $0 })
        let remaining = (7 - (days.count % 7)) % 7
        days.append(contentsOf: Array(repeating: nil, count: remaining))
        
        return days
    }
    
    private func isToday(day: Int) -> Bool {
        let today = calendar.component(.day, from: Date())
        let currentMonth = calendar.component(.month, from: Date())
        let calendarMonth = calendar.component(.month, from: date)
        return day == today && currentMonth == calendarMonth
    }
    

}
