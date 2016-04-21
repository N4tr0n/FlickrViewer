//
//  APIClient.swift
//  FlickrViewer
//
//  Created by Nathan Hitchings on 4/19/16.
//  Copyright © 2016 N4TR0N. All rights reserved.
//

import Foundation

class FlickrClient {
  
  static let sharedClient = FlickrClient()
  
  private func dataTask(request: NSMutableURLRequest, method: String, completion: (success: Bool, object: AnyObject?) -> ()) {
    request.HTTPMethod = method
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
      if let data = data {
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
        if let response = response as? NSHTTPURLResponse where 200...299 ~= response.statusCode {
          completion(success: true, object: json)
        } else {
          completion(success: false, object: json)
        }
      }
    }
    task.resume()
  }
  
  private func get(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
    dataTask(request, method: "GET", completion: completion)
  }
  
  private func flickrRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
    let baseURL = NSURL(string: "https://api.flickr.com/services/")!
    let url = NSURL(string: path, relativeToURL: baseURL)!
    let request = NSMutableURLRequest(URL: url)
    if let params = params {
      var paramString = "format=json&nojsoncallback=1&" // we want a JSON response
      for (key, value) in params {
        let escapedKey = key.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
        let escapedValue = value.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
        paramString += "\(escapedKey)=\(escapedValue)&"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
      }
    }
    return request
  }
  
  func fetchPublicPhotosFeed(completion: (success: Bool, object: AnyObject?) -> ()) {
    get(flickrRequest("feeds/photos_public.gne")) { (success, object) in
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        if success {
          completion(success: true, object: object)
        } else {
          completion(success: false, object: object)
        }
      })
    }
  }
  
}