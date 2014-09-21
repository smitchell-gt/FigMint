//
//  AddDeckViewController.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/20/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit

class AddDeckViewController: UIViewController {
    
    @IBOutlet weak var deckName: UITextField!
    
    var createdDeck: Deck?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AddDeck" {
            
            if let name = deckName.text {
                if !name.isEmpty {
                    createdDeck = Deck(deckName: name)
                }
            }
        }
    }
    
}