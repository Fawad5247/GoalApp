//
//  CoreDataModel.swift
//  Goal_HW
//
//  Created by fawad akhtar on 10/1/21.
//

import CoreData

struct CoreDataController {
    
    static let shared = CoreDataController()
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Goal_HW")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("load failed from Persistant Container", error)
            }
        }
       return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    // MARK: array for InProgress Goals
    private var entity: String {
        return "Progress"
    }
    
    var inProgress: [Progress] {
        do {
            let data = try viewContext.fetch(NSFetchRequest<Progress>(entityName: entity))
            return data
        } catch {
            print("Failed to retrieve Progress erro", error)
            return[]
        }
    }
    
    func addGoal(goal: String){
        let inProgress = NSEntityDescription.insertNewObject(forEntityName: entity, into: viewContext)
        inProgress.setValue(goal, forKey: "goal")
        save()
}
    
    // MARK: array for Completed Goals
    private var entity2: String {
        return "Completed"
    }
    
    var completed: [Completed] {
        do {
            let data = try viewContext.fetch(NSFetchRequest<Completed>(entityName: entity2))
            return data
        } catch {
            print("Failed to retrieve Progress erro", error)
            return[]
        }
    }
    func completedGoal(goal: String){
        let completed = NSEntityDescription.insertNewObject(forEntityName: entity2, into: viewContext)
        completed.setValue(goal, forKey: "goal")
        save()
}

    
    
    // MARK: - functions for remove and save
    func removeProgressGoal(goal: String){
        let fetchRequest: NSFetchRequest<Progress> = Progress.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["goal", goal])
        do{
            guard let inprogress = try viewContext.fetch(fetchRequest).first else {return}
            viewContext.delete(inprogress)
            save()
        }catch {
            print("uble to delete")
        }
    }
    
    func removeCompletedGoal(goal: String){
        let fetchRequest: NSFetchRequest<Completed> = Completed.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["goal", goal])
        do{
            guard let completed = try viewContext.fetch(fetchRequest).first else {return}
            viewContext.delete(completed)
            save()
        }catch {
            print("uble to delete")
        }
    }
    
    
    
    func save() {
        do{
            try viewContext.save()
        } catch {
            print("Unable to Save", error)
        }
        
    }
}
