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
        if let object = object {
          let json = JSON(object)
          let items = json["items"]
          for (index, subJson):(String, JSON) in items {
            if let title = subJson[index]["title"].string,
              let mediaLink = subJson[index]["media"]["m"].string {
              self.allPhotos.append(Photo(title: title, mediaLink: NSURL(string: mediaLink)!))
            }
          }
        }
        completion(success: true, photos: self.allPhotos)
      } else {
        completion(success: false, photos: nil)
      }
    }
  }

}