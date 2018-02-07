//
//  DoctorDetailCell.m
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "DoctorDetailCell.h"
#import "AppDelegate.h"

@implementation DoctorDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)addressDirectionMethod:(id)sender
{
    [[AppDelegate sharedInstance] showAlertMessage:@"Want to know direction for following address?"];
}
@end
