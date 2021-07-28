import CoreData
import SwiftUI

class MainDO {
    
    @AppStorage(StorageKeys.dataVersion.rawValue) var dataVersion = 0
    
    let container: NSPersistentCloudKitContainer
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
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
    
    func createSampleData() {
        print("DATAVERSION: \(dataVersion)")
        guard fetchAllQuestions().count == 0,
              dataVersion <= 1
        else { return }

        let mockData: Set<LogoData> = [
        LogoData(imgString: "mcdonalds", names: "mcdonalds, mc, aa", level: 1),
        LogoData(imgString: "breitling", names: "breitling, aa", level: 1),
        LogoData(imgString: "logitech", names: "logitech, aa", level: 1),
        LogoData(imgString: "adidas", names: "adidas, aa", level: 1),
        LogoData(imgString: "mercedes", names: "mercedes, aa", level: 1),
        LogoData(imgString: "cocacola", names: "cocacola, coca-cola, aa", level: 1),
        LogoData(imgString: "google", names: "google, aa", level: 1),
        LogoData(imgString: "rolex", names: "rolex, aa", level: 1),
        
        LogoData(imgString: "audi", names: "audi, aa", level: 2),
        LogoData(imgString: "mini", names: "mini, minicooper, aa", level: 2),
        LogoData(imgString: "burgerking", names: "burgerking, aa", level: 2),
        LogoData(imgString: "pizzahut", names: "pizzahut, aa", level: 2)
        ]

        let viewContext = container.viewContext
        
        for logo in mockData {
            let cdLogo = Logo(context: viewContext)
            cdLogo.id = logo.id
            cdLogo.imgString = logo.imgString
            cdLogo.isSolved = logo.isSolved
            cdLogo.level = Int16(logo.level)
            cdLogo.names = logo.names
            print("=== save logo: \(logo)")
        }
        save()
        dataVersion = 1
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    func fetchQuestionsForLevel(_ level: Int) -> [Logo] {
        let fetchRequest: NSFetchRequest<Logo> = Logo.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "%K == %d", #keyPath(Logo.level), level)
        
        do {
            let questions = try container.viewContext.fetch(fetchRequest)
            print("********** GOT: \(questions.count) **********")
            return questions
        } catch {
            return []
        }
    }
    
    func fetchAllQuestions() -> [Logo] {
        let fetchRequest: NSFetchRequest<Logo> = Logo.fetchRequest()
        do {
            let questions = try container.viewContext.fetch(fetchRequest)
            return questions
        } catch {
            return []
        }
    }
    
    func updateQuestion(_ question: String) {
        let fetchRequest: NSFetchRequest<Logo> = Logo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %d", #keyPath(Logo.imgString), question)
        let question = try? container.viewContext.fetch(fetchRequest).first
        question?.isSolved = true
        save()
    }
    
    func deleteAll() {
        dataVersion = 0
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Logo.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
    }
    
}
