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
  
  override func loadView() {
    collectionView = UICollectionView()
    view = collectionView
  }
  
  // MARK - <UICollectionViewDataSource>
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0;
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}

