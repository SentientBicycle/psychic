//
//  answerChoosen.swift
//  psychic
//
//  Created by Chris Goodwin on 2/6/15.
//  Copyright (c) 2015 Chris Goodwin. All rights reserved.
//

import Foundation

class chooser {
    
    class func decider (dict: [String]) -> String {
        var randomIndex = Int(arc4random_uniform(UInt32(dict.count)))
        var str = dict[randomIndex]
        return str
    }
    
}