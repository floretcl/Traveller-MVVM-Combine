//
//  ContentView.swift
//  Traveller
//
//  Created by Clément FLORET on 15/03/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var placesVM: PlacesVM
    @EnvironmentObject var userLocationVM: UserLocationVM
    @StateObject var openWeatherVM = OpenWeatherVM()
    
    @State var searchBarText: String = ""
    @State var resetTextfieldState: Bool = false
    @State var textfieldIsEditing: Bool = false
    
    @AppStorage var units: Units
    
    @State var showAlertDeleteAllPlaces: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                    SearchBar(userLocationVM: userLocationVM, searchBarText: $searchBarText, isEditing: $textfieldIsEditing, resetTextfieldState: $resetTextfieldState)
                        .padding(.top, 12)
                        .padding(.bottom, 5)
                    SearchBarResult(userLocationVM: userLocationVM, searchBarText: $searchBarText, resetTextfieldState: $resetTextfieldState)
                        .padding(.bottom, 5)
                Section {
                    if let userLocation = userLocationVM.userLocation {
                        NavigationLink {
                            PlaceView(place: PlaceVM(location: userLocation))
                        } label: {
                            LocationNav(
                                location: userLocation,
                                coordinateRegion: .constant(userLocationVM.getRegion(location: userLocation)),
                                userTrackingMode: .constant(.follow),
                                temperature: .constant(units == .metric ? openWeatherVM.currentForecast?.temperatureCelsius ?? "--°C" : openWeatherVM.currentForecast?.temperatureFarenheit ?? "--°F" ))
                        }.onAppear {
                            self.getCurrentForecast(location: userLocation)
                        }.onChange(of: userLocation.name) { _ in
                            self.getCurrentForecast(location: userLocation)
                        }.onChange(of: units) { _ in
                            self.getCurrentForecast(location: userLocation)
                        }
                    } else if userLocationVM.authorized {
                        TemporaryLocationNav()
                    } else {
                        UnauthorizedLocationNav()
                    }
                }.padding(.bottom, 10)
                Section {
                    LazyVStack(alignment: .center, spacing: 8) {
                        ForEach(placesVM.places) { place in
                            NavigationLink {
                                PlaceView(place: place)
                            } label: {
                                PlaceRow(place: place, index: place.id)
                            }
                        }.animation(.spring())
                    }.padding(.vertical, 5)
                } header: {
                    HStack {
                        Text("My List")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.accentColor)
                            .padding(.leading, 25)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Traveller")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if #available(iOS 15.0, *) {
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
                            Button {
                                showAlertDeleteAllPlaces = true
                            } label: {
                                Text("Remove all places saved")
                            }
                        }, label: {
                            Label("Options", systemImage: "ellipsis.circle")
                        })
                        .alert("Do you want to delete all places saved?",
                            isPresented: $showAlertDeleteAllPlaces,
                            actions: {
                                Button("Ok") {
                                    placesVM.removeAllPlaces()
                                    showAlertDeleteAllPlaces = false
                                }
                        })
                    } else {
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
                            Button {
                                showAlertDeleteAllPlaces = true
                            } label: {
                                Text("Remove all places saved")
                            }
                        }, label: {
                            if #available(iOS 15.0, *) {
                                Label("Options", systemImage: "ellipsis.circle")
                            } else {
                                Label("Options", systemImage: "ellipsis.circle")
                                    .font(.title2)
                            }
                        })
                        .alert(isPresented: $showAlertDeleteAllPlaces) {
                            Alert(
                                title: Text("Do you want to delete all places saved?"),
                                primaryButton: .default(Text("Ok"), action: {
                                    placesVM.removeAllPlaces()
                                    showAlertDeleteAllPlaces = false
                                }),
                                secondaryButton: .cancel())
                        }
                    }
                }
            }.background(Color("BackgroundColor"))
        }.padding(.bottom, 2)
        .navigationBarColors(backgroundColor: UIColor(Color("NavBarBackground")), tintColor: .cyan)
        .onChange(of: resetTextfieldState) { _ in
            self.resetTextfield()
        }
    }
    
    func resetTextfield() {
        self.textfieldIsEditing = false
        self.searchBarText = ""
        userLocationVM.resetLocationFound()
        hideKeyboard()
        
        self.resetTextfieldState = false
    }
    
    func getCurrentForecast(location: UserLocation) {
        openWeatherVM.requestCurrentForecast(userLocation: location, units: units)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(units: .init(wrappedValue: .metric, "units"))
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .environmentObject(PlacesVM())
            .environmentObject(UserLocationVM())
    }
}
