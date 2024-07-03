//
//  FaceIDComponent.swift
//  VakaryIOS
//
//  Created by Marques on 29/08/2023.
//

import SwiftUI

struct FaceIDComponent: View {
    var image: String?
    var size: CGFloat?
    @State private var colorWhite = Color.white

    var body: some View {
        Image(image ?? "person.fill")
            .resizable()
            .frame(width: size, height:  size)
            .padding()
    }
}

struct FaceIDComponent_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDComponent()
    }
}
