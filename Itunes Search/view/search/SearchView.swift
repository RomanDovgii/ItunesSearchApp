import SwiftUI

struct SearchView: View {
    
    @State private var searchTerm: String = ""
    @State private var selectedEntityType = EntityType.all
    
    @StateObject private var albumListViewModel = AlbumListViewModel()
    @StateObject private var songListViewModel = SongListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select the media", selection: $selectedEntityType) {
                    ForEach(EntityType.allCases) { type in
                        Text(type.name())
                            .tag(type)
                    }
                    
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            
                Divider()
                
                if searchTerm.count == 0 {
                    
                    SearchPlaceholderView(searchTerm: $searchTerm)
                        .frame(maxHeight: .infinity)
                    
                } else {
                    
                    switch selectedEntityType {
                        case .all:
                            SearchAllListView(albumListViewModel: albumListViewModel,
                                              songListViewModel: songListViewModel
                            )
                            .onAppear {
                                albumListViewModel.searchTerm = searchTerm
                                songListViewModel.searchTerm = searchTerm
                            }
                            
                        case .album:
                            AlbumListView(viewModel: albumListViewModel)
                                .onAppear {
                                    albumListViewModel.searchTerm = searchTerm
                                }
                        case .song:
                            SongListView(viewModel: songListViewModel)
                                .onAppear {
                                    songListViewModel.searchTerm = searchTerm
                                }
                    }
                }

            }
            .searchable(text: $searchTerm)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .onChange(of: searchTerm) { newValue in
            
            switch selectedEntityType {
                case .all:
                    albumListViewModel.searchTerm = newValue
                    songListViewModel.searchTerm = newValue
                    
                case .album:
                    albumListViewModel.searchTerm = newValue
                    
                case .song:
                    songListViewModel.searchTerm = newValue
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
