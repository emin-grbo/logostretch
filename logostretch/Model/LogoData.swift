//
//  LogoData.swift
//  logostretch
//
//  Created by Emin Grbo on 07/07/2021.
//

import Foundation

struct LogoData {
    let id = UUID()
    let imgString: String
    let names: String
    let isSolved: Bool = false
    let level: Int
}
