//
//  timeBudgetView.swift
//  VakaryIOS
//
//  Created by Marques on 11/19/23.
//

import SwiftUI

struct timeBudgetView: View {
    @EnvironmentObject var itineraryCreation: ItineraryCreation
    @State private var colorBlack = Color.black
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("Color3")
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        HStack {
                            Button(action:
                                    itineraryCreation.localisationFav
                                   ,label: {
                                Image(systemName: "chevron.backward")
                                    .font(.system(size: geometry.size.height/26, weight: .bold))
                                    .foregroundColor(Color("Color2"))
                            }).padding(.top, 50)
                                .padding(.horizontal, 10)
                            Spacer()
                        }
                    }
                    VStack {
                        Text(LocalizedStringKey("ItineraryV76"))
                            .font(.system(size: geometry.size.height/30, weight: .bold))
                            .foregroundColor(Color("Color5"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                    }.padding(.top, 10)
                    VStack {
                        VStack{
                            VStack {
                                HStack {
                                    Text(LocalizedStringKey("ItineraryV2"))
                                        .foregroundColor(colorBlack)
                                        .font(.system(size: geometry.size.height/40))
                                        .bold()
                                    DatePicker("", selection: $itineraryCreation.startDate, displayedComponents: .hourAndMinute)
                                        .environment(\.locale, Locale.init(identifier: "fr"))
                                        .font(.system(size: geometry.size.height/40))
                                        .foregroundColor(colorBlack)
                                }
                            }
                            VStack {
                                HStack {
                                    Text(LocalizedStringKey("ItineraryV3"))
                                        .foregroundColor(colorBlack)
                                        .font(.system(size: geometry.size.height/40))
                                        .bold()
                                    DatePicker("", selection: $itineraryCreation.endDate, displayedComponents: .hourAndMinute)
                                        .environment(\.locale, Locale.init(identifier: "fr"))
                                        .font(.system(size: geometry.size.height/40))
                                        .foregroundColor(colorBlack)
                                }
                            }
                        }.padding(.vertical, 20)
                            .padding(.horizontal, 10)
                    }.background(Color("Color1"))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                    VStack {
                        Text(LocalizedStringKey("ItineraryV77"))
                            .font(.system(size: geometry.size.height/30, weight: .bold))
                            .foregroundColor(Color("Color5"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                    }
                    VStack {
                        VStack {
                            Text(LocalizedStringKey("ItineraryV4"))
                                .font(.system(size: geometry.size.height/40))
                                .foregroundColor(colorBlack)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal, 20)
                            Slider(
                                value: $itineraryCreation.price,
                                in: 0...1000
                            ).accentColor(Color("Color5"))
                            Text(String(format: "%.0f €", itineraryCreation.price))
                                .foregroundColor(colorBlack)
                                .font(.system(size: geometry.size.height/40))
                                .bold()
                        }.padding(.horizontal, 30)
                            .padding(.vertical, 20)
                    }.background(Color("Color1"))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                    if calculateTimeDifferenceInMinutes(startDate: itineraryCreation.startDate, endDate: itineraryCreation.endDate) != 0 {
                        VStack {
                            Spacer()
                            Button(action:
                                    itineraryCreation.adultChild
                            ,label: {
                                Text(LocalizedStringKey("SignUpV3"))
                                    .font(.title3.bold())
                                    .foregroundColor(Color("Color3"))
                                    .padding(.vertical, 22)
                                    .frame(width: geometry.size.width/1.5, height: 70)
                                    .background(Color("Color5"))
                                    .cornerRadius(100)
                            }).padding(.bottom, 15)
                            Spacer()
                            Spacer()
                        }
                    } else {
                        VStack {
                            Spacer()
                            Button {
                            } label: {
                                Text(LocalizedStringKey("SignUpV3"))
                                    .font(.title3.bold())
                                    .foregroundColor(Color("DarkGrey"))
                                    .padding(.vertical, 22)
                                    .frame(width: geometry.size.width/1.5, height: 70)
                                    .background(
                                        .linearGradient(.init(colors: [
                                            Color("Grey"),
                                            Color("Grey"),
                                        ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 35)
                                    )
                            }.padding(.bottom, 15)
                                .disabled(true)
                            Spacer()
                            Spacer()
                        }
                    }
                }
            }.edgesIgnoringSafeArea(.top)
        }
    }
    private func calculateTimeDifferenceInMinutes(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: startDate, to: endDate)

        if let minutes = components.minute {
            return abs(minutes)
        }

        return 0
    }
}

#Preview {
    timeBudgetView()
}
