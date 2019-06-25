//
//  Concentration.swift
//  Concentration
//
//  Created by apple on 2019/6/3.
//  Copyright © 2019 utd. All rights reserved.
//

import Foundation

class Concentration
{
    
    var cards = Array<Card>()
    //user will touch a bunch of cards, initial it
    
    func chooseCard(at index: Int){
        if cards[index].isFaceUp{
            cards[index].isFaceUp=false
        }else{
            cards[index].isFaceUp=true
            
        }
        
    }
        //user will touch the screen to choose a card
        
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            //- syntex represent we don't care
            
            let card = Card()
            //we don't need identifier here cause we want it ui indepent
            
            cards += [card,card]
             //cards+=[card,card] equal to cards.append(card) twice.
        }
        //Shuffle cards
        
    }
   

}
