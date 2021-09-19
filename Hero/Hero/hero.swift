//
//  hero.swift
//  Hero
//
//  Created by René Zelada on 8/31/21.
//

import Foundation

struct hero: Decodable {
    let count: Int?
    let next: Bool?
    let previous: Bool?
    let results: [Results]
}

struct Results: Decodable {
    let name: String?
    let url: String?
}

struct Pokemon : Decodable {
    let weight: Int?
    let height: Int?
}

struct endPokemon {
    let name: String
    let weight: Int
    let height: Int
}
