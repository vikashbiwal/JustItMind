//
//  JIMEventDeailVC.m
//  JustItMind
//
//  Created by Viksah on 10/16/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMEventDeailVC.h"
#import "UIImageView+AFNetworking.h"
#import "JIMCommentCell.h"

@interface JIMEventDeailVC ()
{
    IBOutlet UIView *commentAddView;
    IBOutlet NSLayoutConstraint *coverimageHeight;
    IBOutlet NSLayoutConstraint *tablviewBottomConstraint;
    IBOutlet UILabel *lblEventTitle;
    IBOutlet UILabel *lblStartDate;
    IBOutlet UILabel *lblEndDate;
    IBOutlet UILabel *lblCreator;
    IBOutlet UILabel *lblLocation;
    IBOutlet UILabel *lblDescription;
    
    IBOutlet UIButton *btnJoin;
    IBOutlet UIButton *btnJoin2;
    IBOutlet UIButton *btnSend;
    
    IBOutlet UITextView *tvComment;
    IBOutlet UITextField *tfCommentPlaceholder;
    IBOutlet UIImageView *profileImageView;
    IBOutlet UIImageView *coverImageView;
    IBOutlet UIImageView *imgJoinedUser;
    NSMutableArray *commentList;
    NSMutableArray *eventJoinedUserList;
}
@end

@implementation JIMEventDeailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [DefaultCenter addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [DefaultCenter addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    commentAddView.hidden = YES;
    [self setEventInfo];
    [self getComments];
    [self getJoinedUserLIstOfEvent];
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
    imgJoinedUser.layer.cornerRadius = imgJoinedUser.frame.size.height/2;
    imgJoinedUser.clipsToBounds = YES;
    if(_eventFeed.isJoined) {
        
        btnJoin.selected = YES;
        btnJoin2.selected = YES;
        [btnJoin2 setBackgroundImage:nil forState:UIControlStateNormal];
        [btnJoin2 setTitle:@"" forState:UIControlStateNormal];
         tfCommentPlaceholder.placeholder = @"Add a comment...";
        
    }
    else{
        btnJoin.selected = NO;
        btnJoin2.selected = NO;
    }
}
#pragma mark - TAbleview Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JIMCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    cell.arrComments = commentList;
    [cell reloadComments];
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
    [self joinEvent];
}


- (IBAction)commentEditingBegin:(UITextField*)sender {
    if(_eventFeed.isJoined) {
        commentAddView.hidden = NO;
        [tvComment becomeFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
}

- (IBAction)onClickCommentDoneBtn:(id)sender {
    [self addComment];
}


#pragma mark - WS Methods 
- (void)addComment {
    id param = @{@"news_feed_id": _eventFeed.feedId,
                 @"news_feed_comment":tvComment.text,
                 @"comment_by": me.userID};
    [WSCall addCommentOnEvent:param block:^(id JSON, WebServiceResult result) {
        if (result == WebServiceResultSuccess) {
            if ([JSON[@"status"] intValue] == 1) {
                
                id jcomment = JSON[@"data"];
                Comment *comment = [[Comment alloc]init];
                [comment setComment:jcomment];
                comment.userName = [NSString stringWithFormat:@"%@ %@", me.firstName, me.lastName];
                comment.strProfilePic = me.profileImageUrl;
                comment.time = TimeStringFromTime([NSDate date]);
                [commentList insertObject:comment atIndex:0];
                //[commentList addObject:comment];
                [self.tableView reloadData];
                
                commentAddView.hidden = YES;
                [tvComment resignFirstResponder];
            } else {
            }
        } else {
        }
    }];
}

- (void)joinEvent {
    if (_eventFeed.isJoined) {
        id param = @{@"userid": me.userID, @"eventid": _eventFeed.feedId, };
        [WSCall unJoinEvent:param block:^(id JSON, WebServiceResult result) {
            if(result == WebServiceResultSuccess) {
                if([JSON[@"status"] intValue] == 1) {
                    _eventFeed.isJoined = NO;
                    if(!_eventFeed.isJoined) {
                   
                        btnJoin.selected = NO;
                        btnJoin2.selected = NO;
                        [btnJoin2 setTitle:@"Join" forState:UIControlStateNormal];
                        [btnJoin2 setBackgroundImage:[UIImage imageNamed:@"join_btn_bg"] forState:UIControlStateNormal];

                        tfCommentPlaceholder.placeholder = @"Joint the event to add a commet...";
                    }
                }
                
            }
        }];
    } else {
        btnJoin.selected = !btnJoin.selected;
        id param = @{@"userid":me.userID, @"eventid":_eventFeed.feedId};
        [WSCall joinEvent:param block:^(id JSON, WebServiceResult result) {
            if(result == WebServiceResultSuccess) {
                if([JSON[@"status"] intValue] == 1) {
                    _eventFeed.isJoined = YES;
                    if(_eventFeed.isJoined) {
                        btnJoin.selected = YES;
                        btnJoin2.selected = YES;
                        [btnJoin2 setBackgroundImage:nil forState:UIControlStateNormal];
                        [btnJoin2 setTitle:@"" forState:UIControlStateNormal];
                        tfCommentPlaceholder.placeholder = @"Add a comment...";
                    } else{
                        btnJoin.selected = NO;
                        btnJoin2.selected = NO;
                    }
                } else {
                    btnJoin.selected = !btnJoin.selected;
                }
            }
        }];
    }

}

- (void)getComments {
    id param = @{@"news_feed_id": _eventFeed.feedId,@"extra":@"user_info"};
    [WSCall getCommentsOfFeed:param block:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess) {
            if([JSON[@"status"] intValue] == 1) {
                commentList = [NSMutableArray new];
                NSArray *arr = JSON[@"data"];
                for(id jcomment in arr) {
                    Comment *comment = [Comment new];
                    [comment setComment:jcomment];
                    [commentList addObject:comment];
                }
               id hmm = [self sortArray:commentList fieldName:@"time"] ;
                commentList = [NSMutableArray arrayWithArray:hmm];
                [self.tableView reloadData];
            } else {
            }
        } else {
        }
    }];
}

- (void)getJoinedUserLIstOfEvent {
    [WSCall listOfJoinedUserOfEvent:_eventFeed.feedId block:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess) {
            if([JSON[@"status"] intValue] == 1) {
                eventJoinedUserList = [NSMutableArray new];
                id data = JSON[@"data"] ;
                for (id usr in data) {
                    User *u = [[User alloc]init];
                    [u setInfo:usr];
                    [eventJoinedUserList addObject:u];
                }
                User *user = eventJoinedUserList.lastObject;
                [imgJoinedUser setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
            }
        }
    }];
}

#pragma mark - UIKeyboard notification

- (void)keyboardShow:(NSNotification*)notify
{
    CGRect rect = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    tablviewBottomConstraint.constant = rect.size.height;
}

- (void)keyboardHide:(NSNotification*)notify {
    commentAddView.hidden = YES;
    tablviewBottomConstraint.constant = 0;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [DefaultCenter removeObserver:self];
}
@end
