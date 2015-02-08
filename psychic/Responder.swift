//
//  Responder.swift
//  psychic
//
//  Created by Joel Kelly on 2/8/15.
//  Copyright (c) 2015 Sleepy Mongoose. All rights reserved.
//

import Foundation
import UIKit

class Responder {
    
    var responseLabel:UILabel
    var isActive = false
    
    
    init( responseLabel:UILabel ){
        self.responseLabel = responseLabel
    }
    
    func getStatus() -> Bool{
        return self.isActive
    }
    func setStatus(newStatus: Bool){
        self.isActive = newStatus
    }
    
    func provideAnswer() {
        self.setStatus(true)
        
        // Build a response and pass it to are setter.
        var builtResponse = chooser.decider(responders) + chooser.decider(answers)
        setResponse(builtResponse,
            success: {
                let delta: Int64 = 5 * Int64(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, delta)
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
            self.responseLabel.layer.opacity = 0.0
            }, completion: {
                finished in
                
                //Once the label is completely invisible, set the text and fade it back in
                self.responseLabel.text = newResponse
                
                // Fade in
                UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseIn, animations: {
                    self.responseLabel.layer.opacity = 1.0
                    }, completion: {
                        finished in
                        success()
                })
        })
    }
}
