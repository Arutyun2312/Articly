//
//  ArticleListItemView.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 20.01.23.
//

#if !TESTING
import SwiftUI
import URLImage

struct ArticleListItemView: View {
    let article: Article
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            URLImage(article.image) {
                $0
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .bold()
                Text(article.description)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding()
        .background(Color(red: 28 / 255, green: 28 / 255, blue: 30 / 255))
        .cornerRadius(15)
    }
}

struct ArticleListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let desc = "elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis"
        ArticleListItemView(article: .init(id: 1, title: "Title", description: desc, author: "Author", image: .init(string: "http://dummyimage.com/63x163.png/ff4444/ffffff")!, releaseDate: .init()))
    }
}
#endif
