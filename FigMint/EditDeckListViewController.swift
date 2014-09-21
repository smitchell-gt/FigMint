//
//  EditDeckListViewController.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/20/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit

class EditDeckViewController : UIViewController, UINavigationControllerDelegate, UITableViewDelegate {
    
    @IBOutlet weak var deckNameField: UITextField!
    @IBOutlet weak var isCurrentField: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    var index: Int!
    var deck: Deck!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        deckNameField.text = deck.deckName
        isCurrentField.on = deck.isCurrent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deck.cardList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AddCardCell") as UITableViewCell
        
        if (deck.cardList.count > 0) {
            let card = deck.cardList[indexPath.row]
            cell.textLabel!.text = card.preview()
        }
        else {
            cell.textLabel!.text = "Oh no! You don't have any cards..."
        }
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "EditDeck" {
            
            if deckNameField.text != nil {
                deck.deckName = deckNameField.text
            }
            
            if isCurrentField.on {
                deck.isCurrent = true
            } else {
                deck.isCurrent = false
            }
        }
        
        if segue.identifier == "AddCard" {
            let addCardController = segue.destinationViewController as AddCardViewController
            addCardController.deckName = deck.deckName
        }
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        
        if segue.identifier == "DoneAddCard" {
            
            let addCardController = segue.sourceViewController as AddCardViewController
            if let newCard = addCardController.createdCard {
                
                deck.cardList += [newCard]
                
                let indexPath = NSIndexPath(forRow: deck.cardList.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
}