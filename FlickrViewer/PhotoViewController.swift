//
//  PhotoViewController.swift
//  FlickrViewer
//
//  Created by Nathan Hitchings on 4/20/16.
//  Copyright © 2016 N4TR0N. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
  var imageView: UIImageView!
  var imageTitle = String()
  var image = UIImage()

  override func loadView() {
    imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFit
    imageView.backgroundColor = UIColor.whiteColor()
    view = imageView
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    navigationItem.title = imageTitle
    imageView.image = image
  }
  
}
