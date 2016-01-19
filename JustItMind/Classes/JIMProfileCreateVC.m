//
//  profileCreateVC.m
//  TestApp
//
//  Created by Viksah on 9/21/15.
//  Copyright (c) 2015 Viksah. All rights reserved.
//

#import "JIMProfileCreateVC.h"
#define mainScreen [UIScreen mainScreen].bounds

@interface JIMProfileCreateVC ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    //screen 1
    IBOutlet NSLayoutConstraint *parentViewBottomSpace;
    IBOutlet NSLayoutConstraint *parentviewTopSpace;
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
    IBOutlet UIImageView *imgVProfile;
    IBOutlet UIButton *btnprofile;
    IBOutlet UIButton *btnBack;

    UIImage* selectedImage;
}
@end

@implementation JIMProfileCreateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setDefaultValue];
    [DefaultCenter addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [DefaultCenter addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma KeyBoard notification

- (void)keyboardShow:(NSNotification*)notify {
    if([txtResHall isFirstResponder] || [txtMajor isFirstResponder]) {
    CGRect keyboardRect = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue] ;
    parentViewBottomSpace.constant = keyboardRect.size.height;
    parentviewTopSpace.constant = - keyboardRect.size.height;
    }
}

- (void)keyboardHide:(NSNotification*)notify {
    parentviewTopSpace.constant = 0;
    parentViewBottomSpace.constant = 0;
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
    
    param[@"graduation_year"] = txtGrYear.text;
    param[@"resident_hall"] = txtResHall.text;
    param[@"major"] = txtMajor.text;
    param[@"id"] = me.userID;
    param[@"bio"] = txtviewBio.text;
    if(selectedImage){
        [WSCall updateImage:selectedImage param:@{@"id":me.userID} fieldName:@"profile_pic_url" block:^(id JSON, WebServiceResult result) {
            if (result == WebServiceResultSuccess) {
                [me setInfo:JSON[@"data"]];
                [UserDefault setObject:JSON[@"data"] forKey:@"loginUser"];
            }
            else
            {
                
            }
        }];
    }
    

    [WSCall updateProfileWithParam:param block:^(id JSON, WebServiceResult result) {
        if (result == WebServiceResultSuccess) {
            [me setInfo:JSON[@"data"]];
            [UserDefault setObject:JSON[@"data"] forKey:@"loginUser"];
            if(profileEditing)
            {
                profileEditing = NO;
                NSInteger count = self.navigationController.viewControllers.count;
                [self.navigationController popToViewController:self.navigationController.viewControllers[count - 3] animated:YES];
            }
            else
            {
                [self.tabBarController setSelectedIndex:1];
            }
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
            if ([JSON[@"status"] isEqualToString:@"1"]) {
            [me setInfo:JSON[@"data"]];
                if(profileEditing) {
                    id vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_SetupProfileStep2"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else{
                    [self performSegueWithIdentifier:@"myProfileViewSegue" sender:self];
                }
            }
            else
            {
                showAletViewWithMessage(@"Something goes to wrong. Please try again.");
            }
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
    btnprofile.layer.cornerRadius = btnprofile.frame.size.height/2;
    btnprofile.clipsToBounds = YES;
    btnBack.hidden = profileEditing ? NO : YES;


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
    NSLog(@"open gallery call");

    UIImagePickerController *ipic = [[UIImagePickerController alloc]init];
    ipic.sourceType  = UIImagePickerControllerSourceTypePhotoLibrary;
    ipic.delegate = self;
    ipic.editing = YES;
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
    [ipic setDelegate:self];
    ipic.editing = YES;
    [self presentViewController:ipic animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage* image = info[UIImagePickerControllerOriginalImage];
    selectedImage = image;
    [btnprofile setBackgroundImage:selectedImage forState:UIControlStateNormal];
    [btnprofile setImage:nil forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"pickr method call");
}

@end
