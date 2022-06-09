import SwiftUI
 
struct SearchView: View {
    let array = [
        "김서근", "포뇨", "하울", "소피아", "캐시퍼", "소스케",
        "치히로", "하쿠", "가오나시", "제니바", "카브", "마르클",
        "토토로", "사츠키", "지브리", "스튜디오", "캐릭터"
    ]
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            List {
                ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                    searchText in Text(searchText)
                }
            } // 리스트의 스타일 수정
            .listStyle(PlainListStyle())
              // 화면 터치시 키보드 숨김
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}
 
struct SearchBar: View {
    @Binding var text: String
 
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("위치를 입력하세요.", text: $text)
                    .foregroundColor(.primary)
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}
