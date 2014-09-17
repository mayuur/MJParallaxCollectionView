//
//  MJCollectionViewCell.h
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMAGE_HEIGHT 200
#define IMAGE_OFFSET_SPEED 25

@interface MJCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong, readwrite) __block UIImageView *imageView;
@end
