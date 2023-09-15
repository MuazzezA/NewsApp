//
//  WebService.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 15.09.2023.
//

import Foundation

let BASEURL = "https://newsapi.org/v2/"

class WebService: Codable {
    
    static let shared = WebService()
    
    
        func getNewsData(with urlString: String, completion: @escaping (Result<News, Error>) -> Void) {
               
               guard let url = URL(string: BASEURL + urlString + "&apiKey=" + API_KEY) else {
                   completion(.failure(NSError(domain: "URL oluşturulamadı.", code: 0)))
                   return
               }
               
               URLSession.shared.dataTask(with: url) { data, response, error in
                   if let error = error {
                       completion(.failure(error))
                       return
                   }
                   
                   guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                       completion(.failure(NSError(domain: "HTTP hata kodu.", code: 1)))
                       return
                   }
                   
                   if let data = data {
                       do {
                           let decodedData = try JSONDecoder().decode(News.self, from: data)
                           completion(.success(decodedData))
                       } catch {
                           completion(.failure(error))
                       }
                   } else {
                       completion(.failure(NSError(domain: "Veri bulunamadı.", code: 2)))
                   }
               }.resume()
           }
    }







