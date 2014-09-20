//
//  CardFrontViewController.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/19/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit

class CardFrontViewController: UIViewController {

    var cardList = [FlashCard]()
    var currentCard: Int!
    var backText: String?
    
    let card1 = FlashCard(deck: "deck1")
    let card2 = FlashCard(deck: "deck1")
    let card3 = FlashCard(deck: "deck1")
    
    @IBOutlet weak var frontTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if (currentCard == 0) {
            addCards()
        }
        
        setCard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FrontSwipeLeft" || segue.identifier == "FrontSwipeRight" {
            let backCard = segue.destinationViewController as CardBackViewController
            
            if (cardList[currentCard].frontText != nil) {
                backCard.backText = cardList[currentCard].backText
            }
        }
    }
    
    func addCards() {
        card1.frontText = "You are amazing!"
        card1.backText = "Keep up the great work :)"
        
        card2.frontText = "You're doing a fantastic job!"
        card2.backText = "Don't get discouraged!"
        
        card3.frontText = "Your app is going to be fantastic."
        card3.backText = "Just focus on completing your goals! You can do it!!!"
        
        cardList += [card1]
        cardList += [card2]
        cardList += [card3]
        
        currentCard = 0
    }
    
    func setCard() {
        frontTextField.text = cardList[currentCard].frontText
    }
    
}

