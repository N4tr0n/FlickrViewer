//
//  Photo.swift
//  FlickrViewer
//
//  Created by Nathan Hitchings on 4/17/16.
//  Copyright © 2016 N4TR0N. All rights reserved.
//

import Foundation

class Photo {
  let title: String
  let mediaLink: NSURL
  //{
//    didSet {
//      let session = NSURLSession.sharedSession()
//      let task = session.dataTaskWithURL(mediaLink) { (data, response, error) in
//        self.imageData = data
//      }
//      task.resume()
//    }
//  }
//  var imageData: NSData?
  
  init(title: String, mediaLink: NSURL) {
    self.title = title
    self.mediaLink = mediaLink
  }
  
}