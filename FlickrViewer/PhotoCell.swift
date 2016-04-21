//
//  PhotoCell.swift
//  FlickrViewer
//
//  Created by Nathan Hitchings on 4/20/16.
//  Copyright © 2016 N4TR0N. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  var imageView: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureImageView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureImageView()
  }
  
  func configureImageView() {
    imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    contentView.addSubview(imageView)
    let topConstraint = imageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor)
    let bottomConstraint = imageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor)
    let leadingConstraint = imageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor)
    let trailingConstraint = imageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor)
    topConstraint.active = true
    bottomConstraint.active = true
    leadingConstraint.active = true
    trailingConstraint.active = true
  }

}
