//
//  ContentView.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 20.01.23.
//

import SwiftUI
import URLImage

#if !TESTING
struct ArticleListView: View {
    @StateObject var model = ArticleListViewModel()

    var body: some View {
        NavigationView {
            if let articles = model.articles {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if model.isLoading {
                            ProgressView()
                        }
                        ForEach(articles, id: \.id) { article in
                            NavigationLink(destination: ArticleView(article: article)) {
                                ArticleListItemView(article: article)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .alert(isPresented: $model.hasError, content: alert) // show alert only when no articles
            }
        }
        .onAppear(perform: load)
    }
    
    func alert() -> Alert {
        .init(
            title: .init("Oops :("),
            message: .init("Something went wrong"),
            dismissButton: .default(.init("It's ok. Try again!"), action: load)
        )
    }
    
    func load() {
        AsyncTask { @MainActor in await model.load() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(model: .init())
    }
}
#endif
