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
    IBOutlet NSLayoutConstraint *btnEventBottomSapace;
    //Create Event iboutlet
    IBOutlet UILabel *placeholderEvent;
    IBOutlet UITextView *txtVEventDisc;
    IBOutlet UILabel *lblStartTime;
    IBOutlet UILabel *lblEndTime;
    IBOutlet UITextField *location;
    IBOutlet UITextField *txtEventTitle;
    IBOutlet UILabel *lblTitlePlaceHolder;
    // create request iboutlet
    IBOutlet UILabel *placeholderRequest;
    IBOutlet UITextView *txtVReqDisc;
    IBOutlet UIButton *btnRadio1;
    IBOutlet UIButton *btnRadio2;
    
    NSString *postType;
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
    postType = @"message";
    if ([me.userType isEqualToString:kUserTypeStudent]) {
        btnRadio2.enabled = NO;
    }
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
    btnEventBottomSapace.constant = 4;

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
        [btnCreateEvent setTitle:@"Create Event" forState:UIControlStateNormal];
        [self onTopMenuShutterBtn:nil];
        NSMutableDictionary *param = [NSMutableDictionary new];
        param[@"news_feed_title"] = txtEventTitle.text;
        param[@"news_feed_type"] = @"magicevent";
        param[@"news_feed_description"] = txtVEventDisc.text;
        param[@"starttime"] = lblStartTime.text;
        param[@"endtime"] = lblEndTime.text;
        param[@"user_id"] = me.userID;
        param[@"location"] = @"AES Ground, Ahmedabad";
        
        [self showHud];
        [WSCall createEvent:param block:^(id JSON, WebServiceResult result) {
            [self hideHud];
            if (result == WebServiceResultSuccess) {
              
            }
            else
            {
            
            }
        }];
    }
    else {
        sender.selected = !sender.selected;
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = 0;
            viewCreateEvent.hidden = NO;
            btnCreateEvent.frame = btnCreateRequest.frame;

            [self.view layoutIfNeeded];
        }];
        btnEventBottomSapace.constant = -30;
        btnCreateRequest.hidden = YES;
        viewCreateEvent.hidden = NO;
        [btnCreateEvent setTitle:@"Post Event" forState:UIControlStateNormal];
    }
    
}

- (IBAction)createRequestBtnClick:(UIButton*)sender {
    
    if(sender.selected) {
        sender.selected = !sender.selected;
        [self onTopMenuShutterBtn:nil];
     
        [btnCreateRequest setTitle:@"Create Request" forState:UIControlStateNormal];
        NSMutableDictionary *param = [NSMutableDictionary new];
        param[@"news_feed_type"] = postType;
        param[@"news_feed_description"] = txtVReqDisc.text;
        param[@"user_id"] = me.userID;
        [self showHud];
        [WSCall createEvent:param block:^(id JSON, WebServiceResult result) {
            [self hideHud];
            if (result == WebServiceResultSuccess) {
                
            }
            else
            {
                
            }
        }];

    }
    else {
        sender.selected = !sender.selected;
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = -70;
            viewCreateRequest.hidden = NO;
            [self.view layoutIfNeeded];
        }];
        [btnCreateRequest setTitle:@"Post Request" forState:UIControlStateNormal];
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
    [dtFormattor setDateFormat:@"yyyy/MM/dd"];
    //[dtFormattor setDateStyle:NSDateFormatterShortStyle];
    //[dtFormattor setTimeStyle:NSDateFormatterShortStyle];
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

- (IBAction)onChangeFeedTypeRadio:(UIButton*)sender {
    sender.selected  = YES;
    if (sender == btnRadio1) {
        btnRadio2.selected = NO;
        postType = @"message";
    }
    else if(sender == btnRadio2) {
        btnRadio1.selected = NO;
        postType = @"drom_feed";
    }
}

#pragma mark - Validation
- (BOOL)validateRequestForm {
    NSString *strMessage;
    if(txtVReqDisc.text.length > 0 ) {
        strMessage = @"Please enter request description.";
        return NO;
    }
    return YES;
}

- (BOOL)validateEventForm {
    return false;
}

///////
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

- (IBAction)txtTileDidChangeEditing:(UITextField *)sender {
    if (sender.text.length > 0 ) {
        lblTitlePlaceHolder.hidden = YES;
    }
    else {
        lblTitlePlaceHolder.hidden = NO;
    }
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
