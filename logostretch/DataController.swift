import CoreData
import SwiftUI

class DataController: ObservableObject {
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "logostretch")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)

        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        
        return dataController
    }()
    
    func createSampleData() throws {
        let viewContext = container.viewContext
        
        let mockData =
        [
            LogoData(imgString: "mcdonalds", names: "mcdonalds, mc, aa", level: 1),
            LogoData(imgString: "breitling", names: "breitling, aa", level: 1),
            LogoData(imgString: "logitech", names: "logitech, aa", level: 2)
        ]

        nastaviti ovde tj konvertovati datu za odredjeni nivo, mozda i sve
        
        try viewContext.save()
    }
    
    func addLogo(data: LogoData) {
        let logo = Logo(context: container.viewContext)
        logo.id = data.id
        logo.imgString = data.imgString
        logo.isSolved = data.isSolved
        logo.level = Int16(data.level)
        save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
//    func deleteAll() {
//        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
//        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
//        _ = try? container.viewContext.execute(batchDeleteRequest1)
//
//        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = Project.fetchRequest()
//        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
//        _ = try? container.viewContext.execute(batchDeleteRequest2)
//    }
    
}
