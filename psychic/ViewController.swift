//
//  ViewController.swift
//  psychic
//
//  Created by Chris Goodwin on 2/6/15.
//  Copyright (c) 2015 Chris Goodwin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var simpleTextField: UITextField!

    @IBOutlet weak var simpleLabel: UILabel!
    
    @IBOutlet weak var waiting: UILabel!
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.waiting.alpha = 0.0
                }, completion: {
                    (finished: Bool) -> Void in
                    
                    //Once the label is completely invisible, set the text and fade it back in
                    self.waiting.text = chooser.decider(preAnswers)
                    
                    // Fade in
                    UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                        self.waiting.alpha = 1.0
                        }, completion: nil)
            })
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.simpleLabel.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                
                //Once the label is completely invisible, set the text and fade it back in
                self.simpleLabel.text = chooser.decider(answers)
                
                // Fade in
                UIView.animateWithDuration(1.0, delay: 3.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.simpleLabel.alpha = 1.0
                    }, completion: nil)
            })
        }
    }
    
    @IBAction func changeLabel(sender: AnyObject) {
        UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.simpleLabel.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                
                //Once the label is completely invisible, set the text and fade it back in
                self.simpleLabel.text = chooser.decider(answers)
                
                // Fade in
                UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.simpleLabel.alpha = 1.0
                    }, completion: nil)
        })
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

