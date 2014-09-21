//
//  FlashCardManager.swift
//  FigMint
//
//  Created by Steven Mitchell on 9/20/14.
//  Copyright (c) 2014 Steven Mitchell. All rights reserved.
//

import Foundation

class DeckManager {
    
    var decks = [Deck]()
    var readyQueue: [FlashCard]?
    
    // Persistence functions
    
    lazy private var decksArchivePath: String = {
        
        let fileManager = NSFileManager.defaultManager()
        let documentsDirectoryURLs = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        let archiveURL = documentsDirectoryURLs.first!.URLByAppendingPathComponent("Decks", isDirectory: false)
        
        return archiveURL.path!
        
    }()
    
    lazy private var readyQueueArchivePath: String = {
        
        let fileManager = NSFileManager.defaultManager()
        let documentsDirectoryURLs = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        let archiveURL = documentsDirectoryURLs.first!.URLByAppendingPathComponent("Ready Queue", isDirectory: false)
        
        return archiveURL.path!
        
    }()
    
    func save() {
        NSKeyedArchiver.archiveRootObject(decks, toFile: decksArchivePath)
        if let readyQueue = readyQueue {
            NSKeyedArchiver.archiveRootObject(readyQueue, toFile: readyQueueArchivePath)
        }
    }
    
    private func unarchiveSavedDecks() {
        
        if NSFileManager.defaultManager().fileExistsAtPath(decksArchivePath) {
            let savedDecks = NSKeyedUnarchiver.unarchiveObjectWithFile(decksArchivePath) as [Deck]
            
            decks += savedDecks
        }
        
        if NSFileManager.defaultManager().fileExistsAtPath(readyQueueArchivePath) {
            if let savedReadyQueue: AnyObject = NSKeyedUnarchiver.unarchiveObjectWithFile(readyQueueArchivePath) {
                readyQueue = savedReadyQueue as? [FlashCard]
            }
        }
    }
    
    // Main functions
    
    init() {
        unarchiveSavedDecks()
        if readyQueue == nil {
            readyQueue = [FlashCard]()
            getReadyQueue()
        } else {
            getReadyQueue()
        }
    }
    
    func getReadyQueue() {
        
        if (decks.count != 0) {
            for deck in decks {
                deck.updateAll()
                readyQueue! += deck.readyQueue
            }
        }
    }
}