//
//  SantaClausViewController.swift
//  Elf on a Shelf
//
//  Created by Jean Lange on 1/9/18.
//  Copyright © 2018 Jean Lange. All rights reserved.
//

import UIKit

class SantaClausViewController: UIViewController {

    let city  = "Santa_Claus"
    let state = "IN"

    @IBAction func swipeRight() {
        performSegue(withIdentifier: "SantaClausToNorthPole", sender: self)
    }

    @IBOutlet weak var weatherInfoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTemperature()
    }
}

extension SantaClausViewController: TemperatureFetching {}
