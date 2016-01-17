//
//  TableViewCells.h
//  JustItMind
//
//  Created by Viksah on 12/27/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFeedCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblDate;
@property (nonatomic, strong) IBOutlet UILabel *lblTime;
@property (nonatomic, strong) IBOutlet UILabel *lblLocation;
@property (nonatomic, strong) IBOutlet UILabel *lblDescription;
@property (nonatomic, strong) IBOutlet UIImageView *imgView;
@end

@interface JProfileCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *arrFeeds;
-(void)reloadFeeds;

@end