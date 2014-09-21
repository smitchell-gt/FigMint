//
//  CardFrontViewController.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/19/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit

class CardFrontViewController: UIViewController {
    
    @IBOutlet weak var frontTextField: UITextView!
    @IBOutlet weak var frontImageField: UIImageView!
    @IBOutlet weak var frontButton: UIButton!
    
    var deckManager = DeckManager()
    var cardList: [FlashCard]!
    var currentCard: Int!
    
    var isStart: Bool = true
    var endOfSet: Bool = false
    var endOfList: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start the study session
        if isStart || endOfSet || endOfList {
            for deck in deckManager.decks {
                deck.updateAll()
            }
        }
        
        if isStart {
            startSession()
        }
        
        // If you finished your set, but there are still cards in your ready queue
        if endOfSet && !endOfList {
            frontTextField.text = "Great job! Load 3 More Cards?"
            frontButton.setTitle("Finish Session", forState: UIControlState.Normal)
        }
        
        // If there are no cards in your ready queue
        else if endOfList {
            frontTextField.text = "Wow, you finished all cards in your queue!"
            frontButton.sizeToFit()
            frontButton.setTitle("Proceed to Menu", forState: UIControlState.Normal)
        }
        
        // Otherwise, load the current card
        else {
            frontTextField.text = cardList[currentCard].frontText
            
            if let photo = cardList[currentCard].frontPhoto {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if endOfList {
            if identifier == "FrontSwipeLeft" || identifier == "FrontSwipeRight" {
                return false
            }
        }
        
        if identifier == "LoadDeckList" {
            if !endOfList || !endOfSet {
                if frontButton.titleLabel?.text != "Finish Session" && frontButton.titleLabel?.text != "Proceed to Menu" {
                    return false
                }
            }
        }
    
        return true
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "FrontSwipeLeft" || segue.identifier == "FrontSwipeRight" {
            
            let backCard = segue.destinationViewController as CardBackViewController
            
            if cardList[currentCard].frontText != nil {
                backCard.cardList = cardList
                backCard.currentCard = currentCard
            }
        }
    }
    
    func startSession() {
        
        if deckManager.decks.count == 0 {
            endOfSet = true
            endOfList = true
        } else {
            cardList = deckManager.readyQueue
            
            if cardList.count == 0 {
                endOfSet = true
                endOfList = true
            }
            
            currentCard = 0
        }
    }
}

