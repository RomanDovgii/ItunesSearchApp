import Foundation
import UIKit
import CoreData
import Combine

class SongListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var songs: [Song] = [Song]()
    @Published var state: FetchState = .good
    
    private let service = APIService()
//    private let container: NSPersistentContainer
//    private var context: NSManagedObjectContext
    
    let limit: Int = 20
    var page: Int = 0
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {

        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchSongs(for: term)
            }.store(in: &subscriptions)
        
    }
    
    func clear() {
       state = .good
       songs = []
        page = 0
    }
    
    func loadMore() {
        fetchSongs(for: searchTerm)
    }
    
    func fetchSongs(for searchTerm: String) {
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        
        service.fetchSongs(searchTerm: searchTerm, page: page, limit: limit) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let results):
                        for songs in results.results {
                            self?.songs.append(songs)
//                            self?.songs.forEach { song in
//                                let task = URLSession.shared.dataTask(with: song.artworkUrl60, completionHandler: getImageFromResponse(data:response:error:))
//                                task.resume()
//                            }
                        }
                        self?.page += 1
                        self?.state = (results.results.count == self?.limit) ? .good : .loadedAll
                        print("fetched songs \(results.resultCount)")
                        
                    case .failure(let error):
                        print("Could not load: \(error)")
                        self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
    
//    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
//        guard error == nil else {
//            print("Error: \(error!)")
//            return
//        }
//
//        guard let data = data else {
//            print("No data found")
//            return
//        }
//
//        let localContext = container.newBackgroundContext()
//
//        DispatchQueue.main.async { [self] in
//            guard let loadedImage = UIImage(data: data) else {
//                return
//            }
//
//            let jpgImage = loadedImage.jpegData(compressionQuality: 1.0)
//
//            let image = SongPreview(context: localContext)
//            image.artwork = jpgImage
//            do {
//                try self.context.save()
//            } catch {
//                print(error)
//            }
//
//
//        }
//    }
    
    static func example() -> SongListViewModel {
        let vm = SongListViewModel()
        vm.songs = [Song.example()]
        return vm
    }
}
