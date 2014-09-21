//
//  CardBackViewController.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/19/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit

class CardBackViewController: UIViewController {
    
    @IBOutlet weak var backTextField: UITextView!
    @IBOutlet weak var backImageField: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    var cardList: [FlashCard]!
    var currentCard: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        backTextField.text = cardList[currentCard].backText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BackSwipeUp" || segue.identifier == "BackSwipeDown" {
            let newCard = segue.destinationViewController as CardFrontViewController
            newCard.isStart = false
            
            if segue.identifier == "BackSwipeUp" {
                cardList[currentCard].isDue = false
                cardList[currentCard].nextBox()
                cardList[currentCard].updateDueDate()
            }
            
            if segue.identifier == "BackSwipeDown" {
                cardList[currentCard].isDue = true
                cardList[currentCard].resetBox()
                cardList[currentCard].updateDueDate()
            }
            
            currentCard = currentCard.successor()
            if (currentCard < cardList.count) {
                if (currentCard % 3 == 0) {
                    newCard.endOfSet = true
                }
                newCard.cardList = cardList
                newCard.currentCard = currentCard
            }
            else {
                newCard.endOfList = true
            }
        }
    }
    
}

