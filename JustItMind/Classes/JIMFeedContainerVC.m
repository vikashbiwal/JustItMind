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
    IBOutlet UIView *mainContainerView;
    IBOutlet NSLayoutConstraint *containerWidth;
    IBOutlet NSLayoutConstraint *containerHeight;
    
    IBOutlet NSLayoutConstraint *scrollviewWidth;
    IBOutlet NSLayoutConstraint *scrollviewHeight;
    
    IBOutlet NSLayoutConstraint *topMenuTopSpace;
    IBOutlet UIImageView *topMenuPlusIcn;
    IBOutlet UIView *viewCreateEvent;
    IBOutlet UIView *viewCreateRequest;
    
    IBOutlet UIView *dpBtnView;
    IBOutlet UIButton *btnCreateEvent;
    IBOutlet UIButton *btnCreateRequest;
    //Create Event iboutlet
    IBOutlet UILabel *placeholderEvent;
    IBOutlet UITextView *txtVEventDisc;
    IBOutlet UILabel *lblStartTime;
    IBOutlet UILabel *lblEndTime;
    IBOutlet UITextField *location;
    // create request iboutlet
    IBOutlet UILabel *placeholderRequest;
    IBOutlet UITextView *txtVReqDisc;
}
@end

@implementation JIMFeedContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    topMenuTopSpace.constant = -315;
    containerWidth.constant = screenSize.size.width*2;
    scrollviewHeight.constant = screenSize.size.height - 64;
    containerHeight.constant = screenSize.size.height - 64;
    //[self setUI];
    
    [[NSBundle mainBundle]loadNibNamed:@"JIMAccView" owner:self options:nil];
    }
- (void)viewDidLayoutSubviews
{

}
- (void)viewDidAppear:(BOOL)animated
{
    [scrollview setContentOffset:CGPointMake(0, -20)];
    [scrollview setContentSize:CGSizeMake(screenSize.size.width*2, 435)];
    NSLog(@"%@, ---- %@",scrollview, mainContainerView);
    
}
- (void)setUI {
    
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
    btnCreateRequest.hidden = NO;
    btnCreateEvent.hidden = NO;
    btnCreateEvent.selected = false;
    btnCreateRequest.selected = false;
    if(isOpend)
    {
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = -315;
            topMenuPlusIcn.image = [UIImage imageNamed:@"plus_icon"];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            viewCreateEvent.hidden = YES;
            viewCreateRequest.hidden = YES;
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

- (IBAction)createEventBtnClick:(UIButton*)sender {
    if(sender.selected) {
        sender.selected = !sender.selected;
        [self onTopMenuShutterBtn:nil];
    }
    else {
        sender.selected = !sender.selected;
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = 0;
            viewCreateEvent.hidden = NO;
            [self.view layoutIfNeeded];
        }];
        btnCreateEvent.frame = btnCreateRequest.frame;
        btnCreateRequest.hidden = YES;
    }
    
}

- (IBAction)createRequestBtnClick:(UIButton*)sender {
    
    if(sender.selected) {
        sender.selected = !sender.selected;
        [self onTopMenuShutterBtn:nil];
    }
    else {
        sender.selected = !sender.selected;
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = -70;
            viewCreateRequest.hidden = NO;
            [self.view layoutIfNeeded];
        }];
       
    }
    
}

- (IBAction)btnDPDone:(id)sender {
    if(isStartTime) {
        StartDate = dp.date;
        lblStartTime.text = [self stringFromDate:StartDate];
    }
    else{
        endDate = dp.date;
        lblEndTime.text = [self stringFromDate:endDate];
    }
    dp = nil;
    [txtTemp resignFirstResponder];
}


- (NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter *dtFormattor = [[NSDateFormatter alloc]init];
    [dtFormattor setDateStyle:NSDateFormatterLongStyle];
    [dtFormattor setTimeStyle:NSDateFormatterShortStyle];
    NSString *str = [dtFormattor stringFromDate:date];
    return  str;
}

- (IBAction)btnStartTimeClick:(id)sender {
    isStartTime = true;
    [self showDatePicker];
}

- (IBAction)btnEndTimeClick:(id)sender {
    isStartTime = false;
    [self showDatePicker];
}

UITextField *txtTemp;
UIDatePicker *dp ;
NSDate *StartDate;
NSDate *endDate;
bool isStartTime;

- (void)showDatePicker {
    txtTemp = [[UITextField alloc]init];
    [self.view addSubview:txtTemp];
    txtTemp.hidden = YES;
    dp = [[UIDatePicker alloc]init];
    if(isStartTime)
    {
        if(StartDate) {
            dp.date = StartDate;
        }
    }
    else{
        if(endDate) {
            dp.date = endDate;
        }
    }
    txtTemp.inputView = dp;
    txtTemp.inputAccessoryView = dpBtnView;
    [txtTemp becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView;
{
    if(textView.text.length != 0) {
        NSLog(@"%@", textView.text);
        if(textView == txtVEventDisc) {
            placeholderEvent.hidden = YES;
        }
        else
        {
            placeholderRequest.hidden = YES;
        }
    }
    else {
        if(textView == txtVEventDisc) {
            placeholderEvent.hidden = NO;
        }
        else
        {
            placeholderRequest.hidden = NO;
        }
    }
}
@end
