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
    [scrollview setContentSize:CGSizeMake(640, 504)];
   
    //[self setUI];
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
        //scrView.contentOffset = offset;
    }
    int index =  scrView.contentOffset.x/scrView.frame.size.width;
    if(index == 0)
      parentlblTitle.text = @"News Feed";
    else if (index == 1)
        parentlblTitle.text = @"Dorm Feed";
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
