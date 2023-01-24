//
//  ArticleView.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 20.01.23.
//

#if !TESTING
import SwiftUI
import URLImage

struct ArticleView: View {
    let article: Article

    var body: some View {
        VStack {
            URLImage(article.image) { _, retry in
                Button(action: retry) {
                    Image(systemName: "arrow.clockwise")
                }
                .padding(.top, 60)
            } content: {
                $0
                    .resizable()
                    .scaledToFit()
                    .background(Color.white)
                    .frame(maxHeight: 200)
                    .shadow(radius: 10)
            }
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.title.bold())
                Text(articleDate)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom)
                ScrollView {
                    Text(article.description)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                (Text("Author").bold() + Text(": \(article.author)").foregroundColor(.gray))
                    .contextMenu {
                        Button("Copy") {
                            UIPasteboard.general.string = article.author
                        }
                        if let url = URL(string: "mailto:\(article.author)"), UIApplication.shared.canOpenURL(url) {
                            Button("E-Mail") {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
            }
            .padding([.top, .horizontal])
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
    }
    
    var articleDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "eee, MMM d, ''yy"
        return formatter.string(from: article.releaseDate)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArticleView(article: .init(id: 1, title: "Title", description: Array(repeating: "ar", count: 200).joined(), author: "Author Auth", image: .init(string: "http://dummyimage.com/863x152.png/ff4444/ffffff")!, releaseDate: .init()))
                .navigationBarTitle(.init("Hey"))
        }
    }
}
#endif
