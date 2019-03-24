//
//  API.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 22/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import Foundation

class API: NSObject {
    static func postMusicReaction(didLike:Bool,name:String,URI:String,_ closure: @escaping (_ :String)->()  ){
        let todosEndpoint: String = "http://f7db2dd4.ngrok.io/recommendation/"
        guard let url = URL(string: todosEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postData: [String: Any] = ["didLike": didLike, "name": name, "uri": URI]
        let json: Data
        do {
            json = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            
            
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
                
//                guard let uri = receivedTodo["uri"] as! String? else {
//                    print(receivedTodo.description)
//                    print("vish")
//                    return
//                }
                let uri = "" //TODO
                closure(uri)
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
