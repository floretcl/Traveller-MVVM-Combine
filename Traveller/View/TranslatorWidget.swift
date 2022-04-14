//
//  TranslatorWidget.swift
//  Traveller
//
//  Created by Clément FLORET on 21/03/2022.
//

import SwiftUI

struct TranslatorWidget: View {
    var place: PlaceVM
    
    @State var localeLangCode: String = "en"
    @State var localelangName: String = "English"
    
    @State var placeDfltLangCode: String = "??"
    @State var placeDfltLangName: String = "Unvailable"
    
    @State var showTranslatorView: Bool = false
    
    var gradient = Gradient(colors: [Color("Gradient1"), Color("Gradient2"), Color("Gradient3")])
        
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Text("Translator")
                        .font(.headline)
                    Spacer()
                    Text("\(localeLangCode.capitalized) : \(placeDfltLangCode.capitalized)")
                }
                .padding(.bottom, 2)
                .padding(.horizontal, geometry.size.width/30)
                HStack {
                    Image(systemName: "network")
                        .font(.title)
                    Text("\(localelangName) to \(placeDfltLangName)")
                }
                .padding(.top, 4)
                .padding(.horizontal, geometry.size.width/30)
                HStack {
                    Spacer()
                    Button {
                        self.showTranslatorView.toggle()
                    } label: {
                        Text("Translation")
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                    }
                    Spacer()
                }.padding(.top, 10)
            }
            .foregroundColor(.white)
            .padding(10)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 160, maxHeight: 160, alignment: .center)
            .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
            .onAppear {
                self.localeLangCode = Locale.current.languageCode ?? "en"
                self.localelangName = langAvlbleGgleTransl[localeLangCode] ?? "English"
                self.placeDfltLangCode = dfltLangCodeFromCntyCode[place.isoCountryCode] ?? "??"
                self.placeDfltLangName = langAvlbleGgleTransl[placeDfltLangCode] ?? "Unvailable"
            }
            .sheet(isPresented: $showTranslatorView) {
                // on dismiss
            } content: {
                TranslatorView(srcLangCode: $localeLangCode, tgtLangCode: $placeDfltLangCode)
            }
        }.frame(height: 180)
    }
}

struct TranslatorWidget_Previews: PreviewProvider {
    static var previews: some View {
        TranslatorWidget(place: PlaceVM(index: 0, lat: 0, long: 0, name: "Name", adminArea: "adminArea", country: "country", secondsFromGMT: 0, isoCountryCode: ""))
    }
}
