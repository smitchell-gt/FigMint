//
//  FlashCard.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/19/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit
//import AVFoundation

class FlashCard: NSObject {
    
    let deck: String
    var frontText: String?
    var backText: String?
    
    init(deck: String) {
        self.deck = deck
    }

}