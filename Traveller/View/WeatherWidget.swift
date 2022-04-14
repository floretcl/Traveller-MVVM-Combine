//
//  WeatherWidget.swift
//  Traveller
//
//  Created by Clément FLORET on 15/03/2022.
//

import SwiftUI

struct WeatherWidget: View {
    @StateObject var openWeatherVM = OpenWeatherVM()
    @StateObject var weatherImageVM = OpenWeatherImageVM()
    var place: PlaceVM
    
    @AppStorage var units: Units
    
    var gradient = Gradient(colors: [Color("Gradient1"), Color("Gradient2"), Color("Gradient3")])
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Text("Weather")
                        .font(.headline)
                    Spacer()
                    Text(openWeatherVM.placeCurrentForecast?.description.localizedCapitalized ?? "Description")
                }.padding(.horizontal, geometry.size.width/30)
                HStack {
                    Label(units == .metric ? openWeatherVM.placeCurrentForecast?.temperatureCelsius ?? "--°C" : openWeatherVM.placeCurrentForecast?.temperatureFarenheit ?? "--°F", systemImage: "thermometer")
                    Spacer()
                    Image(uiImage: weatherImageVM.uiImage ?? UIImage(systemName: "ellipsis")!)
                }
                .font(.title)
                .padding(.vertical, 5)
                .padding(.horizontal, geometry.size.width/30)
                HStack {
                    Label(units == .metric ? openWeatherVM.placeCurrentForecast?.temperatureMaxCelsius ?? "--°C" : openWeatherVM.placeCurrentForecast?.temperatureMaxFarenheit ?? "--°F", systemImage: "thermometer.sun.fill")
                    Spacer()
                    Label(openWeatherVM.placeCurrentForecast?.humidity ?? "---%", systemImage: "drop")
                }.padding(.horizontal, geometry.size.width/30)
                HStack {
                    Label(units == .metric ? openWeatherVM.placeCurrentForecast?.temperatureMinCelsius ?? "--°C" : openWeatherVM.placeCurrentForecast?.temperatureMinFarenheit ?? "--°F", systemImage: "thermometer.snowflake")
                    Spacer()
                    Label(openWeatherVM.placeCurrentForecast?.pressure ?? "--Hpa", systemImage: "gauge")
                }.padding(.horizontal, geometry.size.width/30)
                HStack {
                    Label( "\(units == .metric ? openWeatherVM.placeCurrentForecast?.windSpeedKM ?? "--Km/s" : openWeatherVM.placeCurrentForecast?.windSpeedMiles ?? "--M/h") \(openWeatherVM.placeCurrentForecast?.windDir ?? "")", systemImage: "wind")
                    Spacer()
                    Label(openWeatherVM.placeCurrentForecast?.sunrise.toHour12h ?? "--:--AM", systemImage: "sun.max.fill")
                }.padding(.horizontal, geometry.size.width/30)
                HStack {
                    Label(openWeatherVM.placeCurrentForecast?.clouds ?? "000%", systemImage: "cloud.fill")
                    Spacer()
                    Label(openWeatherVM.placeCurrentForecast?.sunset.toHour12h ?? "--:--PM", systemImage: "moon.fill")
                }.padding(.horizontal, geometry.size.width/30)
            }
            .foregroundColor(.white)
            .padding(10)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 220, maxHeight: 240, alignment: .center)
            .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
            .onAppear {
                openWeatherVM.requestCurrentForecast(lat: place.latitude, long: place.longitude, units: units)
            }.onChange(of: openWeatherVM.placeCurrentForecast?.main) { _ in
                weatherImageVM.load(iconUrl: openWeatherVM.placeCurrentForecast?.icon ?? "error")
            }.onChange(of: units) { _ in
                openWeatherVM.requestCurrentForecast(lat: place.latitude, long: place.longitude, units: units)
            }
        }.frame(height: 240)
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidget(place: PlaceVM(index: 0, lat: 0, long: 0, name: "Name", adminArea: "adminArea", country: "country", secondsFromGMT: 0, isoCountryCode: ""), units: .init(wrappedValue: .metric, "units-places"))
    }
}
