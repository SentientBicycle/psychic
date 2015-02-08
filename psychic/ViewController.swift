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
    
    var isActive = false
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if (motion == .MotionShake && self.isActive != true) {
            self.isActive = true
            provideAnswer();
        }
    }
    
    func provideAnswer() {
        // Build a response and pass it to are setter.
        var builtResponse = chooser.decider(responders) + chooser.decider(answers)
        setResponse(builtResponse,
            success: {
                var delta: Int64 = 5 * Int64(NSEC_PER_SEC)
                var time = dispatch_time(DISPATCH_TIME_NOW, delta)
                dispatch_after(time, dispatch_get_main_queue(), {
                    self.readyForQuestion()
                });
            },
            failure: {}
        );
    }
    
    
    func readyForQuestion(){
        // Prepare for the next question.
        var builtResponse = chooser.decider(preAnswers)
        setResponse(builtResponse,
            success: {
                self.isActive = false
            },
            failure: {}
        );
    }

   
    // Function to adjust label with contemplations
    func setResponse(newResponse: String, success: () -> (), failure: () -> ()) {
        
        UIView.animateWithDuration(0.8, delay: 0.2, options: .CurveEaseOut, animations: {
            self.simpleLabel.layer.opacity = 0.0
            }, completion: {
                finished in
                
                //Once the label is completely invisible, set the text and fade it back in
                self.simpleLabel.text = newResponse
                
                // Fade in
                UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseIn, animations: {
                    self.simpleLabel.layer.opacity = 1.0
                    }, completion: {
                        finished in
                        success()
                })
                
                
        })
    }

    override func viewDidAppear(animated: Bool) {
        // Placeholder to start animations
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

