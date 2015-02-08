//
//  smoker.swift
//  psychic
//
//  Created by Joel Kelly on 2/8/15.
//  Copyright (c) 2015 Sleepy Mongoose. All rights reserved.
//

import Foundation
import SpriteKit

class Smoker: SKScene {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init (imageNamed: String){
        
        let imageTexture = SKTexture(imageNamed: imageNamed)
        let smokeParticles = SKEmitterNode(fileNamed: "Smoke.sks")
        smokeParticles.hidden = true
        
        super.init ()
        
    }

}