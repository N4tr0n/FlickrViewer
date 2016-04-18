//
//  FlickrClient.swift
//  FlickrViewer
//
//  Created by Nathan Hitchings on 4/17/16.
//  Copyright © 2016 N4TR0N. All rights reserved.
//

import Foundation

typealias JSONPayload = [String: AnyObject]

class FlickrClient {
  let publicPhotosTimelineEndpoint: NSURL = NSURL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json")!
  
//  let flickrKey = "5538fb7e11d80acc0e7df80fa249a169"
//  let flickrSecret = "adc4afd11fbc29aa"
  
  static let sharedInstance = FlickrClient()
  private init() {}
  
  func fetchPublicPhotosTimeline(callback: (JSONPayload, NSError) -> Void) {
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(publicPhotosTimelineEndpoint) { (data, response, error) in
      var json: JSONPayload!
      do {
        json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? JSONPayload
      } catch {
        print(error)
      }
      if let items = json["items"] as? [JSONPayload] {
        for item in items {
          let media = item["media"] as? [String:String]
          let photo = Photo(title: (item["title"] as? String)!, mediaLink: NSURL(string: (media!["m"] as? String)!)!)
          
        }
      }
    }
    task.resume()
  }
  
}