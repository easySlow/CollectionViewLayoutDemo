//
//  LFCLayout.h
//  CollectionViewLayoutDemo
//
//  Created by LFC on 16/8/12.
//  Copyright © 2016年 Darwin. All rights reserved.
//

#import <UIKit/UIKit.h>
//高度代理
@class LFCLayout;
@protocol LFCCellHeightDelegate <NSObject>
-(CGFloat)LFCLayout:(LFCLayout*)layout cellHeightAtIndexPath:(NSIndexPath*)indexPath;
@end

@interface LFCLayout : UICollectionViewLayout
//行间距
@property (nonatomic,assign) CGFloat rowPadding;
//列间距
@property (nonatomic,assign) CGFloat colPadding;
//列数
@property (nonatomic,assign) CGFloat colNum;
//collectionView contentSize
@property (nonatomic,assign) CGSize contentSize;

@property (nonatomic,assign) UIEdgeInsets sectionInsets;

@property (nonatomic,weak) id<LFCCellHeightDelegate> delegate;

@end



