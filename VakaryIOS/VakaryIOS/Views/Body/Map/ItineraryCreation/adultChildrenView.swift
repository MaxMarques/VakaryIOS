//
//  adultChildrenView.swift
//  VakaryIOS
//
//  Created by Marques on 11/21/23.
//

import SwiftUI

struct adultChildrenView: View {
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
                                    itineraryCreation.timeBudget
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
                        Text(LocalizedStringKey("ItineraryV78"))
                            .font(.system(size: geometry.size.height/30, weight: .bold))
                            .foregroundColor(Color("Color5"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                    }.padding(.top, 10)
                    VStack {
                        HStack {
                            VStack {
                                Text(LocalizedStringKey("ItineraryV6"))
                                    .foregroundColor(colorBlack)
                                    .font(.system(size: geometry.size.height/40))
                                    .bold()
                                Picker("Adults", selection: $itineraryCreation.numberAdults) {
                                    ForEach(0...20, id: \.self) { number in
                                        Text("\(number)")
                                    }
                                }.pickerStyle(.wheel)
                            }
                            VStack {
                                Text(LocalizedStringKey("ItineraryV7"))
                                    .foregroundColor(colorBlack)
                                    .font(.system(size: geometry.size.height/40))
                                    .bold()
                                Picker("Kids", selection: $itineraryCreation.numberKids) {
                                    ForEach(0...20, id: \.self) { number in
                                        Text("\(number)")
                                    }
                                }.pickerStyle(.wheel)
                            }
                        }.padding(.vertical, 20)
                    }.background(Color("Color1"))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                    if itineraryCreation.numberAdults != 0 || itineraryCreation.numberKids != 0 {
                        VStack {
                            Spacer()
                            Button(action:
                                    itineraryCreation.poi
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
}

#Preview {
    adultChildrenView()
}
