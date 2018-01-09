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

        sceneView.delegate = self

        weatherInfoLabel.text = "Hey, it worked!"
        fetchTemperature()
        setUpARScene()
    }

    func setUpARScene() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}

extension NorthPoleViewController: TemperatureFetching {}
extension NorthPoleViewController: ARSCNViewDelegate {}
