//
//  JIMProfileVC.m
//  JustItMind
//
//  Created by Viksah on 11/3/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMProfileVC.h"
#import "UIImageView+AFNetworking.h"

@interface JIMProfileVC ()
{
    
    IBOutlet UIImageView *coverImageView;
    IBOutlet NSLayoutConstraint *coverimageHeight;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblDorm;
    IBOutlet UILabel *lblMajor;
    IBOutlet UILabel *lblBio;
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
    lblBio.text = me.bio;
    lblGrYear.text = [NSString stringWithFormat:@"Class of %@", me.grYear];
    [imgVProfile setImageWithURL:[NSURL URLWithString:me.profileImageUrl] placeholderImage:[UIImage imageNamed:@"photo_bg"]];
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
