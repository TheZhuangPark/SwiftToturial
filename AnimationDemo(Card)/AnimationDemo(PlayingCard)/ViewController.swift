//
//  ViewController.swift
//  AnimationDemo(PlayingCard)
//
//  Created by apple on 2019/6/25.
//  Copyright © 2019 utd. All rights reserved.
//

/*Bug
1 when you select two diferent cards, app may stuck. they don't turn around:
 
2 when you select one card, it may turn around and grow and vanish without comparing with another selection:
 
3
 
 
 */
import UIKit

class ViewController: UIViewController {

    private var CardDeck = PlayingCardDeck()
    @IBOutlet var CardView: [PlayingCardView]!
    lazy var animator = UIDynamicAnimator(referenceView: view)
    lazy var cardBehavior = CardBehavior(in: animator)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //models
        var CardsModel = [PlayingCard]()
        for _ in 1...((CardView.count+1)/2){
            let Tmp_Card = CardDeck.draw()!
            CardsModel += [Tmp_Card, Tmp_Card]
        }
        for cardview in CardView{
            cardview.isFaceUp = false
            let card = CardsModel.remove(at: CardsModel.count.arc4random)
            cardview.rank = card.rank.order
            cardview.suit = card.suit.rawValue
            cardview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_ :) )))
            cardBehavior.addItem(cardview)
        }
       
    }
    var lastChosenCardView: PlayingCardView?
    
    @objc private func flipCard(_ recognizer: UITapGestureRecognizer){
        switch recognizer.state {
         case .ended:
            if let chosenCardView = recognizer.view as? PlayingCardView, faceUpCardViews.count < 2 {
                lastChosenCardView = chosenCardView
                cardBehavior.removeItem(chosenCardView)
                UIView.transition(
                    with: chosenCardView,
                    duration: 0.5,
                    options: [.transitionFlipFromLeft],
                    animations: {
                        chosenCardView.isFaceUp = !chosenCardView.isFaceUp
                },
                    completion: { finished in
                        let cardsToAnimate = self.faceUpCardViews
                        if self.faceUpCardViewMatch {
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.6,
                                delay: 0,
                                options: [],
                                animations: {
                                    cardsToAnimate.forEach {
                                        $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                    }
                            },
                                completion: { position in
                                    UIViewPropertyAnimator.runningPropertyAnimator(
                                        withDuration: 0.75,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                            cardsToAnimate.forEach {
                                                $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                $0.alpha = 0
                                            }
                                    },
                                        completion: { position in
                                            cardsToAnimate.forEach {
                                                $0.isHidden = true
                                                $0.alpha = 1
                                                $0.transform = .identity
                                            }
                                    }
                                    )
                            }
                            )
                        } else if cardsToAnimate.count == 2 {
                            if chosenCardView == self.lastChosenCardView {
                                cardsToAnimate.forEach { cardView in
                                    UIView.transition(
                                        with: cardView,
                                        duration: 0.5,
                                        options: [.transitionFlipFromLeft],
                                        animations: {
                                            cardView.isFaceUp = false
                                    },
                                        completion: { finished in
                                            self.cardBehavior.addItem(cardView)
                                    }
                                    )
                                }
                            }
                        } else {
                            if !chosenCardView.isFaceUp {
                                self.cardBehavior.addItem(chosenCardView)
                            }
                        }
                }
                )
            }
        default:
            break
        }
    }
    
    private var faceUpCardViews: [PlayingCardView]{
           print("faceUpCardViews change!")
        return CardView.filter{ $0.isFaceUp && !$0.isHidden && $0.transform !=
            CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0) && $0.alpha == 1}
        
        }
    
    private var faceUpCardViewMatch : Bool{
           print("match change!")
        return faceUpCardViews.count == 2 && faceUpCardViews[0].suit == faceUpCardViews[1].suit
        && faceUpCardViews[0].rank == faceUpCardViews[1].rank
    
        
    }



}

