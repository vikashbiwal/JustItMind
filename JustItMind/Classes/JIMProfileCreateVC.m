//
//  profileCreateVC.m
//  TestApp
//
//  Created by Viksah on 9/21/15.
//  Copyright (c) 2015 Viksah. All rights reserved.
//

#import "JIMProfileCreateVC.h"
#define mainScreen [UIScreen mainScreen].bounds

@interface JIMProfileCreateVC ()<UIActionSheetDelegate>
{
    IBOutlet NSLayoutConstraint *lastNameBckgrndTopSpaceConstraint;
    IBOutlet NSLayoutConstraint *lastNameBckgrndLeadignSpaceConstraint;
    
    IBOutlet NSLayoutConstraint *grYearBckgrndTopSpaceConstraint;
    IBOutlet NSLayoutConstraint *grYearBckgrndLeadingSpaceConstraint;
    
    IBOutlet NSLayoutConstraint *hallBckgrndBottomSpaceConstraint;
    IBOutlet NSLayoutConstraint *hallBckgrndLeadingSpaceConstraint;
    
    IBOutlet NSLayoutConstraint *majorBckgrndBottomSpaceConstraint;
    IBOutlet NSLayoutConstraint *majorBckgrndLeadingSpaceConstraint;
    
    IBOutlet UITextField *txtFirstname;
    IBOutlet UITextField *txtLastname;
    IBOutlet UITextField *txtGrYear;
    IBOutlet UITextField *txtResHall;
    IBOutlet UITextField *txtMajor;
    IBOutlet UITextView  *txtviewBio;
}
@end

@implementation JIMProfileCreateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setDefaultValue];
}

- (void)setDefaultValue {
    txtFirstname.text = me.firstName;
    txtLastname.text = me.lastName;
    txtGrYear.text = me.grYear;
    txtMajor.text = me.major;
    txtResHall.text = me.regHall;
    txtviewBio.text = me.bio;
}

#pragma mark - IBActons
- (IBAction)onProfileBtnClick:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Choose from" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery", nil];
    
    [sheet showInView:self.view];
}

- (IBAction)onFinishProfileClick:(id)sender
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    param[@"firstname"] = txtFirstname.text;
    param[@"lastname"] = txtLastname.text;
    param[@"graduation_year"] = txtGrYear.text;
    param[@"resident_hall"] = txtResHall.text;
    param[@"major"] = txtMajor.text;
    param[@"id"] = me.userID;
    param[@"bio"] = txtviewBio.text;
    [WSCall updateProfileWithParam:param block:^(id JSON, WebServiceResult result) {
        if (result == WebServiceResultSuccess) {
            [me setInfo:JSON[@"data"]];
            [self.tabBarController setSelectedIndex:1];
            [DefaultCenter postNotificationName:@"MenuShowHideNotification" object:nil];
        }
        else
        {
            
        }
    }];

   
}

- (IBAction)onSetupProfileClick:(id)sender
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    param[@"firstname"] = txtFirstname.text;
    param[@"lastname"] = txtLastname.text;
    param[@"graduation_year"] = txtGrYear.text;
    param[@"resident_hall"] = txtResHall.text;
    param[@"major"] = txtMajor.text;
    param[@"id"] = me.userID;
    [WSCall updateProfileWithParam:param block:^(id JSON, WebServiceResult result) {
        if (result == WebServiceResultSuccess) {
            [me setInfo:JSON[@"data"]];
            [self performSegueWithIdentifier:@"myProfileViewSegue" sender:self];
        }
        else
        {
            
        }
    }];
}

- (void)setUI
{
    if(mainScreen.size.width == 375)
    {
        grYearBckgrndTopSpaceConstraint.constant     = 48;
        grYearBckgrndLeadingSpaceConstraint.constant = 180;
        lastNameBckgrndTopSpaceConstraint.constant     = 38;
        lastNameBckgrndLeadignSpaceConstraint.constant = 101;
        hallBckgrndBottomSpaceConstraint.constant = 48;
        hallBckgrndLeadingSpaceConstraint.constant = 180;
        majorBckgrndBottomSpaceConstraint.constant = 38;
        majorBckgrndLeadingSpaceConstraint.constant = 101;
        
       
    }
    if(mainScreen.size.width == 414)
    {
        grYearBckgrndTopSpaceConstraint.constant     = 65;
        grYearBckgrndLeadingSpaceConstraint.constant = 200;
        lastNameBckgrndTopSpaceConstraint.constant     = 55;
        lastNameBckgrndLeadignSpaceConstraint.constant = 111;
        hallBckgrndBottomSpaceConstraint.constant = 50;
        hallBckgrndLeadingSpaceConstraint.constant = 200;
        majorBckgrndBottomSpaceConstraint.constant = 55;
        majorBckgrndLeadingSpaceConstraint.constant = 111;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self openCamera];
    }
    else if (buttonIndex == 1)
    {
        [self openGallery];
    }
}

#pragma mark - Other
- (void)openGallery
{
    UIImagePickerController *ipic = [[UIImagePickerController alloc]init];
    ipic.sourceType  = UIImagePickerControllerSourceTypePhotoLibrary;
    ipic.delegate = self;
    [self presentViewController:ipic animated:YES completion:nil];
}
- (void)openCamera
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        showAletViewWithMessage(@"Camera not found in your device.");
        return;
    }
    UIImagePickerController *ipic = [[UIImagePickerController alloc]init];
    ipic.sourceType  = UIImagePickerControllerSourceTypeCamera;
    ipic.delegate = self;
    [self presentViewController:ipic animated:YES completion:nil];
}


@end
