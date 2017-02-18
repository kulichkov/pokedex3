//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Mikhail Kulichkov on 14/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import Foundation
import Alamofire

fileprivate let baseURL = "http://pokeapi.co"
fileprivate let pokemonPartURL = "/api/v1/pokemon/"

typealias CompletionHandler = () -> ()
typealias Property = [String: AnyObject]

class Pokemon {
    private var _name: String
    var name: String {
        return _name
    }
    private var _pokedexID: Int
    var pokedexID: Int {
        return _pokedexID
    }
    private var _type: String?
    var type: String {
        return _type ?? ""
    }
    private var _detailInfo: String?
    var detailInfo: String {
        return _detailInfo ?? ""
    }
    private var _defense: Int?
    var defense: Int {
        return _defense ?? 0
    }
    private var _height: String?
    var height: String {
        return _height ?? ""
    }
    private var _weight: String?
    var weight: String {
        return _weight ?? ""
    }
    private var _attack: Int?
    var attack: Int {
        return _attack ?? 0
    }
    private var _nextEvolutionID: Int?
    var nextEvolutionID: Int {
        return _nextEvolutionID ?? 0
    }
    private var _nextEvolutionLevel: Int?
    var nextEvolutionLevel: Int {
        return _nextEvolutionLevel ?? 0
    }
    private var _nextEvolutionName: String?
    var nextEvolutionName: String {
        return _nextEvolutionName ?? ""
    }
    private var _nextEvolutionMethod: String?
    var nextEvolutionMethod: String {
        return _nextEvolutionMethod ?? ""
    }
    init(name: String, pokedexID: Int) {
        _name = name
        _pokedexID = pokedexID
    }


    func downloadPokemonFullInfo(complete: @escaping CompletionHandler) {
        let initialURL = URL(string: "\(baseURL)\(pokemonPartURL)\(self.pokedexID)")
        Alamofire.request(initialURL!).responseJSON { response in
            if let result = response.result.value as? Property {
                if let name = result["name"] as? String {
                    self._name = name.capitalized
                }
                if let types = result["types"] as? [Property], types.count > 0 {
                    if let name = types.first?["name"] as? String {
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        for index in 1..<types.count {
                            if let name = types[index]["name"] as? String {
                                self._type?.append("/\(name.capitalized)")
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                if let weight = result["weight"] as? String {
                    self._weight = weight
                }
                if let height = result["height"] as? String {
                    self._height = height
                }
                if let attack = result["attack"] as? Int {
                    self._attack = attack
                }
                if let defense = result["defense"] as? Int {
                    self._defense = defense
                }
                if let evolutions = result["evolutions"] as? [Property], evolutions.count > 0 {
                    if let resourceURI = evolutions.first?["resource_uri"] as? String {
                        let newURI = resourceURI.replacingOccurrences(of: pokemonPartURL, with: "")
                        self._nextEvolutionID = Int(newURI.replacingOccurrences(of: "/", with: ""))
                        print("_nextEvolutionID \(self.nextEvolutionID)")
                    }
                    if let to = evolutions.first?["to"] as? String {
                        self._nextEvolutionName = to
                        print("to \(to)")
                    }
                    if let level = evolutions.first?["level"] as? Int {
                        self._nextEvolutionLevel = level
                        print("level \(level)")
                    }
                    if let method = evolutions.first?["method"] as? String {
                        self._nextEvolutionMethod = method
                        print("method \(method)")
                    }
                } else {
                    self._nextEvolutionID = 0
                }
                if let descriptions = result["descriptions"] as? [Property], descriptions.count > 0 {
                    if let resource_uri = descriptions.first?["resource_uri"] as? String {
                        Alamofire.request(URL(string: baseURL.appending(resource_uri))!).responseJSON { response in
                            if let fullDescription = response.result.value as? Property {
                                if let description = fullDescription["description"] as? String {
                                    self._detailInfo = description.replacingOccurrences(of: "pokmon", with: "pokemon", options: .caseInsensitive)
                                }
                            }
                            complete()
                        }
                    }
                }
            }
            complete()
        }
    }
}
