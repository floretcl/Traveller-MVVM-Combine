//
//  HoursWidget.swift
//  Traveller
//
//  Created by Clément FLORET on 21/03/2022.
//

import SwiftUI

struct HoursWidget: View {
    @EnvironmentObject var userLocationVM: UserLocationVM
    
    var place: PlaceVM
    @State var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @State var timeLag: String = ""
    @State var timeHour24: String = ""
    @State var timeHour12: String = ""
    @State var date: String = ""
    
    var gradient = Gradient(colors: [Color("Gradient1"), Color("Gradient2"), Color("Gradient3")])
        
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Text("Hours")
                        .font(.headline)
                    Spacer()
                    Text("Difference: \(timeLag)h")
                }
                .padding(.bottom, 2)
                .padding(.horizontal, geometry.size.width/30)
                HStack {
                    Label(timeHour24, systemImage: "clock.fill")
                        .font(.title)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(date)
                        Text(timeHour12)
                            .font(.body)
                    }
                }.padding(.horizontal, geometry.size.width/30)
            }
            .foregroundColor(.white)
            .padding(10)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100, alignment: .center)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
            .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
            .onAppear(perform: {
                self.timeLag = timeLag(secondsFromGMT: place.secondsFromGMT) ?? "--:--"
                self.timeHour24 = hour24h(secondsFromGMT: place.secondsFromGMT)
                self.timeHour12 = hour12h(secondsFromGMT: place.secondsFromGMT)
                self.date = date(secondsFromGMT: place.secondsFromGMT)
            })
            .onReceive(timer) { _ in
                self.timeLag = timeLag(secondsFromGMT: place.secondsFromGMT) ?? "--:--"
                self.timeHour24 = hour24h(secondsFromGMT: place.secondsFromGMT)
                self.timeHour12 = hour12h(secondsFromGMT: place.secondsFromGMT)
                self.date = date(secondsFromGMT: place.secondsFromGMT)
            }
        }.frame(height: 120)
    }
    
    func date(secondsFromGMT: Int) -> String {
        let now = Date()
        let timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.timeZone = timeZone
        return formatter.string(from: now)
    }
    func hour12h(secondsFromGMT: Int) -> String {
        let now = Date()
        let timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        formatter.timeZone = timeZone
        return formatter.string(from: now)
    }
    func hour24h(secondsFromGMT: Int) -> String {
        let now = Date()
        let timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = timeZone
        return formatter.string(from: now)
    }
    
    func timeLag(secondsFromGMT: Int) -> String? {
        if let timeZone = userLocationVM.userLocation?.timeZone {
            let actualSecondsFromGMT = timeZone.secondsFromGMT()
            let delta = actualSecondsFromGMT - secondsFromGMT
            var sign = "+"
            if delta > 0 {
                sign = "-"
            }
            let hour = Int(abs(delta) / 3600)
            let min = Int((abs(delta) % 3600) / 60)
            return "\(sign)\(hour.toTwoDigits):\(min.toTwoDigits)"
        } else {
            return nil
        }
    }
}

struct HoursWidget_Previews: PreviewProvider {
    static var previews: some View {
        HoursWidget(place: PlaceVM(index: 0, lat: 0, long: 0, name: "Name", adminArea: "adminArea", country: "country", secondsFromGMT: 0, isoCountryCode: ""))
            .environmentObject(UserLocationVM())
    }
}
