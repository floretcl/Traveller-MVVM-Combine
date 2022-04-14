//
//  CurrencyConverterWidget.swift
//  Traveller
//
//  Created by Clément FLORET on 21/03/2022.
//

import SwiftUI

struct CurrencyConverterWidget: View {
    @StateObject var exchangeRate = ExchangeRateVM()

    var place: PlaceVM
    
    @State var localeDfltCncyCode: String = "???"
    @State var localeDfltCncyName: String = "???"
    @State var placeDfltCncyCode: String = "Unknown"
    @State var placeDfltCncyName: String = "Unknown"
    
    @State var localeValue: String = ""
    @State var resultValue: String = ""
    
    var gradient = Gradient(colors: [Color("Gradient1"), Color("Gradient2"), Color("Gradient3")])
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Text("Currency converter")
                        .font(.headline)
                    Spacer()
                    Text("\(localeDfltCncyCode) : \(placeDfltCncyCode)")
                }
                .padding(.bottom, 2)
                .padding(.horizontal, geometry.size.width/30)
                HStack {
                    Image(systemName: "dollarsign.circle")
                        .font(.title)
                }
                .padding(.top, 4)
                .padding(.bottom, 10)
                .padding(.horizontal, geometry.size.width/30)
                VStack {
                    ZStack {
                        Text(localeDfltCncyName)
                        HStack {
                            Spacer()
                            Button {
                                // swap variables
                                (localeDfltCncyCode, placeDfltCncyCode) = (placeDfltCncyCode, localeDfltCncyCode)
                                (localeDfltCncyName, placeDfltCncyName) = (placeDfltCncyName, localeDfltCncyName)
                                (localeValue, resultValue) = (resultValue, localeValue)
                            } label: {
                                Image(systemName: "arrow.left.arrow.right")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }.padding(.trailing, 10)
                        }
                    }
                    HStack {
                        TextField("Label", text: $localeValue)
                            .foregroundColor(Color.accentColor)
                            .padding(8)
                            .padding(.horizontal, 8)
                            .background(Color("SdColor"))
                            .cornerRadius(10)
                            .padding(.horizontal, 12)
                            .disableAutocorrection(true)
                            .keyboardType(.decimalPad)
                    }
                }
                .padding(.top, -30)
                .padding(.bottom, 10)
                VStack {
                    Text(placeDfltCncyName)
                    HStack {
                        TextField("Label", text: $resultValue)
                            .foregroundColor(Color.accentColor)
                            .padding(8)
                            .padding(.horizontal, 8)
                            .background(Color("SdColor"))
                            .cornerRadius(10)
                            .padding(.horizontal, 12)
                            .disableAutocorrection(true)
                            .keyboardType(.decimalPad)
                    }
                }.padding(.bottom, 10)
                HStack {
                    Spacer()
                    Button {
                        if let value = Double(localeValue) {
                            exchangeRate.requestLatestCurrencyRate(sourceCurrency: localeDfltCncyCode, targetCurrency: placeDfltCncyCode, value: value)
                        } else {
                            exchangeRate.requestLatestCurrencyRate(sourceCurrency: localeDfltCncyCode, targetCurrency: placeDfltCncyCode, value: 1)
                            self.localeValue = "1"
                        }
                        
                    } label: {
                        Text("Conversion")
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                    }
                    Spacer()
                }
            }
            .foregroundColor(.white)
            .padding(10)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 304, maxHeight: 304, alignment: .center)
            .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
            .onChange(of: exchangeRate.latestCurrencyRate?.conversionResult, perform: { _ in
                self.resultValue = String(exchangeRate.latestCurrencyRate?.conversionResult ?? "error")
            })
            .onAppear {
                self.localeDfltCncyCode = Locale.current.currencyCode ?? "USD"
                self.localeDfltCncyName = avlDfltCncyCodeExchRate[localeDfltCncyCode] ?? "United States Dollar"
                self.placeDfltCncyCode = dfltCncyCodeFromCntyCode[place.isoCountryCode] ?? "???"
                self.placeDfltCncyName = avlDfltCncyCodeExchRate[placeDfltCncyCode] ?? "Unvailable"
            }
        }.frame(height: 324)
    }
}

struct CurrencyConverterWidget_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConverterWidget(place: PlaceVM(index: 0, lat: 0, long: 0, name: "Name", adminArea: "adminArea", country: "country", secondsFromGMT: 0, isoCountryCode: ""))
    }
}
