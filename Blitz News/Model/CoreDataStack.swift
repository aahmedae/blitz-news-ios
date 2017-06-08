//
//  CoreDataStack.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/20/17.
//  Core data stack encapsulation
//

import CoreData

// Core data class for managing the core data stack
class CoreDataStack
{
    // Singleton
    static let sharedInstance = CoreDataStack()
    private init() {}
    
    // Applications default directory address
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // 1
        let modelURL = Bundle.main.url(forResource: "BlitzNews", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("BlitzNews.sqlite")
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch let  error as NSError {
            print("There was an error \(error.localizedDescription)")
            abort()
        }
        return coordinator
    }()
    
    // Core data object context
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }()
    
    // Saves changes to the context
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("There was an error \(error.localizedDescription)")
                abort() 
            }
        } 
    }
}
