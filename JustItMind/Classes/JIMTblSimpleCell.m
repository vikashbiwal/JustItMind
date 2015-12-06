//
//  JIMTblSimpleCell.m
//  JustItMind
//
//  Created by Viksah on 11/4/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMTblSimpleCell.h"

@implementation JIMTblSimpleCell

- (void)awakeFromNib {
    [self setShadowToView:self.viewBg];
}
- (void)setShadowToView:(UIView*)view
{
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.8];
    [view.layer setShadowRadius:3.0];
    [view.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    view.layer.cornerRadius = 5.0f;
    view.layer.borderColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.3].CGColor;
    view.layer.borderWidth = 2.0;
    view.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
