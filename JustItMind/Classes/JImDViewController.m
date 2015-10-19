//
//  JImDViewController.m
//  JustItMind
//
//  Created by Viksah on 10/12/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JImDViewController.h"

@interface JImDViewController ()
{
    IBOutlet UICollectionView *colView;
}
@end

@implementation JImDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [colView setContentInset:UIEdgeInsetsFromString(@"{-20.0,0.0,0.0,0.0}")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark collectionView datasource delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tabCell" forIndexPath:indexPath];
    return  cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = screenSize.size.width/3;
    return CGSizeMake(320, 40);
}
@end
