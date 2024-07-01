import Foundation
import CoreData
import Combine

class CoreDataManager: ObservableObject {
    private let persistentContainer: NSPersistentContainer
    @Published var viewContext: NSManagedObjectContext

    init() {
        persistentContainer = NSPersistentContainer(name: "FilterModel") // Replace "ModelName" with your actual model name
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        viewContext = persistentContainer.viewContext
    }

    func save(filterOptionsList: [FilterOptions]) {
        filterOptionsList.forEach { filterOptions in
            let fetchRequest: NSFetchRequest<FilterOptionsEntity> = FilterOptionsEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "camera == %@ AND rover == %@ AND date == %@", filterOptions.camera.rawValue, filterOptions.rover.rawValue, filterOptions.date as NSDate)

            do {
                let existingEntities = try viewContext.fetch(fetchRequest)
                let filterOptionsEntity: FilterOptionsEntity
                if let existingEntity = existingEntities.first {
                    filterOptionsEntity = existingEntity
                } else {
                    filterOptionsEntity = FilterOptionsEntity(context: viewContext)
                }
                filterOptionsEntity.update(with: filterOptions)
            } catch {
                print("Failed to fetch FilterOptions for saving: \(error)")
            }
        }
        saveContext()
    }

    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

extension CoreDataManager: ICoreDataAddable {
    func save(filterOptions: FilterOptions) {
        let fetchRequest: NSFetchRequest<FilterOptionsEntity> = FilterOptionsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "camera == %@ AND rover == %@ AND date == %@", filterOptions.camera.rawValue, filterOptions.rover.rawValue, filterOptions.date as NSDate)

        do {
            let existingEntities = try viewContext.fetch(fetchRequest)
            let filterOptionsEntity: FilterOptionsEntity
            if let existingEntity = existingEntities.first {
                filterOptionsEntity = existingEntity
            } else {
                filterOptionsEntity = FilterOptionsEntity(context: viewContext)
            }
            filterOptionsEntity.update(with: filterOptions)
            saveContext()
        } catch {
            print("Failed to fetch FilterOptions for saving: \(error)")
        }
    }
}

extension CoreDataManager: ICoreDataDeletable {
    func load() -> [FilterOptions] {
        let fetchRequest: NSFetchRequest<FilterOptionsEntity> = FilterOptionsEntity.fetchRequest()
        do {
            let filterOptionsEntities = try viewContext.fetch(fetchRequest)
            return filterOptionsEntities.map { $0.toFilterOptions() }
        } catch {
            print("Failed to fetch FilterOptions: \(error)")
            return []
        }
    }

    func delete(filterOptions: FilterOptions) {
        let fetchRequest: NSFetchRequest<FilterOptionsEntity> = FilterOptionsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "camera == %@ AND rover == %@ AND date == %@", filterOptions.camera.rawValue, filterOptions.rover.rawValue, filterOptions.date as NSDate)
        do {
            let filterOptionsEntities = try viewContext.fetch(fetchRequest)
            if let filterOptionsEntity = filterOptionsEntities.first {
                viewContext.delete(filterOptionsEntity)
                saveContext()
            }
        } catch {
            print("Failed to fetch FilterOptions for deletion: \(error)")
        }
    }
}

extension FilterOptionsEntity {
    func update(with filterOptions: FilterOptions) {
        self.camera = filterOptions.camera.rawValue
        self.rover = filterOptions.rover.rawValue
        self.date = filterOptions.date
    }

    func toFilterOptions() -> FilterOptions {
        return FilterOptions(camera: CameraType(rawValue: self.camera ?? "") ?? .all,
                             rover: RoverType(rawValue: self.rover ?? "") ?? .all,
                             date: self.date ?? Date())
    }
}
