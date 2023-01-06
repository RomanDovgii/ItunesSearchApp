import SwiftUI

struct SearchPlaceholderView: View {
    
    @Binding var searchTerm: String
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Search whatever you like")
                .font(.title)
        }
    }
}

struct SearchPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceholderView(searchTerm: .constant("John"))
    }
}
