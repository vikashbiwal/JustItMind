//
//  JIMProfileVC.m
//  JustItMind
//
//  Created by Viksah on 11/3/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMProfileVC.h"
#import "UIImageView+AFNetworking.h"

@interface JIMProfileVC ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UIImageView *coverImageView;
    IBOutlet NSLayoutConstraint *coverimageHeight;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblDorm;
    IBOutlet UILabel *lblMajor;
    IBOutlet UITextView *txtVBio;
    IBOutlet UILabel *lblGrYear;
    IBOutlet UIImageView *imgVProfile;
}
@end

@implementation JIMProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setProfileData];
}

- (void)setProfileData {
    lblName.text = [NSString stringWithFormat:@"%@ %@", me.firstName, me.lastName];
    lblDorm.text = me.regHall;
    lblMajor.text = me.major;
    txtVBio.text = me.bio;
    lblGrYear.text = [NSString stringWithFormat:@"Class of %@", me.grYear];
    [imgVProfile setImageWithURL:[NSURL URLWithString:me.profileImageUrl] placeholderImage:[UIImage imageNamed:@"photo_bg"]];
}

#pragma mark - IBActions

- (IBAction)onEditInfo:(id)sender {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
