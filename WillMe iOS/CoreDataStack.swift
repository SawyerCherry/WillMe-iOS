//
//  CoreDataStack.swift
//  WillMe iOS
//
//  Created by Rick Jacobson on 7/9/21.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // Privately store a name for the model given when initialized
    private let modelName: String
    
    // Create the managed context the first time the variable is called.
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    // MARK: - Initializer
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // Create the NSPersistentContainer
    private lazy var storeContainer: NSPersistentContainer = {
        // Initialize container
        let container = NSPersistentContainer(name: self.modelName)
        
        // Loading persistent stores is the first thing you want to do after initialization.
        container.loadPersistentStores() {(storeDescriptsion, error) in
            // Catch errors, but don't stop operation for them
            if let error = error as NSError? {
                print("Error in storeContainer initialization: \(error) \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else {return}
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error trying to save context: \(error) \(error.userInfo)")
        }
    }
}
