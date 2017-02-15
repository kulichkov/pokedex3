//
//  ViewController.swift
//  Pokedex3
//
//  Created by Mikhail Kulichkov on 14/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var collectionView: UICollectionView!
    var pokemons: [Pokemon]!
    var musicPlayer: AVAudioPlayer!

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

    func initMusicPlayer() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // set up the action to vie selected pokemon
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let pokemonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Pokemon Cell", for: indexPath) as? PokemonCollectionViewCell {
            pokemonCell.configureCell(pokemon: pokemons[indexPath.row])
            return pokemonCell
        } else {
            return UICollectionViewCell()
        }
    }

    func parsePokemonCSV() -> [Pokemon] {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        var parsedPokemons = [Pokemon]()
        do {
            let parsedCSV = try CSV(contentsOfURL: path!)
            for eachRow in parsedCSV.rows {
                let identifier = eachRow["identifier"]!
                let id = Int(eachRow["id"]!)!
                let parsedPokemon = Pokemon(name: identifier.capitalized, pokedexID: id)
                parsedPokemons.append(parsedPokemon)
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
        return parsedPokemons.sorted{$0.name < $1.name}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemons = parsePokemonCSV()
        collectionView.delegate = self
        collectionView.dataSource = self
        initMusicPlayer()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }

}

