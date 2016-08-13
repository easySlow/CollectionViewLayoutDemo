//
//  LFCCollectionViewCell.h
//  CollectionViewLayoutDemo
//
//  Created by LFC on 16/8/12.
//  Copyright © 2016年 Darwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFCCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic) NSURLSessionDataTask* task;
@end
