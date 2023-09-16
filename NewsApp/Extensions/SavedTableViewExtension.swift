//
//  SavedTableViewExtension.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 16.09.2023.
//

import UIKit

extension SavedNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedNewsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedNewsTableViewCell
                    
        let article = savedNewsData[indexPath.row]
       
        cell.titleLabel.text = article.title

        
        if let imageURLString = article.urlToImage, let imageURL = URL(string: imageURLString) {
            let session = URLSession.shared
            let task = session.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Hata:", error)
                    DispatchQueue.main.async {
                        cell.newsSavedImage.image = UIImage(named: "no-image")
                    }
                } else if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        cell.newsSavedImage.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        cell.newsSavedImage.image = UIImage(named: "no-image")
                    }
                }
            }
            task.resume()
        } else {
            cell.newsSavedImage.image = UIImage(named: "no-image")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedFavoriteNews = savedNewsData[indexPath.row]
//        var data = Article(source: Source(), author: selectedArticle.author, title: selectedArticle.title ?? "", description: selectedArticle.descriiption, url: selectedArticle.url ?? "", urlToImage: selectedArticle.urlToImage, publishedAt: nil, content: nil)
        
        let data = Article(
            source: nil,
            author: selectedFavoriteNews.author,
            title: selectedFavoriteNews.title ?? "",
            description: selectedFavoriteNews.descriiption,
            url: selectedFavoriteNews.url ?? "",
            urlToImage: selectedFavoriteNews.urlToImage,
            publishedAt: nil,
            content: nil
        )
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let newsDetailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        newsDetailVC.newsArticleDetail = data
        present(newsDetailVC, animated: true, completion: nil)
    }
    
}
