//
//  MedalsView.swift
//  logostretch
//
//  Created by Emin Grbo on 10/07/2021.
//

import SwiftUI

struct MedalsView: View {
    var body: some View {
        let columns = [
            GridItem(),
            GridItem(),
            GridItem(),
            GridItem()]
        ZStack {
            Color.xpurple
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(1 ..< 61) { item in
                        Image(systemName: "rosette")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                            .padding(.bottom, 40)
                            .foregroundColor(Color(hex: "#610BCD"))
                    }
                }
                .padding(.top, 60)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MedalsView_Previews: PreviewProvider {
    static var previews: some View {
        MedalsView()
    }
}
