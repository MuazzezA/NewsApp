// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try? JSONDecoder().decode(News.self, from: jsonData)

import Foundation

// MARK: - News
class News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]

    init(status: String, totalResults: Int, articles: [Article]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

// MARK: - Article
class Article: Codable {
    let source: Source?
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    init(source: Source?, author: String?, title: String, description: String?, url: String, urlToImage: String?, publishedAt: String?, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

// MARK: - Source
class Source: Codable {
    let id: String?
    let name: String?
}


enum ID: String, Codable {
    case googleNews = "google-news"
}

enum Name: String, Codable {
    case googleNews = "Google News"
//    case washingtonPost = "The Washington Post"

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        if let name = Name(rawValue: rawValue) {
            self = name
        } else {
            self = .googleNews
        }
    }
}
