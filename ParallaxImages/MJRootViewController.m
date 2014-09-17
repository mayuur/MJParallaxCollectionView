//
//  MJViewController.m
//  ParallaxImages
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 sky. All rights reserved.
//

#import "MJRootViewController.h"
#import "MJCollectionViewCell.h"

#define IMAGE_COUNT 14
#define ANIMATED_DURATION 0.6f

@interface MJRootViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation MJRootViewController

#pragma mark - UICollectionViewDatasource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return IMAGE_COUNT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MJCell"
                                                                           forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(id)object
          atIndexPath:(NSIndexPath *)indexPath
{
    if (![object isKindOfClass:[MJCollectionViewCell class]]) {
        return;
    }
    
    MJCollectionViewCell *cell = (MJCollectionViewCell *)object;
    NSString *resource = [NSString stringWithFormat:@"image%03ld", (unsigned long)indexPath.row];
    NSURL *URL = [[NSBundle mainBundle] URLForResource:resource withExtension:@"jpg"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:URL];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.alpha = 1.0f;
            cell.imageView.image = image;
        });
    });
    
    [self setOffsetCollectionViewCell:cell];
}

- (void)setOffsetCollectionViewCell:(MJCollectionViewCell *)cell
{
    // Set cell y offset
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView transitionWithView:cell.imageView
                          duration:0.0f
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            CGFloat yOffset = ((_collectionView.contentOffset.y - cell.frame.origin.y) / IMAGE_HEIGHT) * IMAGE_OFFSET_SPEED;
                            CGRect offsetFrame = CGRectOffset(cell.imageView.bounds, 0.0f, yOffset);
                            cell.imageView.frame = offsetFrame;
                        } completion:^(BOOL finished) {}];
    });
}

#pragma mark - UIScrollViewdelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for(MJCollectionViewCell *cell in _collectionView.visibleCells) {
        [self setOffsetCollectionViewCell:cell];
    }
}

@end
