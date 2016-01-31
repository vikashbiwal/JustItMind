//
//  ViewController.m
//  JustItMind
//
//  Created by Viksah on 9/24/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMViewController.h"
#define mainScreen [UIScreen mainScreen].bounds

@interface JIMViewController ()
{
    IBOutlet NSLayoutConstraint *unversityIDBckgrndTopSpaceConstraint;
    IBOutlet NSLayoutConstraint *unversityIDBckgrndLeadignSpaceConstraint;
    
    IBOutlet NSLayoutConstraint *confirmCodeBckgrndTopSpaceConstraint;
    IBOutlet NSLayoutConstraint *confirmCodeBckgrndLeadingSpaceConstraint;
    IBOutlet UITextField *txtUniversityId;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtCode;
}
@end

@implementation JIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    if(me) {
        txtCode.text = me.verificationCode;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)onGetCodeBtnClick:(id)sender
{
    if (![self validateInput]) {
        return;
    }
    
    id dic = @{@"university_id" : txtUniversityId.text,  @"universityemail": txtEmail.text, @"user_type":@"RA"};
    [self showHud];
    [WSCall registerUserWithParam:dic  block:^(id JSON, WebServiceResult result) {
        [self hideHud];
        if (result == WebServiceResultSuccess) {
            me = [[User alloc]init];
            [me setInfo:JSON[@"data"]];
            [self performSegueWithIdentifier:@"nextSegue" sender:nil];
        }
        else{
        }
    }];

    
}

- (IBAction)onLetsGoBtnClick:(id)sender
{
    if(txtCode.text.length > 0) {
        id param = @{@"id": me.userID, @"randomCode":txtCode.text};
        [WSCall verifyCodeForUser:param block:^(id JSON, WebServiceResult result) {
            if(result == WebServiceResultSuccess) {
                if ([JSON[@"status"] intValue] == 1) {
                    [self performSegueWithIdentifier:@"nextToProfileSegue" sender:nil];
                }
            }
        }];
    }
    else{
        showAletViewWithMessage(@"Please enter code.");
    }
}

- (void)setUI
{

    if(mainScreen.size.width == 375)
    {
        confirmCodeBckgrndTopSpaceConstraint.constant     = 48;
        confirmCodeBckgrndLeadingSpaceConstraint.constant = 180;
        unversityIDBckgrndTopSpaceConstraint.constant     = 38;
        unversityIDBckgrndLeadignSpaceConstraint.constant = 101;
    }
    if(mainScreen.size.width == 414)
    {
        confirmCodeBckgrndTopSpaceConstraint.constant     = 65;
        confirmCodeBckgrndLeadingSpaceConstraint.constant = 200;
        unversityIDBckgrndTopSpaceConstraint.constant     = 55;
        unversityIDBckgrndLeadignSpaceConstraint.constant = 111;
    }
}

- (BOOL)validateInput {
    NSLog(@"emal : %@",txtEmail.text);
    if(txtEmail.text.length > 0) {
        if (![self validateEmailWithString:txtEmail.text]){
            showAletViewWithMessage(@"Please enter your valid email.");
            return NO;
        }
    }
    else {
        showAletViewWithMessage(@"Please enter your email.");
        return NO;
    }
    if (txtUniversityId.text.length > 0) {
        
    }
    else
    {
        showAletViewWithMessage(@"Please enter university ID.");
        return NO;

    }
    return YES;
}


- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end

