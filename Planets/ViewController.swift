//
//  ViewController.swift
//  Planets
//
//  Created by Dongcheng Deng on 2018-03-24.
//  Copyright © 2018 Showpass. All rights reserved.
//

import UIKit
import  ARKit

class ViewController: UIViewController {

  @IBOutlet weak var sceneView: ARSCNView!
  
  let configuration = ARWorldTrackingConfiguration()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    sceneView.session.run(configuration)
    sceneView.autoenablesDefaultLighting = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
    sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun")
    sun.position = SCNVector3(0, 0, -1)
    
    let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth Day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2, 0, 0))
    let earthParent = SCNNode()
    
    let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon "), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
    let moonParent = SCNNode()
    
    let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
    let venusParent = SCNNode()
    
    earthParent.position = SCNVector3(0, 0, -1)
    venusParent.position = SCNVector3(0, 0, -1)
    moonParent.position = SCNVector3(1.2, 0, 0)
    
    sun.runAction(foreverRotation(duration: 8))
    earthParent.runAction(foreverRotation(duration: 14))
    venusParent.runAction(foreverRotation(duration: 10))
    earth.runAction(foreverRotation(duration: 8))
    moonParent.runAction(foreverRotation(duration: 5))
    venus.runAction(foreverRotation(duration: 8))
    
    sceneView.scene.rootNode.addChildNode(sun)
    sceneView.scene.rootNode.addChildNode(earthParent)
    sceneView.scene.rootNode.addChildNode(venusParent)
    
    earthParent.addChildNode(earth)
    earthParent.addChildNode(moonParent)
    venusParent.addChildNode(venus)
    
    moonParent.addChildNode(moon)
  }
  
  func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
    let node = SCNNode(geometry: geometry)
    node.geometry?.firstMaterial?.diffuse.contents = diffuse
    node.geometry?.firstMaterial?.specular.contents = specular
    node.geometry?.firstMaterial?.emission.contents = emission
    node.geometry?.firstMaterial?.normal.contents = normal
    node.position = position
    
    return node
  }
  
  func foreverRotation(duration: TimeInterval) -> SCNAction {
    let rotaion = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: duration)
    return SCNAction.repeatForever(rotaion)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

extension Int {
  var degreesToRadians: Double { return Double(self) * .pi/180 }
}

