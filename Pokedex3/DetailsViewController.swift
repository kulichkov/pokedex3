//
//  DetailsViewController.swift
//  Pokedex3
//
//  Created by Mikhail Kulichkov on 15/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var pokedexID: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    @IBOutlet weak var nextEvolutionLabel: UILabel!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemon.downloadPokemonFullInfo {
            self.updateUI()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func updateUI() {
        name.text = pokemon.name
        detailInfo.text = pokemon.detailInfo
        type.text = pokemon.type
        icon.image = UIImage(named: "\(pokemon.pokedexID)")
        height.text = pokemon.height
        weight.text = pokemon.weight
        defense.text = "\(pokemon.defense)"
        pokedexID.text = "\(pokemon.pokedexID)"
        baseAttack.text = "\(pokemon.attack)"

        // next evolution
        if pokemon.nextEvolutionID != 0 {
            nextEvolutionImage.image = UIImage(named: "\(pokemon.nextEvolutionID)")
            nextEvolutionLabel.text = "Next evolution: \(pokemon.nextEvolutionName)"
            nextEvolutionLabel.text = "\(nextEvolutionLabel.text!) - \(pokemon.nextEvolutionMethod)"
            if pokemon.nextEvolutionLevel != 0 {
                nextEvolutionLabel.text = "\(nextEvolutionLabel.text!)(\(pokemon.nextEvolutionLevel))"
            }
        } else {
            nextEvolutionLabel.text = "No evolutions"
            nextEvolutionImage.image = nil
        }
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
