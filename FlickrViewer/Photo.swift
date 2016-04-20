//
//  Photo.swift
//  FlickrViewer
//
//  Created by Nathan Hitchings on 4/17/16.
//  Copyright © 2016 N4TR0N. All rights reserved.
//

import Foundation

class Photo: NSObject {
  let title: String
  let mediaLink: NSURL
  var media: NSData?
  
  init(title: String, mediaLink: NSURL) {
    self.title = title
    self.mediaLink = mediaLink
    super.init()
  }
  
}