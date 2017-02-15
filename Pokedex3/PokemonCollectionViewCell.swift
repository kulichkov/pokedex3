//
//  PokemonCollectionViewCell.swift
//  Pokedex3
//
//  Created by Mikhail Kulichkov on 14/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var pokemon: Pokemon? {
        didSet {
            if pokemon != nil {
                configureCell(pokemon: pokemon!)
            }
        }
    }
    func configureCell(pokemon: Pokemon) {
        thumbImageView.image = UIImage(named: "\(pokemon.pokedexID)")
        nameLabel.text = pokemon.name
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
}
