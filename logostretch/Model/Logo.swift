//
//  Logo.swift
//  logostretch
//
//  Created by Emin Grbo on 04/07/2021.
//

import Foundation

struct Logo: Identifiable, Equatable {
    let id = UUID()
    let imgString: String
    let names : [String]
    var isSolved : Bool = false
}
