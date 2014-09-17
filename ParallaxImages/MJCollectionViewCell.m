//
//  MJCollectionViewCell.m
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import "MJCollectionViewCell.h"

@interface MJCollectionViewCell()

@end

@implementation MJCollectionViewCell

- (void)awakeFromNib
{
    self.clipsToBounds = YES;
    _imageView = [self newImageView];
    [self addSubview:_imageView];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Setup Method

- (UIImageView *)newImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x,
                                                                           self.bounds.origin.y,
                                                                           self.bounds.size.width,
                                                                           IMAGE_HEIGHT)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = NO;
    imageView.alpha = 0.0f;
    
    return imageView;
}

@end
