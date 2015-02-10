//
//  ViewController.swift
//  psychic
//
//  Created by Chris Goodwin on 2/6/15.
//  Copyright (c) 2015 Chris Goodwin. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {


    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var startText: UILabel!
    var responder:Responder!


    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func viewDidAppear(animated: Bool) {
        // Placeholder to start animations
        UIView.animateWithDuration(2, delay: 3, options: .CurveLinear, animations: {
            self.startText.layer.opacity = 0.0
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }


    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if (motion == .MotionShake && responder.getStatus() != true) {
            responder.provideAnswer()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if (responder.getStatus() != true) {
            responder.provideAnswer()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        networkManager.getWithSuccess("https://charlatan.firebaseio.com/rude.json" , { (jsonData) -> Void in
            
            var returnedJson:JSON!  = JSON(data: jsonData)
            self.responder          = Responder(responseLabel: self.simpleLabel, jsonData: returnedJson);
            
        })
    
    }

}

// Add site functionality to add your own responses ( this would make the thing a viable app store member )
