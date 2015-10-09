//
//  JIMProfileSettingVC.m
//  JustItMind
//
//  Created by Viksah on 10/5/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMProfileSettingVC.h"

@interface JIMProfileSettingVC ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation JIMProfileSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - IBActions

- (IBAction)onProfileBtnClick:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Choose from" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery", nil];
    
    [sheet showInView:self.view];
}

- (IBAction)onFinishProfileClick:(id)sender
{
    [self.tabBarController setSelectedIndex:1];
    userInformation = [[NSMutableDictionary alloc]init];//tempDic need to remove it
    [DefaultCenter postNotificationName:@"MenuShowHideNotification" object:nil];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
