//
//  JIMCommentCell.h
//  JustItMind
//
//  Created by Viksah on 10/16/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JIMCommentCell : UITableViewCell
@property (strong, nonatomic)NSArray *arrComments;
@property (strong, nonatomic)IBOutlet UITableView *tblComments;
- (void)reloadComments;
@end
