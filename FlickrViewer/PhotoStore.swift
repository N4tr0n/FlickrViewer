//
//  PhotoStore.swift
//  FlickrViewer
//
//  Created by Nathan Hitchings on 4/19/16.
//  Copyright © 2016 N4TR0N. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotoStore {
  
  var allPhotos = [Photo]()
  
  static let sharedStore = PhotoStore()
  
  func loadPhotos(completion: (success: Bool, photos: [Photo]?) -> ()) {
    FlickrClient.sharedClient.fetchPublicPhotosFeed { (success, object) in
      if success {
        if self.allPhotos.count > 0 {
          self.allPhotos.removeAll()
        }
        let json = object
        let items = json["items"]
        for (_, subJson):(String, JSON) in items {
          if let title = subJson["title"].string,
            let mediaLink = subJson["media"]["m"].string {
            print("title = \(title), m = \(mediaLink)")
            self.allPhotos.append(Photo(title: title, mediaLink: NSURL(string: mediaLink)!))
          }
        }
        completion(success: true, photos: self.allPhotos)
      } else {
        completion(success: false, photos: nil)
      }
    }
  }
  
}