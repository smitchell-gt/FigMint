//
//  FlashCard.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/19/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit
//import AVFoundation

class FlashCard: NSObject, NSCoding {
    
    private struct SerializationKeys {
        static let frontText = "frontText"
        static let backText = "backText"
        static let dueDate = "dueDate"
        static let isDue = "isDue"
        static let leitnerBox = "leitnerBox"
        static let frontPhoto = "frontPhoto"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(frontText!, forKey: SerializationKeys.frontText)
        aCoder.encodeObject(backText!, forKey: SerializationKeys.backText)
        aCoder.encodeObject(dueDate, forKey: SerializationKeys.dueDate)
        aCoder.encodeObject(isDue, forKey: SerializationKeys.isDue)
        aCoder.encodeObject(leitnerBox, forKey: SerializationKeys.leitnerBox)
        if let photo = frontPhoto {
            aCoder.encodeObject(photo, forKey: SerializationKeys.frontPhoto)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        frontText = aDecoder.decodeObjectForKey(SerializationKeys.frontText) as? String
        backText = aDecoder.decodeObjectForKey(SerializationKeys.backText) as? String
        dueDate = aDecoder.decodeObjectForKey(SerializationKeys.dueDate) as NSDate
        isDue = aDecoder.decodeObjectForKey(SerializationKeys.isDue) as Bool
        leitnerBox = aDecoder.decodeObjectForKey(SerializationKeys.leitnerBox) as Int
        frontPhoto = aDecoder.decodeObjectForKey(SerializationKeys.frontPhoto) as? UIImage
    }
    
    var frontText: String?
    var backText: String?
    var frontPhoto: UIImage?
    
    var dueDate: NSDate     // dueDate: When the card was last tested
    var isDue: Bool         // isDue: If true, the card should be tested
    var leitnerBox: Int     // leitnerBox: Which "box" the flashcard is in. For more info, read about the Leitner System
    
    init(deckName: String) {
        self.dueDate = NSDate()
        self.isDue = true
        self.leitnerBox = 0
    }
    
    func preview() -> String {
        
        if let cardText: NSString = frontText {
            if cardText.length > 25 {
                return cardText.substringToIndex(25)
            } else {
                return cardText.substringToIndex(cardText.length)
            }
        }
        
        return ""
        
    }
    
    func checkIfDue() {
        
        let now: NSString = NSDate().description
        let past: NSString = dueDate.description
        
        let nowYear: NSString = now.substringToIndex(4)
        
        var nowMonth: NSString = now.substringToIndex(7)
        nowMonth = nowMonth.substringFromIndex(5)
        
        var nowDay: NSString = now.substringToIndex(10)
        nowDay = nowDay.substringFromIndex(8)
        
        let pastYear: NSString = past.substringToIndex(4)
        
        var pastMonth: NSString = past.substringToIndex(7)
        pastMonth = pastMonth.substringFromIndex(5)
        
        var pastDay: NSString = past.substringToIndex(10)
        pastDay = pastDay.substringFromIndex(8)
        
        let nowYearNum = nowYear.description.toInt()
        let nowMonthNum = nowMonth.description.toInt()
        let nowDayNum = nowDay.description.toInt()
        
        let pastYearNum = pastYear.description.toInt()
        let pastMonthNum = pastMonth.description.toInt()
        let pastDayNum = pastDay.description.toInt()
        
        if nowYearNum > pastYearNum {
            isDue = true
        } else if nowYearNum == pastYearNum {
            if nowMonthNum > pastMonthNum {
                isDue = true
            } else if nowMonthNum == pastMonthNum {
                if nowDayNum >= pastDayNum {
                    isDue = true
                } else {
                    isDue = false
                }
            } else {
                isDue = false
            }
        } else {
            isDue = false
        }
    }
    
    func updateDueDate() {
        
        var waitTime: NSTimeInterval
        var oneDay: NSTimeInterval = 60 * 60 * 24
        
        switch leitnerBox {
        case 1:
            waitTime = oneDay
        case 2:
            waitTime = 3*oneDay
        case 3:
            waitTime = 7*oneDay
        case 4:
            waitTime = 14*oneDay
        case 5:
            waitTime = 28*oneDay
        case 6:
            waitTime = 56*oneDay
        case 7:
            waitTime = 84*oneDay
        case 8:
            waitTime = 168*oneDay
        default:
            waitTime = 0
        }
        
        dueDate = NSDate(timeInterval: waitTime, sinceDate: dueDate)
        
    }
    
    func nextBox() {
        
        leitnerBox += 1
        
        if leitnerBox > 8 {
            leitnerBox = 8
        }
    }
    
    func resetBox() {
        leitnerBox = 0
    }
}