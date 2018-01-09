//
//  NorthPoleViewController.swift
//  Elf on a Shelf
//
//  Created by Jean Lange on 1/9/18.
//  Copyright © 2018 Jean Lange. All rights reserved.
//

import UIKit

class NorthPoleViewController: UIViewController {

    let city  = "North_Pole"
    let state = "AK"

    @IBAction func swipeLeft() {
        performSegue(withIdentifier: "NorthPoleToSantaClaus", sender: self)
    }

    @IBOutlet weak var weatherInfoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherInfoLabel.text = "Hey, it worked!"
        fetchTemperature()
    }

}

extension NorthPoleViewController: TemperatureFetching {}
