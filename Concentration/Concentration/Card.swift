//
//  Card.swift
//  Concentration
//
//  Created by apple on 2019/6/3.
//  Copyright © 2019 utd. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp=false
    var isMatched = false
    var identifier : Int
    static var identifierFactory = 0
    
    static func getUniqueIdentifier()->Int{
        Card.identifierFactory+=1
        return identifierFactory;
    }
    init(){
       self.identifier=Card.getUniqueIdentifier()
    }
}
