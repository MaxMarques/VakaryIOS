//
//  LoaderComponent.swift
//  VakaryIOS
//
//  Created by Marques on 12/20/23.
//

import SwiftUI

struct LoaderComponent: View {
    @State private var spin3D_x = false
    @State private var spin3D_y = false
    @State private var spin3D_xy = false
    @State private var colorBlue = Color(red: 0.112, green: 0.098, blue: 0.22)
    @State private var colorGold = Color(red: 0.927, green: 0.713, blue: 0.104)
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 60, height: 60)
                .foregroundColor(colorBlue)
                .rotation3DEffect(.degrees(spin3D_x ? 180 : 1), axis: (x: spin3D_x ? 1 : 0, y: 0, z: 0))
                .onAppear() {
                    withAnimation((Animation.easeOut(duration: 1).repeatForever(autoreverses:false))) {
                        self.spin3D_x.toggle()
                    }
                }
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 30, height: 30)
                .foregroundColor(colorBlue)
                .rotation3DEffect(.degrees(spin3D_y ? 360 : 1), axis: (x: 0, y: spin3D_y ? 1: 0, z: 0))
                .onAppear() {
                    withAnimation((Animation.easeOut(duration: 1).repeatForever(autoreverses:false))) {
                        self.spin3D_y.toggle()
                    }
                }
            Circle()
                .stroke(lineWidth: 4)
                .frame(width: 10, height: 10)
                .foregroundColor(colorGold)
                .rotation3DEffect(.degrees(spin3D_xy ? 180: 1), axis: (x: spin3D_xy ? 0 : 1, y: spin3D_xy ? 0 : 1, z: 0))
                .onAppear() {
                    withAnimation((Animation.easeOut(duration: 1).repeatForever(autoreverses:false))) {
                        self.spin3D_xy.toggle()
                    }
                }
        }
    }
}

#Preview {
    LoaderComponent()
}
