//
//  CoreDataManager.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/20/17.
//  Core data class responsible for handling CRUD operations for this application
//

import CoreData

class CoreDataManager
{
    // MARK:- Properties
    
    // Singleton
    static let sharedInstance = CoreDataManager()
    private init() {}
    
    // MARK:- Public Functions
    
    // Creates or returns an existing news source for the given source ID and attributes
    func createOrGetNewsSource(sourceID: String, description: String, name: String, categoryID: String) -> NewsSource?
    {
        let context = CoreDataStack.sharedInstance.managedObjectContext
        let request = NSFetchRequest<NewsSource>(entityName: "NewsSource")
        request.predicate = NSPredicate(format: "sourceID = %@", sourceID)
        
        do
        {
            if let results = try? context.fetch(request)
            {
                if let source = results.first
                {
                    return source
                }
                else
                {
                    // this is a new news source being added to the DB
                    let newSource = NSEntityDescription.insertNewObject(forEntityName: "NewsSource", into: context) as! NewsSource
                    
                    newSource.sourceID = sourceID
                    newSource.sourceDescription = description
                    newSource.sourceName = name
                    newSource.categoryID = categoryID
                    newSource.userSelected = false
                    
                    return newSource
                }
            }
        }

        return nil
    }
    
    // Returns a list of news sources with an option for only returning sources the user has selected
    func getNewsSources(userSelectedSources: Bool) -> [NewsSource]
    {
        // set optional predicate to fetch the news sources the user has selected
        var predicate: NSPredicate? = nil
        if userSelectedSources {
            predicate = NSPredicate(format: "userSelected = %@", NSNumber(booleanLiteral: true))
        }
        
        let sources: [NewsSource] = fetchEntity(name: "NewsSource", predicate: predicate)
        return sources
    }
    
    // Returns the news source for the given ID
    func getNewsSourceForID(_ sourceID: String) -> NewsSource?
    {
        let context = CoreDataStack.sharedInstance.managedObjectContext
        let predicate = NSPredicate(format: "sourceID = %@", sourceID)
        let request = NSFetchRequest<NewsSource>(entityName: "NewsSource")
        
        request.predicate = predicate
        
        do
        {
            if let results = try? context.fetch(request)
            {
                if let source = results.first {
                    return source
                }
            }
        }
        
        return nil
    }
    
    // Delete the given news source if it exists
    func deleteNewsSource(sourceID: String)
    {
        if let source = getNewsSourceForID(sourceID) {
            CoreDataStack.sharedInstance.managedObjectContext.delete(source)
            save()
        }
    }
    
    // Save changes to context
    func save()
    {
        CoreDataStack.sharedInstance.saveContext()
    }
    
    // MARK:- Private Functions
    
    // Returns a list of the given entity from the context
    fileprivate func fetchEntity<T: NSFetchRequestResult>(name: String, predicate: NSPredicate? = nil) -> [T]
    {
        let context = CoreDataStack.sharedInstance.managedObjectContext
        let request = NSFetchRequest<T>(entityName: name)
        request.predicate = predicate
        
        do
        {
            if let results = try? context.fetch(request)
            {
                return results
            }
            
            return [T]()
        }
    }
}
