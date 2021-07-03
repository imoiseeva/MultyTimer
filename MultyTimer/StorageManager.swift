//
//  StorageManager.swift
//  MultyTimer
//
//  Created by Irina Moiseeva on 03.07.2021.
//

import Foundation
import CoreData

class StorageManager {
    
    static var shared = StorageManager()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init(){}
    
// MARK: - Public Methods
    func fetchData() -> [Timers] {
        let fetchRequest: NSFetchRequest<Timers> = Timers.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Timers.seconds), ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [sort]
    do {
        return try viewContext.fetch(fetchRequest)
    } catch let error {
        print("Failed to fetch data", error)
        return []
    }
        
    }
    
    // Save data
    func save(_ timerName: String, seconds: String, completion: (Timers) -> Void) {

        let timer = Timers(context: viewContext)
        timer.timersName = timerName
        timer.seconds = seconds
        
        completion(timer)
        saveContext()
    }
    
    func edit(_ timer: Timers, newName: String) {
        timer.timersName = newName
        saveContext()
    }
    
    func delete(_ timer: Timers) {
        viewContext.delete(timer)
        saveContext()
    }

    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
