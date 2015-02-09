//
//  answerChoosen.swift
//  psychic
//
//  Created by Chris Goodwin on 2/6/15.
//  Copyright (c) 2015 Chris Goodwin. All rights reserved.
//

import Foundation

class Chooser {
    
    class func decider (collection : JSON) -> String {
        var randomIndex = Int(arc4random_uniform(UInt32(collection.count)))
        return collection[randomIndex].stringValue
    }
    
}