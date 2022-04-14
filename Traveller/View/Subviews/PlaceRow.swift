//
//  PlaceRow.swift
//  Traveller
//
//  Created by Clément FLORET on 12/04/2022.
//

import SwiftUI

struct PlaceRow: View {
    @EnvironmentObject var placesVM: PlacesVM
    let place: PlaceVM
    
    let index: Int // The row’s index. Used to delete a row.
    let width: CGFloat = 80 // The width of all the side buttons. Used to know how much to swipe to the left.
    @State var offset = CGSize.zero // Float variable used to move a row to the left when a swipe motion occurs.
    
    var body: some View {
        GeometryReader { geometry in
            HStack (spacing : 0) {
                PlaceNav(
                    place: place,
                    coordinateRegion: .constant(placesVM.getRegion(lat: place.latitude, long: place.longitude)),
                    userTrackingMode: .constant(.none))
                .frame(width : geometry.size.width, alignment: .leading)
                ZStack {
                    Image(systemName: "trash")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .frame(width: width - 10, height: 80)
                .background(Color.red.opacity(0.8))
                .cornerRadius(20)
                .onTapGesture {
                    self.deleteItem(index: index)
                    self.offset = .zero
                }
            }
            .offset(self.offset)
            .animation(.spring())
            .gesture(DragGesture()
                  .onChanged { gesture in
                      self.offset.width = gesture.translation.width
                  }
                  .onEnded { _ in
                      if self.offset.width < -40 {
                          self.offset.width = -width
                      } else {
                          self.offset = .zero
                      }
                  }
            )
        }.frame(height: 100)
    }
    
    func deleteItem(index: Int) {
        placesVM.removePlace(index: index)
        placesVM.update()
    }
}
