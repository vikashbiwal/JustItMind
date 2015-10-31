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
    IBOutlet UIScrollView *scrollview;
    
    IBOutlet UIView *container1;
    IBOutlet UIView *container2;
    IBOutlet NSLayoutConstraint *containerWidth;
    IBOutlet NSLayoutConstraint *containerHeight;
    
    IBOutlet NSLayoutConstraint *scrollviewWidth;
    IBOutlet NSLayoutConstraint *scrollviewHeight;
    
    IBOutlet NSLayoutConstraint *topMenuTopSpace;
    IBOutlet UIImageView *topMenuPlusIcn;
    IBOutlet UIView *viewCreateEvent;

}
@end

@implementation JIMFeedContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    topMenuTopSpace.constant = -315;
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

#pragma mark - IBActions
- (IBAction)onTopMenuShutterBtn:(id)sender
{
    static BOOL isOpend = NO;
    if(isOpend)
    {
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = -315;
            topMenuPlusIcn.image = [UIImage imageNamed:@"plus_icon"];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            viewCreateEvent.hidden = YES;
        }];
        
        isOpend = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = -230;
            topMenuPlusIcn.image = [UIImage imageNamed:@"icMinus"];
            [self.view layoutIfNeeded];
        }];
        isOpend = YES;
    }
}

- (IBAction)createEventBtnClick:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        topMenuTopSpace.constant = 0;
        viewCreateEvent.hidden = NO;
        [self.view layoutIfNeeded];
    }];
}
@end
