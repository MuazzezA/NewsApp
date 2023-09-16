//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 16.09.2023.
//

import UIKit

class NewsDetailViewController: UIViewController {

    var newsArticleDetail: Article?
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var starButton: UIButton!
    
    let context = appDelegate.persistentContainer.viewContext
    var savedNewsData =  [SavedNews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readNewsDatabase()
        checkIsFavorite()
        
        if let selectedArticle = newsArticleDetail {
            titleLabel.text = selectedArticle.title
            descLabel.text = selectedArticle.description ?? "Açıklama Yok"
            authorLabel.text = selectedArticle.author ?? "Yazar Bilgisi Yok"

            if let imageURLString = selectedArticle.urlToImage, let imageURL = URL(string: imageURLString) {
                activityIndicator.startAnimating()
                let session = URLSession.shared
                let task = session.dataTask(with: imageURL) { (data, response, error) in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    if let imageData = data, let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.newsImage.image = image
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.newsImage.image = UIImage(named: "no-image")
                        }
                    }
                }
                task.resume()
            }
        } else {
            titleLabel.text = "Veri Bekleniyor"
            descLabel.text = ""
            authorLabel.text = ""
            newsImage.image = UIImage(named: "no-image")
            activityIndicator.startAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readNewsDatabase()
    }
    
    @IBAction func starButtonAct(_ sender: Any) {
        if starButton.currentImage == UIImage(systemName: "star") {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            saveToDatabase()
        } else if starButton.currentImage == UIImage(systemName: "star.fill"){
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            deleteFromDatabase()
        }
    }
    
    func saveToDatabase (){
              
        let data = SavedNews(context: context)
        data.author = newsArticleDetail?.author
        data.descriiption = newsArticleDetail?.description
        data.title = newsArticleDetail?.title
        data.url = newsArticleDetail?.url
        data.urlToImage = newsArticleDetail?.urlToImage
 
        appDelegate.saveContext()
        print("kayıt oldu")
        
    }
    
    func deleteFromDatabase(){
        if let index = savedNewsData.firstIndex(where: { $0.title == newsArticleDetail?.title }) {
            let data = savedNewsData[index]
            context.delete(data)
            appDelegate.saveContext()
            print("silindi")
        } else {
            print("hata- bulunamadı")
        }
    
    }

    
    func readNewsDatabase(){
        do{
            savedNewsData = try context.fetch(SavedNews.fetchRequest())
        }catch{
            print("hata-okurken detayda---- ")
        }
    }
    
    func checkIsFavorite (){
        if let index = savedNewsData.firstIndex(where: { $0.title == newsArticleDetail?.title }) {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            print("favorilerde")
        } else {
            print("hata- bulunamadı")
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }

    }
}
