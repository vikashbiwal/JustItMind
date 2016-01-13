//
//  JIMEventDeailVC.m
//  JustItMind
//
//  Created by Viksah on 10/16/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMEventDeailVC.h"
#import "UIImageView+AFNetworking.h"

@interface JIMEventDeailVC ()
{
    IBOutlet UIView *commentAddView;
    IBOutlet UIImageView *coverImageView;
    IBOutlet NSLayoutConstraint *coverimageHeight;

    IBOutlet UILabel *lblEventTitle;
    IBOutlet UILabel *lblStartDate;
    IBOutlet UILabel *lblEndDate;
    IBOutlet UILabel *lblCreator;
    IBOutlet UILabel *lblLocation;
    IBOutlet UILabel *lblDescription;
    
    IBOutlet UIButton *btnJoin;
    IBOutlet UIButton *btnSend;
    
    IBOutlet UITextView *tvComment;
    IBOutlet UIImageView *profileImageView;
    
}
@end

@implementation JIMEventDeailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [DefaultCenter addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [DefaultCenter addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    commentAddView.hidden = YES;
    [self setEventInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEventInfo {
    lblEventTitle.text = _eventFeed.title;
    lblStartDate.text = _eventFeed.startTime;
    lblEndDate.text = _eventFeed.endTime;
    lblLocation.text = _eventFeed.location;
    lblDescription.text = _eventFeed.discription;
    lblCreator.text = [NSString stringWithFormat:@"%@ %@", _eventFeed.adminFirstName, _eventFeed.adminLastName];
    [profileImageView setImageWithURL:[NSURL URLWithString:_eventFeed.profileImage] placeholderImage:[UIImage imageNamed:@"photo_bg"]];
    profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2;
    profileImageView.clipsToBounds = YES;
    
    if(_eventFeed.isJoined) {
        btnJoin.selected = YES;
    }
    else{
        btnJoin.selected = NO;
    }
}
#pragma mark - TAbleview Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenSize.size.height - 386;
}

- (void)scrollViewDidScroll:(UIScrollView*)tablview
{
    CGFloat y = -tablview.contentOffset.y;
    NSLog(@"tableview offset y = %f",tablview.contentOffset.y);
    coverimageHeight.constant =  115+y;
}

#pragma mark - IBActions

- (IBAction)onClickJoindEventBtn:(UIButton*)sender {
    if (_eventFeed.isJoined) {
    
    }
    else {
        sender.selected = !sender.selected;
        id param = @{@"userid":me.userID, @"eventid":_eventFeed.feedId};
        [WSCall joinEvent:param block:^(id JSON, WebServiceResult result) {
            if(result == WebServiceResultSuccess) {
                if([JSON[@"status"] intValue] == 1) {
                 
                }
                else {
                    sender.selected = !sender.selected;
                  }
            }
        }];
    }
}


- (IBAction)commentEditingBegin:(id)sender {
    if(_eventFeed.isJoined) {
        commentAddView.hidden = NO;
    }
}

- (IBAction)onClickCommentDoneBtn:(id)sender {
    id param = @{@"news_feed_id": _eventFeed.feedId,
                 @"news_feed_comment":tvComment.text,
                 @"comment_by": me.userID};
    [WSCall addCommentOnEvent:param block:^(id JSON, WebServiceResult result) {
        
    }];
}

#pragma mark - UIKeyboard notification

- (void)keyboardShow:(NSNotification*)notify
{
   
}

- (void)keyboardHide:(NSNotification*)notify
{
    commentAddView.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [DefaultCenter removeObserver:self];
}
@end
