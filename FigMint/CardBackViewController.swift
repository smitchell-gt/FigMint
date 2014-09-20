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
    var backText: String!
    var cardList: [FlashCard]!
    var currentCard: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        backTextField.text = backText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BackSwipeUp" || segue.identifier == "BackSwipeDown" {
            let newCard = segue.destinationViewController as CardNewViewController
            
            
        }
    }
    
}

