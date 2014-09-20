//
//  CardFrontViewController.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/19/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit

class CardFrontViewController: UIViewController {

    var cardList: [FlashCard]!
    var currentCard: Int!
    var isStart: Bool = true
    var endOfSet: Bool = false
    var endOfList: Bool = false
    
    @IBOutlet weak var frontTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if (isStart) {
            addCards()
        }
        
        if (endOfSet && !endOfList) {
            frontTextField.text = "Great job! Go to Menu? Load 3 More Cards?"
        }
        
        else if (endOfList) {
            frontTextField.text = "Wow, you finished all cards in your queue!\nGo to Menu?"
        }
        
        else {
            setCard()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (endOfList) {
            if (identifier == "FrontSwipeLeft" || identifier == "FrontSwipeRight") {
                return false
            }
        }
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FrontSwipeLeft" || segue.identifier == "FrontSwipeRight" {
            let backCard = segue.destinationViewController as CardBackViewController
            
            if (cardList[currentCard].frontText != nil) {
                backCard.cardList = cardList
                backCard.currentCard = currentCard
            }
        }
    }
    
    func addCards() {
        
        cardList = [FlashCard]()
        
        let card1 = FlashCard(deck: "deck1")
        let card2 = FlashCard(deck: "deck1")
        let card3 = FlashCard(deck: "deck1")
        
        card1.frontText = "You are amazing!"
        card1.backText = "Keep up the great work :)"
        
        card2.frontText = "You're doing a fantastic job!"
        card2.backText = "Don't get discouraged!"
        
        card3.frontText = "Your app is going to be bigger than bigger. Fundamentally unique. Extraordinarily useful."
        card3.backText = "Just focus on completing your goals! You can do it!!!"
        
        cardList.append(card1)
        cardList.append(card2)
        cardList.append(card3)
        
        currentCard = 0
    }
    
    func setCard() {
        frontTextField.text = cardList[currentCard].frontText
    }
    
}

