//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Mikhail Kulichkov on 14/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String
    var name: String {
        return _name
    }
    private var _pokedexID: Int
    var pokedexID: Int {
        return _pokedexID
    }
    init(name: String, pokedexID: Int) {
        _name = name
        _pokedexID = pokedexID
    }
}
