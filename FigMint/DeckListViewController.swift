//
//  DeckListViewController.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/20/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit

class DeckListViewController : UITableViewController, UINavigationControllerDelegate {
    
//    var deckManager: DeckManager!
    var deckManager = DeckManager()
    var selectedDeck: Deck?
    var selectedDeckIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func study(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deckManager.decks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell") as UITableViewCell
        
        if (deckManager.decks.count > 0) {
            let deck = deckManager.decks[indexPath.row]
            cell.textLabel!.text = deck.deckName
            if (deck.isCurrent) {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
        else {
            cell.textLabel!.text = "Oh no! You don't have any decks..."
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedDeckIndex = indexPath.row
        selectedDeck = deckManager.decks[indexPath.row]
        self.performSegueWithIdentifier("SelectDeck", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "SelectDeck" {

            let editDeckController = segue.destinationViewController as EditDeckViewController
            editDeckController.index = selectedDeckIndex!
            editDeckController.deck = selectedDeck!

        }
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        
        if segue.identifier == "AddDeck" {
            
            let addDeckController = segue.sourceViewController as AddDeckViewController
            if let newDeck = addDeckController.createdDeck {
                
                deckManager.decks += [newDeck]
                if deckManager.decks.count == 1 {
                    deckManager.decks[0].isCurrent = true
                }
                deckManager.save()
                
                let indexPath = NSIndexPath(forRow: deckManager.decks.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                
            }
        }
        
        if segue.identifier == "EditDeck" {
            
            let editDeckController = segue.sourceViewController as EditDeckViewController
            let editedDeck = editDeckController.deck
            let index = editDeckController.index as Int
            deckManager.decks[index] = editedDeck
            deckManager.save()
            tableView.reloadData()
            tableView.reloadInputViews()
        }
    }
}