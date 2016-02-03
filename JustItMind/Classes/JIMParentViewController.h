//
//  SCParentViewController.h
//  ShiftCalendar
//
//  Created by iOSDeveloper2 on 07/10/13.
//  Copyright (c) 2013 Yudiz Pvt. Solution Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define __ThresholdPoint 260

@interface JIMParentViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UILabel    *parentlblTitle;
    IBOutlet UIButton   *btnHeader;
    @package
    UIControl *transperantView;
    
}


@property(nonatomic,strong)IBOutlet UITableView *tableView;

-(void)showHud;
-(void)hideHud;
-(void)showHudWithUI;
-(void)startActivity;
-(void)stopActivity;

-(IBAction)parentBackAction:(id)sender;
-(IBAction)parentRootBackAction:(id)sender;
-(IBAction)parentDismissAction:(id)sender;
-(IBAction)parentBackDismissAction:(id)sender;
-(IBAction)shutterAction:(id)sender;
- (NSArray *)sortArray:(NSArray*)array fieldName:(NSString*)strKey;
#pragma mark - utility methods
-(BOOL)checkTextfieldValue:(UITextField *)textField;
-(BOOL)validateEmail:(NSString *)candidate;
-(void)showAletViewWithMessage: (NSString*) msg;
-(void)animatedDrawerEffectForView:(UIView*)animatedView;
@end
