//
//  testView.swift
//  logostretch
//
//  Created by Emin Grbo on 13/07/2021.
//

import SwiftUI

struct testView: View {
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.5)
            .stroke(Color.red,
                    style: StrokeStyle(lineWidth: 4, lineCap: CGLineCap.round))
            .padding(60)
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
