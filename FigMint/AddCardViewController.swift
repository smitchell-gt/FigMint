//
//  AddCardViewController.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/21/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var backTextField: UITextField!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    
    var createdCard: FlashCard?
    var deckName: String!
    var frontPhoto: UIImage?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "DoneAddCard" {
            if let text = textField.text {
                if !text.isEmpty {
                    createdCard = FlashCard(deckName: deckName)
                    createdCard!.frontText = text
                }
                
                if let backText = backTextField.text {
                    if !backText.isEmpty {
                        createdCard!.backText = backText
                    }
                }
            }
        }
    }
    
    @IBAction func addImage(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
}