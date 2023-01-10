//import CoreData
//import Foundation
//
//final class LocalDataService {
//
//    private lazy var container: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "SongPreview")
//        container.loadPersistentStores { _, _ in }
//        return container
//    }()
//
//    func getImages() -> [Song] {
//        let fetchRequest = SongPreview.fetchRequest()
//
//        do {
//            let images = try container.viewContext.fetch(fetchRequest)
//
//            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            let documentsDirectory = paths[0]
//
//            var imageModels: [Song] = []
//
//            for image in images {
//                guard let uuid = image.name else {
//                    continue
//                }
//                let imagePath = documentsDirectory.appending(path: uuid.uuidString)
//
//                let imageData = try Data(contentsOf: imagePath)
//
//                let imageModel = ImageCellData(image: imageData, name: uuid)
//                imageModels.append(imageModel)
//            }
//            return imageModels
//        } catch {
//            print(error)
//            return []
//        }
//    }
//
//    func saveImage(from model: Song) {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        var documentsDirectory = paths[0]
//        documentsDirectory.append(path: model.name.uuidString)
//
//        try? model.image.write(to: documentsDirectory)
//
//        let context = container.newBackgroundContext()
//
//        context.perform {
//            print("Is main thread", Thread.isMainThread)
//            let image = Image(context: context)
//            image.name = model.name
//
//            if context.hasChanges {
//                do {
//                    try context.save()
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }
//}
