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

    var planes = [UUID: VirtualPlane]()
    var elfNode: SCNNode?
    var selectedPlane: VirtualPlane?

    @IBAction func swipeLeft() {
        performSegue(withIdentifier: "NorthPoleToSantaClaus", sender: self)
    }

    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherInfoLabel.text = "Hey, it worked!"
        fetchTemperature()
        setUpARScene()

        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        initializeElfNode()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            print("👆🏻🚫👆🏻🚫👆🏻🚫 Unable to identify touches on any plane, ignoring everything.")
            return
        }

        let touchPoint = touch.location(in: sceneView)
        // we need to make sure we are actually on a plane
        guard let plane = virtualPlaneProperlySet(touchPoint: touchPoint) else { return }
        addElfToPlane(plane: plane, at: touchPoint)
    }

    func virtualPlaneProperlySet(touchPoint: CGPoint) -> VirtualPlane? {
        let hits = sceneView.hitTest(touchPoint, types: .existingPlaneUsingExtent)
        guard hits.count > 0 else { return nil  }
        guard let firstHit = hits.first, let identifier = firstHit.anchor?.identifier, let plane = planes[identifier] else {
            return nil
        }

        selectedPlane = plane
        return plane
    }

    func addElfToPlane(plane: VirtualPlane, at point: CGPoint) {
        let hits = sceneView.hitTest(point, types: .existingPlaneUsingExtent)
        guard hits.count > 0 else { return }
        guard let firstHit = hits.first else { return }

        guard let anElf = elfNode?.clone() else { return }
        anElf.position = SCNVector3Make(firstHit.worldTransform.columns.3.x, firstHit.worldTransform.columns.3.y, firstHit.worldTransform.columns.3.z)
        sceneView.scene.rootNode.addChildNode(anElf)
    }

    func initializeElfNode() {
        let elfScene = SCNScene(named: "santa_hat_dae")
        elfNode = elfScene?.rootNode.childNode(withName: "santa_hat", recursively: false)
    }

    func setUpARScene() {
        sceneView.delegate = self
        let scene = SCNScene()
        sceneView.scene = scene

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
extension NorthPoleViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor {
            let plane = VirtualPlane(anchor: arPlaneAnchor)
            self.planes[arPlaneAnchor.identifier] = plane
            node.addChildNode(plane)
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let plane = planes[arPlaneAnchor.identifier] {
            plane.updateWithNewAnchor(anchor: arPlaneAnchor)
        }
    }
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let index = planes.index(forKey: arPlaneAnchor.identifier) {
            planes.remove(at: index)
        }
    }
}
