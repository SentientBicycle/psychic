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
    
    @IBAction func changeLabel(sender: AnyObject) {
        simpleLabel.text = "I deem it to be!.... " + chooser.decider(answers)
        simpleTextField.text = ""
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

