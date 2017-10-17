//
//  HTTPService.swift
//  DTAdmin
//
//  Created by Admin on 18.10.17.
//  Copyright © 2017 if-ios-077. All rights reserved.
//

import Foundation
//
//  Auth.swift
//  HTTPTestProject
//
//  Created by Admin on 12.10.17.
//  Copyright © 2017 kravchuk. All rights reserved.
//

import Foundation

class HTTPService {
    //    static func login (userName:String, password:String){
    static func login (){
        let params = ["username": "admin", "password": "dtapi_admin"]
        let url = URL(string: "http://vps9615.hyperhost.name/login/index")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("UTF-8", forHTTPHeaderField: "Charset")
        let jsonData:Data
        do {
            jsonData = try JSONSerialization.data(withJSONObject: params, options: [])
            request.httpBody = jsonData
        } catch  {
            print("some error")
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            let cookies:[HTTPCookie] = HTTPCookieStorage.shared.cookies! as [HTTPCookie]
            print(cookies)
            UserDefaults.standard.set((cookies.first?.value), forKey: "session")
        }
        task.resume()
        
        
    }
    
    static func getAllData<T:Decodable> (entityName:String,completion: @escaping ([T]) -> ()){
        let sessionValue =  UserDefaults.standard.object(forKey: "session") as! String
        print(sessionValue)
        let urlString = "http://vps9615.hyperhost.name/" + entityName + "/getRecords"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("UTF-8", forHTTPHeaderField: "Charset")
        request.setValue("session=\(sessionValue)", forHTTPHeaderField: "Cookie")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            print("data = \(String(describing: data))")
            do {
                print("json")
                let json = try JSONDecoder().decode([T].self, from: data)
                completion(json)
            } catch {
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
        }
        task.resume()
    }
    
    static func getData<T:Decodable> (entityName:String,id:String,completion: @escaping (T) -> ()){
        let sessionValue =  UserDefaults.standard.object(forKey: "session") as! String
        print(sessionValue)
        let urlString = "http://vps9615.hyperhost.name/" + entityName + "/getRecords/" + id
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("UTF-8", forHTTPHeaderField: "Charset")
        request.setValue("session=\(sessionValue)", forHTTPHeaderField: "Cookie")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            print("data = \(String(describing: data))")
            do {
                print("json")
                let json = try JSONDecoder().decode( T.self, from: data)
                completion(json)
            } catch {
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
        }
        task.resume()
    }
    
    //    static func postData (entityName:String,entityDictionary:[String:Any]){
    static func postData (){
        let sessionValue =  UserDefaults.standard.object(forKey: "session") as! String
        print(sessionValue)
        //        let urlString = "http://vps9615.hyperhost.name/" + entityName + "/insertData"
        let urlString = "http://vps9615.hyperhost.name/speciality/insertData"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("UTF-8", forHTTPHeaderField: "Charset")
        request.setValue("session=\(sessionValue)", forHTTPHeaderField: "Cookie")
        
        let newGroup = Speciality(speciality_id: "-1", speciality_code: "6.233", speciality_name: "name")
        //        let groupParam = ["group_id":"-1", "group_name": "new group", "faculty_id": "1", "speciality_id": "1"]
        
        do {
            let jsonBody = try JSONEncoder().encode(newGroup)
            //            let jsonBody = try JSONSerialization.data(withJSONObject: groupParam, options: [])
            request.httpBody = jsonBody
        } catch {
            
        }
        //        let jsonDictionary = NSMutableDictionary()
        //        for (key,value) in entityDictionary{
        //            jsonDictionary.setValue(value, forKey: key)
        //        }
        //
        //        let jsonData:Data
        //        do {
        //           jsonData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: JSONSerialization.WritingOptions())
        //            request.httpBody = jsonData
        //        } catch  {
        
        //        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            print("data = \(String(describing: data))")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("post json")
                print(json)
            }catch{
                
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
        }
        task.resume()
    }
    
    static func deleteData (entityName:String,id:String){
        let sessionValue =  UserDefaults.standard.object(forKey: "session") as! String
        print(sessionValue)
        let urlString = "http://vps9615.hyperhost.name/" + entityName + "/del/" + id
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("UTF-8", forHTTPHeaderField: "Charset")
        request.setValue("session=\(sessionValue)", forHTTPHeaderField: "Cookie")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            print("data = \(String(describing: data))")
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
        }
        task.resume()
    }
    
    static func getCommonArrayForGroups (completion: @escaping ([Any]) -> ()){
        //        let queueGrops = DispatchQueue.global(qos: .utility)
        
        let queue = DispatchQueue(label: "com.dt_api.app.queue")
        let group = DispatchGroup()
        //        queueGrops.async{
        var groups:[Group] = []
        var faculties:[Faculty] = []
        var specialities:[Speciality] = []
        group.enter()
        queue.async {
            print("get data")
            HTTPService.getAllData(entityName: "group"){ (result:[Group]) in
                groups = result
            }
            HTTPService.getAllData(entityName: "faculty"){ (result:[Faculty]) in
                faculties = result
            }
            HTTPService.getAllData(entityName: "speciality"){ (result:[Speciality]) in
                specialities = result
            }
            group.leave()
        }
        
        
        //            sleep(1)
        queue.async {
            while groups.isEmpty || specialities.isEmpty || faculties.isEmpty{
                group.wait()
            }
            
            var commonData:[Any] = []
            print("new1")
            for group in groups {
                var newGroup:[String:Any] = [:]
                newGroup["group_name"] = group.group_name
                newGroup["group_id"] = group.group_id
                newGroup["faculty_id"] = group.faculty_id
                newGroup["speciality_id"] = group.speciality_id
                for faculty in faculties {
                    if (group.faculty_id == faculty.faculty_id){
                        newGroup["faculty_name"] = faculty.faculty_name
                        newGroup["faculty_description"] = faculty.faculty_description
                    }
                }
                for speciality in specialities {
                    if (group.speciality_id == speciality.speciality_id){
                        newGroup["speciality_code"] = speciality.speciality_code
                        newGroup["speciality_name"] = speciality.speciality_name
                    }
                }
                print("newElement")
                print(newGroup)
                commonData.append(newGroup)
            }
            print("new2")
            completion(commonData)
        }
        
        //        }
    }
    
    
    
}
