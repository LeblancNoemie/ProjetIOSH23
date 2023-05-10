//
//  DepenseRestAPI.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-04-19.
//

import Foundation
class ConventionsRestAPI{
    
    var whenConventionsReady : WhenConventionsReady?
    static var shared = ConventionsRestAPI()
    
    func addNewConvention(convention: [String:Any]){
        let url = URL(string: "https://coursios-881f.restdb.io/rest/conventions")
        let session = URLSession.shared
        var request = URLRequest(url:url!)
        request.addValue( "090856c38ff5313ad16f16cf7fedb307bfa13", forHTTPHeaderField: "x-api-key")

        let jsonData =  try? JSONSerialization.data(withJSONObject: convention)
        request.httpMethod = "Post"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let task = session.dataTask(with: request){(data, response, error) in
            if let result = data, let resp = response as? HTTPURLResponse {
                if (resp.statusCode == 200){
                    print("Item found!!!")
                    let new =  try? JSONSerialization.jsonObject(with: result, options: []) as? [String:Any]
                    print("ID of new item: \(new?["id"])")
                }
            }
        }
        task.resume()
    }

    //fonctionnel
    func deleteConvention(id: String){
        let url = URL(string: "https://coursios-881f.restdb.io/rest/convention/\(id)")
        print(url)
        let session = URLSession.shared
        var request = URLRequest(url:url!)
        request.addValue( "090856c38ff5313ad16f16cf7fedb307bfa13", forHTTPHeaderField: "x-api-key")

        request.httpMethod = "Delete"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: request){(data, response, error) in
            if let result = data, let resp = response as? HTTPURLResponse {
                if (resp.statusCode == 200){
                    print("Item deleted!")
                }
            }
        }
        task.resume()
    }

    //fonctionnel
    func updateConvention(convention : aConvention){
        let headers = [
          "content-type": "application/json",
          "x-apikey": "090856c38ff5313ad16f16cf7fedb307bfa13",
          "cache-control": "no-cache"
        ]

        let url = URL(string: "https://coursios-881f.restdb.io/rest/conventions/\(convention.id)")
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "Put"
        let encoder = JSONEncoder()
        let data = try? encoder.encode(convention)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            do {
                if let resp = response as? HTTPURLResponse, resp.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let conventionUpdated:aConvention = try decoder.decode(aConvention.self, from: data!)
                }
            }catch {
                print("Error while getting conventions")
            }
        })
        task.resume()
    }

    func getAllData(){
        let url = URL(string: "https://coursios-881f.restdb.io/rest/conventions")
        let session = URLSession.shared
        var request = URLRequest(url:url!)
        request.addValue( "090856c38ff5313ad16f16cf7fedb307bfa13", forHTTPHeaderField: "x-api-key")

        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if let resp = response as? HTTPURLResponse, resp.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.sss'Z'"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let conventions:[aConvention] =  try decoder.decode([aConvention].self, from: data!)
                    self.whenConventionsReady?.loadData(data: conventions)
                }

            }catch{
                print("Error while getting conventions : \(error)")
            }
        })
        task.resume()
    }
    
    func getConventionBy(condition: String, value: String){
        //let url = URL(string:https://coursios-881f.restdb.io/rest/conventions?q={"\(condition)":"\(value)"})
        
        let queryItem = URLQueryItem(name: "q", value:
        """
        {"\(condition)":"\(value)"}
        """)
        
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "coursios-881f.restdb.io"
        urlComp.path = "/rest/conventions"
        urlComp.queryItems = [queryItem]
        
        var request = URLRequest(url: urlComp.url!)
        
        
        let session = URLSession.shared
        //var request = URLRequest(url:url!)
        request.addValue( "090856c38ff5313ad16f16cf7fedb307bfa13", forHTTPHeaderField: "x-api-key")

        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if let resp = response as? HTTPURLResponse, resp.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let conventions:[aConvention] =  try decoder.decode([aConvention].self, from: data!)
                    self.whenConventionsReady?.loadData(data: conventions)
                }

            }catch{
                print("Error while getting conventions : \(error)")
            }
        })
        task.resume()
    }
}
