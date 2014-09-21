//
//  Deck.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/20/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit

class Deck: NSObject, NSCoding {
    
    private struct SerializationKeys {
        static let deckName = "deckName"
        static let isCurrent = "isCurrent"
        static let cardList = "cardList"
        static let readyQueue = "readyQueue"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(deckName, forKey: SerializationKeys.deckName)
        aCoder.encodeObject(isCurrent, forKey: SerializationKeys.isCurrent)
        aCoder.encodeObject(cardList, forKey: SerializationKeys.cardList)
        aCoder.encodeObject(readyQueue, forKey: SerializationKeys.readyQueue)
    }
    
    required init(coder aDecoder: NSCoder) {
        deckName = aDecoder.decodeObjectForKey(SerializationKeys.deckName) as String
        isCurrent = aDecoder.decodeObjectForKey(SerializationKeys.isCurrent) as Bool
        cardList = aDecoder.decodeObjectForKey(SerializationKeys.cardList) as [FlashCard]
        readyQueue = aDecoder.decodeObjectForKey(SerializationKeys.readyQueue) as [FlashCard]
    }
    
    var deckName: String
    var isCurrent: Bool
    var cardList: [FlashCard]
    var readyQueue: [FlashCard]
    
    init(deckName: String) {
        self.deckName = deckName
        self.isCurrent = false
        cardList = [FlashCard]()
        readyQueue = [FlashCard]()
    }
    
    func addCard(card: FlashCard) {
        cardList += [card]
    }
    
    func updateCard(card: FlashCard) {
        
        card.checkIfDue()
        if card.isDue {
            readyQueue += [card]
        }
    }
    
    func updateAll() {
        for card in cardList {
            updateCard(card)
        }
        
        var i = 0
        while i < readyQueue.count {
            if !readyQueue[i].isDue {
                readyQueue.removeAtIndex(i)
            }
            i += 1
        }
    }
    
}