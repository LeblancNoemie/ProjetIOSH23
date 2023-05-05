//
//  ProjetRestAPI.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-04-19.
//

import Foundation
class ProjetRestAPI{
    
    var whenProjectsReady : WhenProjectsReady?
    static var shared = ProjetRestAPI()
    
    func addnewProject(aProjet: [String:Any]){
        let url = URL(string: "https://coursios-881f.restdb.io/rest/projet")
        let session = URLSession.shared
        var request = URLRequest(url:url!)
        request.addValue( "090856c38ff5313ad16f16cf7fedb307bfa13", forHTTPHeaderField: "x-api-key")

        let jsonData =  try? JSONSerialization.data(withJSONObject: aProjet)
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
    func deleteProject(id: String){
        let url = URL(string: "https://coursios-881f.restdb.io/rest/projet/\(id)")
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
    func updateProjet(projet : aProjet){
        let headers = [
          "content-type": "application/json",
          "x-apikey": "090856c38ff5313ad16f16cf7fedb307bfa13",
          "cache-control": "no-cache"
        ]

        let url = URL(string: "https://coursios-881f.restdb.io/rest/projet/\(projet.id)")
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "Put"
        let encoder = JSONEncoder()
        let data = try? encoder.encode(projet)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            do {
                if let resp = response as? HTTPURLResponse, resp.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let playerUpdated:aProjet = try decoder.decode(aProjet.self, from: data!)
                }
            }catch {
                print("Error while getting projects")
            }
        })
        task.resume()
    }
    func getAllData(){
        let url = URL(string: "https://coursios-881f.restdb.io/rest/projet")
        let session = URLSession.shared
        var request = URLRequest(url:url!)
        request.addValue( "090856c38ff5313ad16f16cf7fedb307bfa13", forHTTPHeaderField: "x-api-key")
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if let resp = response as? HTTPURLResponse, resp.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let projects:[aProjet] =  try decoder.decode([aProjet].self, from: data!)
                    self.whenProjectsReady?.loadData(data: projects)
                }
            }catch{
                print("Error while getting projects : \(error)")
            }
        })
        task.resume()
    }
}
