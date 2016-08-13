//
//  ViewController.m
//  CollectionViewLayoutDemo
//
//  Created by LFC on 16/8/12.
//  Copyright © 2016年 Darwin. All rights reserved.
//

#import "ViewController.h"
#import "LFCLayout.h"
#import "LFCCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LFCCellHeightDelegate>
@property (nonatomic) NSArray* listItems;
@property (nonatomic) LFCLayout* layout;
@end

@implementation ViewController{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* plistPath = [bundle pathForResource:@"content" ofType:@"plist"];
    self.listItems = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%lu",(unsigned long)self.listItems.count);
    NSLog(@"%@",self.listItems);
    [self startInitCollectionView];

}

-(void)startInitCollectionView{
    self.layout = [[LFCLayout alloc]init];
    self.layout.rowPadding = 10;
    self.layout.colPadding = 10;
    self.layout.colNum = 2;
    self.layout.sectionInsets = UIEdgeInsetsMake(8,8,8,8);
    self.layout.delegate = self;
    [self.layout autoContentSize];
    
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:self.layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor lightGrayColor];
    [collectionView registerNib:[UINib nibWithNibName:@"LFCCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* imageUrl = [self.listItems[indexPath.row] objectForKey:@"image"];
    LFCCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
   
    NSLog(@"%@",cell.imageView.image);
    cell.contentLabel.text = [self.listItems[indexPath.row] objectForKey:@"txt"];
    return cell;
}

-(CGFloat)LFCLayout:(LFCLayout *)layout cellHeightAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (self.view.bounds.size.width - self.layout.sectionInsets.left * 2 - (self.layout.colNum - 1) * self.layout.rowPadding) / self.layout.colNum;
    CGFloat rate = [[self.listItems[indexPath.row] objectForKey:@"width"] floatValue]/ width;
    CGFloat height = [[self.listItems[indexPath.row] objectForKey:@"height"] floatValue]/ rate;
    return  height + 60.f;
}

@end
