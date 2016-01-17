//
//  JIMProfileVC.m
//  JustItMind
//
//  Created by Viksah on 11/3/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMProfileVC.h"
#import "UIImageView+AFNetworking.h"
#import "TableViewCells.h"
#import "JNewsFeed.h"
#import "JIMChatVC.h"

@interface JIMProfileVC ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UIImageView *coverImageView;
    IBOutlet NSLayoutConstraint *coverimageHeight;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblDorm;
    IBOutlet UILabel *lblMajor;
    IBOutlet UILabel *lblGrYear;
    IBOutlet UILabel *lblMessage;
    IBOutlet UIImageView *imgVProfile;
    IBOutlet UITextView *txtVBio;
    IBOutlet UIView *topView;
    
    IBOutlet UIButton *btnEdit1;
    IBOutlet UIButton *btnEdit2;
    IBOutlet UIButton *btnEdit3;
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnDiscover;
    
    User *user;
    NSMutableArray *arrUserFeeds;
}
@end

@implementation JIMProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_strUserID) {
        [self getUserProfileInfo];
    }
    else{
        user = me;
        [self setProfileData];
        [self getUserFeeds:user.userID];
    }
    if(_fromPush) {
        btnBack.hidden = NO;
    }
    
    if([user.userID isEqualToString:me.userID]) {
      lblMessage.text = @"";
    }
    else {
        btnEdit1.hidden = YES;
        btnEdit2.hidden = YES;
        btnEdit3.hidden = YES;
        lblMessage.text = @"Message";
    }
}

- (void)setProfileData {
    lblName.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    lblDorm.text =user.regHall;
    lblMajor.text = user.major;
    txtVBio.text = user.bio;
    lblGrYear.text = [NSString stringWithFormat:@"Class of %@", user.grYear];
    [imgVProfile setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"photo_bg"]];
}

#pragma mark - IBActions

- (IBAction)onMessageBtnClick:(id)sender {
    if([user.userID isEqualToString:me.userID])return;
     //id chatUserlistVC = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_ChatListVC"];
    //[self.navigationController pushViewController:chatUserlistVC animated:NO];

    JIMChatVC *chatVC = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_ChatVC"];
     chatVC.friend = user;
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (IBAction)onEditInfo:(id)sender {
    profileEditing = YES;
    id setupProfileVC = [MainStBoard instantiateViewControllerWithIdentifier:@"SBID_SetupProfileVC"];
    [self.navigationController pushViewController:setupProfileVC animated:YES];
}

- (IBAction) onClickBtnEditCoverImage:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Choose" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Gallery" otherButtonTitles:@"Camera ", nil];
    [sheet showInView:self.view];
}

#pragma mark - ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        [self openGallery];
    }
    else if(buttonIndex == 1) {
        [self openCamera];
    }
    else
    {
    
    }
}

#pragma mark - ImagePicker Controller
- (void)openGallery {
    UIImagePickerController *ipic = [[UIImagePickerController alloc]init];
    ipic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipic.delegate = self;
    [self presentViewController:ipic animated:YES completion:nil];
}

- (void)openCamera {
    UIImagePickerController *ipic = [[UIImagePickerController alloc]init];
    ipic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipic.delegate = self;
    [self presentViewController:ipic animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [coverImageView setImage:image];
}

#pragma mark - TAbleview Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedParentCell"];
    cell.arrFeeds = arrUserFeeds;
    [cell reloadFeeds];
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


#pragma mark - WS 
- (void)getUserProfileInfo {
    id param = @{@"id": _strUserID};
    [WSCall getUserProfile:param block:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess) {
            if ([JSON[@"status"] intValue] == 1) {
                NSArray *arrUsers = JSON[@"data"];
                if(arrUsers.count > 0) {
                    id juser = arrUsers.firstObject;
                    user = [User new];
                    [user setInfo:juser];
                    [self setProfileData];
                    [self getUserFeeds:user.userID];
                }
            }
        }
        else {
            showAlertViewMessageTitle(@"Something happen wrong!", @"Error");
        }
    }];
}

- (void)getUserFeeds:(NSString*)strId {
    id param = @{@"user_id": strId};
    [WSCall getUsersFeed:param block:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess) {
            if ([JSON[@"status"] intValue] == 1) {
                NSArray *arr = JSON[@"data"];
                arrUserFeeds = [NSMutableArray new];
                for (id jfeed in  arr) {
                    JNewsFeed *feed = [JNewsFeed new];
                    [feed setFeedInfo:jfeed];
                    feed.adminFirstName = user.firstName;
                    feed.adminLastName = user.lastName;
                    feed.profileImage = user.profileImageUrl;
                    [arrUserFeeds addObject:feed];
                }
                [self.tableView reloadData];
            }
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
