//
//  TabBarIcon.swift
//  Vakary
//
//  Created by Marques on 12/08/2023.
//

import SwiftUI
import CoreLocation

struct TabBarIcon: View {
    @StateObject var routerModels: Router
    @EnvironmentObject var map: MapModel
    

    let assignedPage: Page
    let width, height: CGFloat
    let systemIconName: String
    let tabName: LocalizedStringKey

    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }.padding(.horizontal, -2)
            .onTapGesture {
                map.interestPointChoice = CLLocationCoordinate2D(latitude: 0, longitude: 0)
                routerModels.currentPage = assignedPage
                withAnimation {
                    map.annimCreateItineraryButton = false
                    map.showCreateItineraryPage = false
                    map.changeCreateItineraryButton = false
                    map.showPointInterestDetail = false
                }
            }.foregroundColor(routerModels.currentPage == assignedPage ? Color(red: 0.927, green: 0.713, blue: 0.104) : Color("Color5"))
    }
}

struct TabBarIcon_Previews: PreviewProvider {
    static var previews: some View {
        let router = Router()
        let assignedPage: Page = .map
        GeometryReader { geometry in
            TabBarIcon(routerModels: router, assignedPage: assignedPage, width: geometry.size.width/5.60, height: geometry.size.height/28, systemIconName: "person", tabName: "test")
        }
    }
}
