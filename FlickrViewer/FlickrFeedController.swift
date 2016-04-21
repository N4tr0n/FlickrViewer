//
//  ViewController.swift
//  FlickrViewer
//
//  Created by Nathan Hitchings on 4/17/16.
//  Copyright © 2016 N4TR0N. All rights reserved.
//

import UIKit

class FlickrFeedController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  var collectionView: UICollectionView!
  var photos: [Photo]?
  
  override func loadView() {
    collectionView = UICollectionView()
    view = collectionView
    collectionView.registerClass(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
  }
  
  // MARK - <UICollectionViewDataSource>
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if photos != nil {
    return photos!.count;
    } else {
      return 0;
    }
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath)
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    let photoCell = cell as? PhotoCell
    if let photoCell = photoCell {
      // set image
    }
  }
  
  func refreshPhotos(completion: (succeeded: Bool, photos: [Photo]?) -> ()) {
    PhotoStore.sharedStore.loadPhotos { (success, photos) in
      if success {
        self.photos = photos
        completion(succeeded: true, photos: photos)
      } else {
        completion(succeeded: false, photos: nil)
      }
    }
  }
}

