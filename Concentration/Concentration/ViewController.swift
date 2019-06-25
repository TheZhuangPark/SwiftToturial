//
//  ViewController.swift
//  Concentration
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 utd. All rights reserved.
/*
 mvc model
 m is model, handle what the game no, is ui indepedent, nothing to do with anything about ui
 c is controller, connect to m, connect to v
 v is view, handle how it's gonna show on screen.
 
 the game model need a bunch of cards and initialzer.
 
 */


import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (CardButtons.count+1)/2 )
    //lazy here represent it initialize when you use it.
    
    var flipCount = 0 {
        didSet{
              flipCountLabel.text = "Flips:\(flipCount)"
        }
    }
    //didSet to capture the change of flip Count
    
    
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var CardButtons: [UIButton]!
 //   var emojiChoices  = ["🎃","👻","🎃","👻"]
    
    
    @IBAction func touchCard(_ sender: UIButton)  {
          flipCount+=1
   
        /*-optional
         there is !, optional type problem here we use
         conditional code here to fix it, if we grab nil then
         we are not gonna continue. there is a question when we click
         the last card that is not included in CardButton collection,
         this func is still trigered.
         -data driven
         the data driven way to deal with because code driven way to depoly
         UI suck, you will get an F of it.
         -
         */
        if  let cardNumber=CardButtons.firstIndex(of: sender){
//             print("cardNUmber= \(cardNumber)");
//             flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)  //v->m
            updateViewFromModel()           //v->v
        }else{
              print("chosen card was not included");
        }
      
    }
    
    
    func updateViewFromModel(){
        for index in CardButtons.indices{
            let button=CardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                
            }
        }
    }
    
    var emojiChoices = ["🐷","🐝","🐞","🐸","🐰","🚡"]
    func emoji(for card: Card) -> String{
        
        return "?"
    }
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        print("flipCard(withEmojo: \(emoji)")
        if button.currentTitle == emoji{
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

