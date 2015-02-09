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
    var responder:Responder!

    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func viewDidAppear(animated: Bool) {
        // Placeholder to start animations
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        networkManager.getWithSuccess("http://sleepymongoose.build/data.json" , { (jsonData) -> Void in
            
            var returnedJson:JSON!  = JSON(data: jsonData)
            self.responder          = Responder(responseLabel: self.simpleLabel, jsonData: returnedJson);
            
        })
    
    }

}
// Add tap functionality
// Add site functionality to add your own responses ( this would make the thing a viable app store member )
