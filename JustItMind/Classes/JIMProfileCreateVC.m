//
//  profileCreateVC.m
//  TestApp
//
//  Created by Viksah on 9/21/15.
//  Copyright (c) 2015 Viksah. All rights reserved.
//

#import "JIMProfileCreateVC.h"
#define mainScreen [UIScreen mainScreen].bounds

@interface JIMProfileCreateVC ()
{
    IBOutlet NSLayoutConstraint *lastNameBckgrndTopSpaceConstraint;
    IBOutlet NSLayoutConstraint *lastNameBckgrndLeadignSpaceConstraint;
    
    IBOutlet NSLayoutConstraint *grYearBckgrndTopSpaceConstraint;
    IBOutlet NSLayoutConstraint *grYearBckgrndLeadingSpaceConstraint;
    
    IBOutlet NSLayoutConstraint *hallBckgrndBottomSpaceConstraint;
    IBOutlet NSLayoutConstraint *hallBckgrndLeadingSpaceConstraint;
    
    IBOutlet NSLayoutConstraint *majorBckgrndBottomSpaceConstraint;
    IBOutlet NSLayoutConstraint *majorBckgrndLeadingSpaceConstraint;
    
   

}
@end

@implementation JIMProfileCreateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark - IBActons
- (IBAction)onSetupProfileClick:(id)sender
{
    [self performSegueWithIdentifier:@"myProfileViewSegue" sender:self];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
