//
//  ViewController.swift
//  FlickrViewer
//
//  Created by Nathan Hitchings on 4/17/16.
//  Copyright © 2016 N4TR0N. All rights reserved.
//

import UIKit
import SDWebImage

class FlickrFeedController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  var collectionView: UICollectionView!
  var photos: [Photo]?
  
  override func loadView() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumInteritemSpacing = 0.0
    flowLayout.minimumLineSpacing = 0.0
    let cellWidth = UIScreen.mainScreen().bounds.size.width / 2
    flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
    collectionView = UICollectionView(frame: UIScreen.mainScreen().bounds, collectionViewLayout: flowLayout)
    collectionView.registerClass(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    collectionView.delegate = self
    collectionView.dataSource = self

    view = collectionView
    
  }

  override func viewDidLoad() {
    refreshPhotos { (succeeded, photos) in
      if succeeded {
        print("Finished loading photos")
      } else {
        print("Failed to load photos")
      }
    }
  }
  
  // MARK - <UICollectionViewDataSource>
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if photos != nil {
    return photos!.count;
    } else {
      return 0;
    }
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath)
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    //let photoCell = cell as? PhotoCell
    if let photoCell = cell as? PhotoCell {
      // set image
      photoCell.imageView.sd_setImageWithURL(photos![indexPath.item].mediaLink)
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

