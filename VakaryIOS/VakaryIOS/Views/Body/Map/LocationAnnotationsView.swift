//
//  LocationAnnotationsView.swift
//  Vakary
//
//  Created by Marques on 06/11/2022.
//

import SwiftUI

struct LocationAnnotationsView: View {
    let annotationColor = Color("AnnotationColor")
    var body: some View {
        VStack (spacing: 0) {
            Image(systemName: "mappin.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .font(.headline)
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color(red: 0.927, green: 0.713, blue: 0.104), Color(red: 0.112, green: 0.098, blue: 0.22))
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(red: 0.112, green: 0.098, blue: 0.22))
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

struct LocationAnnotationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationAnnotationsView()
    }
}
