//
//  Scene.swift
//  AREx
//
//  Created by Michel on 11/8/17.
//  Copyright © 2017 coolnerd. All rights reserved.
//

import SpriteKit
import ARKit
import GameplayKit

class Scene: SKScene {
    
    let remainingLabel = SKLabelNode()
    var timer: Timer?
    var targetsCreated = 0
    var targetsCount = 0 {
        didSet{
            self.remainingLabel.text = "Faltan: \(targetsCount)"
        }
    }
    
    
    
    override func didMove(to view: SKView) {
        // Setup your scene here
        
        // HUD config
        remainingLabel.fontSize = 30
        remainingLabel.fontName = "System"
        remainingLabel.color = .white
        remainingLabel.position = CGPoint(x: 0, y: view.frame.midY-50)
        addChild(remainingLabel)
        
        targetsCount = 0
        
        //  Create enemies every 3 secs.
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { (timer) in
                                                                                self.createTarget()
                                                                            }
        )
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createTarget(){
        
        if targetsCreated == 25{
            timer?.invalidate()
            timer = nil
            return
        }
        
        targetsCreated += 1
        targetsCount += 1
        
        guard let sceneView = self.view as? ARSKView else {return}
        
        //1.    random number generator
        let ranNum = GKRandomSource.sharedRandom()
        //2.    matrix random x rotation
        let rotateX = SCNMatrix4ToGLKMatrix4(SCNMatrix4MakeRotation(2.0 * Float.pi * random.nextUniform() , 1, 0, 0))
        //3.    matrix random y rotation
        let rotateY = SCNMatrix4ToGLKMatrix4(SCNMatrix4MakeRotation(2.0 * Float.pi * random.nextUniform(), 0, 1, 0))
        //4.    combine both matrix
        let rotation
        //5.
        //6.
        //7.
        //8.
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
