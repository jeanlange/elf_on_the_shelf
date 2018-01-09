//
//  NorthPoleViewController.swift
//  Elf on a Shelf
//
//  Created by Jean Lange on 1/9/18.
//  Copyright © 2018 Jean Lange. All rights reserved.
//

import ARKit
import UIKit

class NorthPoleViewController: UIViewController {

    let city  = "North_Pole"
    let state = "AK"

    @IBAction func swipeLeft() {
        performSegue(withIdentifier: "NorthPoleToSantaClaus", sender: self)
    }

    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherInfoLabel.text = "Hey, it worked!"
        fetchTemperature()

        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}

extension NorthPoleViewController: TemperatureFetching {}
