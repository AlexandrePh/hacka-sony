//
//  API.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 22/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import Foundation

class API: NSObject {
    static func postMusicReaction(didLike:Bool,name:String,URI:String){
        var responseJSON:[String:Any]
        let todosEndpoint: String = "https://jsonplaceholder.typicode.com/todos"
        guard let url = URL(string: todosEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postData: [String: Any] = ["didLike": didLike, "name": name, "uri": URI]
        let json: Data
        do {
            json = try JSONSerialization.data(withJSONObject: postData, options: [])
            urlRequest.httpBody = json
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                          options: []) as? [String: Any] else {
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                responseJSON = receivedTodo
                print("The todo is: " + receivedTodo.description)
                
                guard let todoID = receivedTodo["id"] as? Int else {
                    print("Could not get todoID as int from JSON")
                    return
                }
                print("The ID is: \(todoID)")
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
        }
        task.resume()
    }

}
