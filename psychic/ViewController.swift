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
    var smokerNode:Smoker?
    var responder:Responder!
    var jsoned:JSON!
    
    var preAnswers:[String] = []
    
    var answers:[String] = []
    
    var responders:[String] = []
    
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
            responder.provideAnswer();
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getWithSuccess { (jsonData) -> Void in
            self.jsoned = JSON(data: jsonData)
            let answersJson = self.jsoned["answers"]
            let preAnswersJson = self.jsoned["preAnswers"]
            let respondersJson = self.jsoned["responders"]
    
            for (var i:Int = 0; i < self.jsoned["answers"].count; i++){
                self.answers.append(answersJson[i].stringValue)
            }
            for (var i:Int = 0; i < self.jsoned["preAnswers"].count; i++){
                self.preAnswers.append(preAnswersJson[i].stringValue)
            }
            for (var i:Int = 0; i < self.jsoned["responders"].count; i++){
                self.responders.append(respondersJson[i].stringValue)
            }
            self.responder = Responder(responseLabel: self.simpleLabel, answers: self.answers, preAnswers: self.preAnswers, responders: self.responders);
        }
        // Do any additional setup after loading the view, typically from a nib
    }
    
}
// Add tap functionality
// Add site functionality to add your own responses ( this would make the thing a viable app store member )
