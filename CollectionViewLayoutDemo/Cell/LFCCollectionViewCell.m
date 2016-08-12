//
//  LFCCollectionViewCell.m
//  CollectionViewLayoutDemo
//
//  Created by LFC on 16/8/12.
//  Copyright © 2016年 Darwin. All rights reserved.
//

#import "LFCCollectionViewCell.h"

@implementation LFCCollectionViewCell
-(void)awakeFromNib{
    self.imageView.layer.cornerRadius = 10;
}

@end
