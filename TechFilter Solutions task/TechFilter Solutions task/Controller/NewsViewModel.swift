//
//  NewsViewModel.swift
//  TechFilter Solutions task
//
//  Created by Swapnil baranwal on 12/04/23.
//

import Foundation
import SwiftUI
import CoreData


class NewsViewModel: ObservableObject {
    private let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "NewsApp")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                print("Failed to load Core Data stack: \(error)")
            }
        }
    }

    @Published var news: [News] = []

    func fetchNews() {
        let apiKey = "e1ed57a3decc4ef59bafee3b9e69ca42"
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=\(apiKey)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.news = newsResponse.articles
                        self.saveNewsToCoreData()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    private func saveNewsToCoreData() {
        persistentContainer.performBackgroundTask { (context) in
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                try context.execute(deleteRequest)
                for news in self.news {
                    let newsEntity = NewsEntity(context: context)
                    newsEntity.title = news.title
                    newsEntity.author = news.author
                    newsEntity.desc = news.description
                    newsEntity.url = news.url
                    newsEntity.urlToImage = news.urlToImage
                    newsEntity.publishedAt = news.publishedAt
                }
                print("ASP I am here")
                try context.save()
                print("ASP I am here 2")
                self.fetchNewsFromCoreData()
            } catch {
                print("Error saving to Core Data: \(error)")
            }
        }
    }

    public func fetchNewsFromCoreData() -> [News] {
            let context = persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
            do {
                let newsEntities = try context.fetch(fetchRequest)
                print("ASP3401 Responses\(newsEntities)")
                
                //commenting because of the issue that is been caused.
                
                //                let news = newsEntities.map { News(title: $0.title ?? "", author: $0.author, description: $0.desc, url: $0.url ?? URL(string: "https://www.google.com")!, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt ?? Date()) }
                return news
            } catch {
                print("Error fetching from Core Data: \(error)")
                return []
            }
        }

    func loadNews() {
        news = fetchNewsFromCoreData()
        fetchNews()
    }
}
