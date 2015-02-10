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

    let preAnswers: JSON!
    let answers:    JSON!
    let responders: JSON!

    var isActive = false


    init( responseLabel:UILabel, jsonData: JSON ){

        self.responseLabel  = responseLabel

        self.answers        = jsonData["answers"]
        self.preAnswers     = jsonData["preAnswers"]
        self.responders     = jsonData["responders"]

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
        var builtResponse = Chooser.decider(self.responders) + Chooser.decider(self.answers)

        setResponse(builtResponse, fontStyle: .lightGrayColor(),
            success: {
                let delta: Int64    = 3 * Int64(NSEC_PER_SEC)
                let time            = dispatch_time(DISPATCH_TIME_NOW, delta)

                dispatch_after(time, dispatch_get_main_queue(), {
                    self.readyForQuestion()
                });
            },
            failure: {}
        );
    }


    func readyForQuestion(){
        // Prepare for the next question.
        var builtResponse = Chooser.decider(self.preAnswers)
        setResponse(builtResponse, fontStyle: .darkGrayColor(),
            success: {
                self.isActive = false
            },
            failure: {}
        );
    }


    // Function to adjust label with contemplations
    func setResponse(newResponse: String, fontStyle: UIColor, success: () -> (), failure: () -> ()) {

        UIView.animateWithDuration(0.8, delay: 0.2, options: .CurveEaseOut, animations: {
            self.responseLabel.layer.opacity = 0.0
            }, completion: {
                finished in

                //Once the label is completely invisible, set the text and fade it back in
                self.responseLabel.text = newResponse

                // Fade in
                UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseIn, animations: {
                    self.responseLabel.layer.opacity = 1.0
                    self.responseLabel.textColor = fontStyle
                    }, completion: {
                        finished in
                        success()
                })
        })
    }
}
