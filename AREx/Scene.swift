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
    
    let startTime = Date()
    
    
    
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
       
        guard let touch = touches.first else{return}
        let location = touch.location(in: self)
        print("\(location.x),\(location.y)")
        
        let hit = nodes(at: location)
        
        if let sprite = hit.first{
            let scaleOut = SKAction.scale(to: 2, duration: 0.4)
            let fadeOut = SKAction.fadeOut(withDuration: 0.4)
            let remove = SKAction.removeFromParent()
            
            let groupAction = SKAction.group([scaleOut, fadeOut])
            let sequenceAction = SKAction.sequence([groupAction, remove])
            
            sprite.run(sequenceAction)
            targetsCount -= 1
            
            if targetsCreated == 25 && targetsCount == 0 {
                    gameOver()
            }
            
            
        }
        
        
        
        
        
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
        let random = GKRandomSource.sharedRandom()
        //2.    matrix random x rotation
        let rotateX = simd_float4x4(SCNMatrix4MakeRotation(2.0 * Float.pi * random.nextUniform() , 1, 0, 0))
        //3.    matrix random y rotation
        let rotateY = simd_float4x4(SCNMatrix4MakeRotation(2.0 * Float.pi * random.nextUniform(), 0, 1, 0))
        //4.    combine both matrix
        let rotation = simd_mul(rotateX, rotateY)
        //5.    1.5 translation in screen direction
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1.5
        //6.    change rotation of step 4 with step 5
        let finalTransform = simd_mul(rotation,translation)
        //7.    create anchor point
        let anchor = ARAnchor(transform: finalTransform)
        //8.    add anchor to scene
        sceneView.session.add(anchor: anchor)
        
        
        
    }
    
    func gameOver(){
        
        //  hide remainingLabel
        remainingLabel.removeFromParent()
        
        //  create Game Over image
        let gameOver = SKSpriteNode(imageNamed: "gameover")
        addChild(gameOver)
        
        //  calculate Game Over Time
        let timeTaken = Date().timeIntervalSince(startTime)
        let timeTakenLabel = SKLabelNode(text: "Time taken: \(timeTaken) seconds.")
        timeTakenLabel.color = .white
        timeTakenLabel.position = CGPoint(x: +view!.frame.maxX - 50,
                                          y: -view!.frame.midY + 50)
        addChild(timeTakenLabel)
        
        
        //  show Game Over Time
        
        
    }   //  gameOver() ends

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
