//
//  PlaceView.swift
//  Traveller
//
//  Created by Clément FLORET on 15/03/2022.
//

import SwiftUI

struct PlaceView: View {
    var place: PlaceVM
    
    @AppStorage("units-places") var units: Units = .metric
    
    var body: some View {
        VStack {
            ScrollView {
                HoursWidget(place: place)
                WeatherWidget(place: place, units: _units)
                TranslatorWidget(place: place)
                CurrencyConverterWidget(place: place)
            }
            .padding(.vertical, 10)
            .navigationTitle(place.name)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Menu(content: {
                    Button {
                        if units == .metric {
                            self.units = .imperial
                        } else {
                            self.units = .metric
                        }
                    } label: {
                        Text(units == .metric ? "Imperial units" : "Metric units")
                    }
                }, label: {
                    if #available(iOS 15.0, *) {
                        Label("Options", systemImage: "ellipsis.circle")
                    } else {
                        Label("Options", systemImage: "ellipsis.circle")
                            .font(.title2)
                    }
                })
            }
        }
        .background(Color("BackgroundColor"))
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView(place: PlaceVM(index: 0, lat: 0, long: 0, name: "Name", adminArea: "adminArea", country: "country", secondsFromGMT: 0, isoCountryCode: ""))
            .environmentObject(UserLocationVM())
    }
}
