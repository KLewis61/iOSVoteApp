//
//  ContentView.swift
//  iOSVoteApp
//
//  Created by Kevin Lewis on 4/17/23.
//

import SwiftUI
import os.log

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
        }
        .padding()
        
        //add button
        Button(action: {
            print("Button tapped")
            // add async method to login
            // call sendRequestOverUrl function
            guard let url = URL(string: "http://httpbin.org/post") else { return }
            sendRequestOverUrl(url)
            
            
        },
               label: { Text("Log in")}).accessibility(label: Text("Log In"))

        let logger = Logger(subsystem: "com.klewis61.iosvoteapp", category: "main")
        let _ = logger.info("Username = MyUserName@nowsecure.com ")
        let _ = logger.info("password = NotMyPassword")

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func sendRequestOverUrl(_ url: URL) {
   
    var request = URLRequest(url: url.standardized)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let postDictionary = [
        "username" : "MyUserName@nowsecure.com ",
        "password" : "NotMyPassword"
    ]
    let jsonData = try? JSONSerialization.data(withJSONObject: postDictionary, options: .prettyPrinted)
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {                                                 // check for fundamental networking error
            print("error=\(String(describing: error))")
            return
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }
        
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(String(describing: responseString) )")
    }
    task.resume()
    print("Request Sent, lookout!")
    }
