//
//  JIMFeedContainerVC.m
//  JustItMind
//
//  Created by Viksah on 10/18/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMFeedContainerVC.h"

@interface JIMFeedContainerVC ()
{
IBOutlet NSLayoutConstraint *topMenuTopSpace;
    IBOutlet UIScrollView *scrollview;
    IBOutlet UIView *container1;
    IBOutlet UIView *container2;
    IBOutlet NSLayoutConstraint *containerWidth;
    IBOutlet NSLayoutConstraint *containerHeight;
    IBOutlet NSLayoutConstraint *scrollviewWidth;
    IBOutlet NSLayoutConstraint *scrollviewHeight;
}
@end

@implementation JIMFeedContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    topMenuTopSpace.constant = -50;
    [scrollview setContentSize:CGSizeMake(0, 0)];
    NSLog(@"%@",scrollview);
    CGRect frame = scrollview.frame;
    [self setUI];
    }

- (void)setUI {
    scrollviewWidth.constant = screenSize.size.width;
    scrollviewHeight.constant = screenSize.size.height - 64;
    containerWidth.constant = screenSize.size.width;
    containerHeight.constant = screenSize.size.height - 64;

}
- (void)scrollViewDidScroll:(UIScrollView*)scrView
{
    if(scrView.contentOffset.y != 0)
    {
        CGPoint offset = scrView.contentOffset;
        offset.y = 0;
        scrView.contentOffset = offset;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTopMenuShutterBtn:(id)sender
{
    static BOOL isOpend = NO;
    if(isOpend)
    {
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = -50;
            [self.view layoutIfNeeded];
        }];
        isOpend = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = 64;
            [self.view layoutIfNeeded];
        }];
        isOpend = YES;
    }
}

@end
