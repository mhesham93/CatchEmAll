//
//  Creature.swift
//  CatchEmAll
//
//  Created by Mohamed Said on 12/9/22.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String
}
