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
  
  override func loadView() {
    navigationItem.title = "Public Photos"
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumInteritemSpacing = 0.0
    flowLayout.minimumLineSpacing = 0.0
    let cellWidth = UIScreen.mainScreen().bounds.size.width / 2
    flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
    collectionView = UICollectionView(frame: UIScreen.mainScreen().bounds, collectionViewLayout: flowLayout)
    collectionView?.registerClass(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.backgroundColor = UIColor.whiteColor()

    view = collectionView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    refreshPhotos { (succeeded, photos) in
      if succeeded {
        print("Finished loading photos")
        dispatch_async(dispatch_get_main_queue(), {
          self.collectionView?.reloadData()
        })

      } else {
        print("Failed to load photos")
      }
    }
  }
  
  // MARK - <UICollectionViewDataSource>
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return PhotoStore.sharedStore.allPhotos.count
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath)
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    if let photoCell = cell as? PhotoCell {
      photoCell.imageView.sd_setImageWithURL(PhotoStore.sharedStore.allPhotos[indexPath.item].mediaLink)
    }
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let photoCell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotoCell
    if let image = photoCell.imageView.image {
      let photoViewController = PhotoViewController()
      photoViewController.image = image
      photoViewController.imageTitle = PhotoStore.sharedStore.allPhotos[indexPath.item].title
      navigationController?.pushViewController(photoViewController, animated: true)
    }
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let cellWidth = UIScreen.mainScreen().bounds.size.width / 2
    return CGSize(width: cellWidth, height: cellWidth)
  }
  
  func refreshPhotos(completion: (succeeded: Bool, photos: [Photo]?) -> ()) {
    PhotoStore.sharedStore.loadPhotos { (success, photos) in
      if success {
        completion(succeeded: true, photos: photos)
      } else {
        completion(succeeded: false, photos: nil)
      }
    }
  }

  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) in
      self.collectionView.reloadData()
      }) { (UIViewControllerTransitionCoordinatorContext) in }
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
  }

}

