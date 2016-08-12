//
//  LFCLayout.m
//  CollectionViewLayoutDemo
//
//  Created by LFC on 16/8/12.
//  Copyright © 2016年 Darwin. All rights reserved.
//

#import "LFCLayout.h"

static CGFloat RowPadding =  10;
static CGFloat ColPadding = 10;
static NSInteger ColNum = 2;
//类似css中padding的概念
static UIEdgeInsets edge ;

@interface LFCLayout()
@property (nonatomic,strong) NSMutableArray* attributes;
@property (nonatomic,strong) NSMutableArray* heightOfColArray;
@property (nonatomic, assign) BOOL isAutoContentSize;

@end

@implementation LFCLayout

-(void)prepareLayout{
    [super prepareLayout];
    
    if (self.attributes == nil) {
        self.attributes = [NSMutableArray array];
    }
    
    if (self.heightOfColArray == nil) {
        self.heightOfColArray = [NSMutableArray array];
    }
    
    RowPadding = self.rowPadding == 0 ? RowPadding : self.rowPadding;
    ColPadding = self.colPadding == 0 ? ColPadding : self.colPadding;
    ColNum = self.colNum == 0 ? ColNum : self.colNum;
    edge = self.sectionInsets;
    
    //初始化每一列的高度
    [self.heightOfColArray removeAllObjects];
    for (NSInteger i = 0; i < ColNum; i++) {
        [self.heightOfColArray addObject:@(edge.top)];
    }
    
    //获取layoutattribute
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes* attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributes addObject:attribute];
    }
}

//返回rect中的所有的元素的布局属性
//返回的是包含UICollectionViewLayoutAttributes的NSArray
//UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
//
//layoutAttributesForCellWithIndexPath:
//layoutAttributesForSupplementaryViewOfKind:withIndexPath:
//layoutAttributesForDecorationViewOfKind:withIndexPath:
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributes;
}

//返回对应于indexPath的位置的cell的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes* attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //定义每个cell的宽和高
    CGFloat width = (self.collectionView.bounds.size.width - edge.left - edge.right - (ColNum - 1) * RowPadding) / ColNum;
    CGFloat height = 0;
    
    //判断delegate对象是否有该名字的方法,返回每个cell的高度
    if ([self.delegate respondsToSelector:@selector(LFCLayout:cellHeightAtIndexPath:)]) {
        height = [self.delegate LFCLayout:self cellHeightAtIndexPath:indexPath];
    }
    
    //默认第一列高度最低
    CGFloat minY = self.heightOfColArray.count ? [[self.heightOfColArray firstObject] floatValue] : edge.top;
    //找出高度最低的那一列
    NSInteger currentLow = 0;
    for (NSInteger i = 1; i < self.heightOfColArray.count; i++) {
        if (minY > [self.heightOfColArray[i] floatValue]) {
            minY = [self.heightOfColArray[i] floatValue];
            currentLow = i;
        }
    }
    
    //找出之后即可定义每个cell的坐标位置以及大小
    CGFloat x = edge.left + (width + RowPadding) * currentLow;
    CGFloat y = minY + edge.top;
    attribute.frame = CGRectMake(x, y, width, height);
    
    self.heightOfColArray[currentLow] = @(CGRectGetMaxY(attribute.frame));
    //找出最高的一列的高度，设定contentSize;
    CGFloat maxY = self.heightOfColArray.count ? [[self.heightOfColArray firstObject] floatValue] : edge.top;
    for (NSInteger i = 1; i < self.heightOfColArray.count; i++) {
        if (maxY < [self.heightOfColArray[i] floatValue]) {
            maxY = [self.heightOfColArray[i] floatValue];
        }
    }
    
    self.contentSize = CGSizeMake(self.collectionView.bounds.size.width, maxY + edge.bottom);
    
    return attribute;
}

-(CGSize)collectionViewContentSize{
    return  self.contentSize;
}

@end
