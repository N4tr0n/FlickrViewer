//
//  APIClient.swift
//  FlickrViewer
//
//  Created by Nathan Hitchings on 4/19/16.
//  Copyright © 2016 N4TR0N. All rights reserved.
//

import Foundation
import SwiftyJSON

class FlickrClient {
  
  static let sharedClient = FlickrClient()
  
  func fetchPublicPhotosFeed(completion: (success: Bool, object: JSON) -> ()) {
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(NSURL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")!) { (data, response, error) in
      if let data = data {
        let json = JSON(data: data)
        if let response = response as? NSHTTPURLResponse where 200...299 ~= response.statusCode {
          dispatch_async(dispatch_get_main_queue(), {
            completion(success: true, object: json)
          })
        } else {
          dispatch_async(dispatch_get_main_queue(), {
            completion(success: false, object: json)
          })
        }
      }
    }
    task.resume()
  }
  
}