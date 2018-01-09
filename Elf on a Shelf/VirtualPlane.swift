//
//  VirtualPlane.swift
//  Elf on a Shelf
//
//  Created by Jean Lange on 1/9/18.
//  Copyright © 2018 Jean Lange. All rights reserved.
//

import ARKit
import UIKit

class VirtualPlane: SCNNode {
    var anchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // fires when new nodes are added
    init(anchor: ARPlaneAnchor) {
        super.init()

        self.anchor = anchor
        planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))

        planeGeometry.materials = [initializePlaneMaterial()]

        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        //math for 2d to 3d coordinate system
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)

        updatePlaneMaterialDimensions()
        addChildNode(planeNode)
    }

    func initializePlaneMaterial() -> SCNMaterial {
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white.withAlphaComponent(0.50)

        return material
    }

    func updatePlaneMaterialDimensions() {
        let material = planeGeometry.materials.first
        let width = Float(planeGeometry.width)
        let height = Float(planeGeometry.height)

        material?.diffuse.contentsTransform = SCNMatrix4MakeScale(width, height, 1.0)
    }

    // fires when camera moves or objects in view move
    func updateWithNewAnchor(anchor: ARPlaneAnchor) {
        planeGeometry.width = CGFloat(anchor.extent.x)
        planeGeometry.height = CGFloat(anchor.extent.z)

        position = SCNVector3(anchor.center.x, 0, anchor.center.z)

        updatePlaneMaterialDimensions()
    }

    // fires when notes are deleted
}
