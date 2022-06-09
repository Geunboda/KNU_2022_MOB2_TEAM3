import SwiftUI
 
struct SearchView: View {
    let array = [
        "경북대학교 IT4호관", "마이카츠 경대북문점", "낭만놀이", "온담정",
        "혜화문식당", "한끼갈비 경대점", "다이마루", "W 컬렉션 경북대점"
    ]
    
    @Binding var searchText: String
    
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
