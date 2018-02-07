//
//  CustomLabel.m
//  RAP APP
//
//  Created by Anil Prasad on 6/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.labelTag = self.tag;
        self.textColor = [UIColor blueColor];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
    
    
    
}

//- (void)drawRect:(CGRect)rect {
//    self.labelTag = self.tag;
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CLICKED_LABEL" object:[NSNumber numberWithInt:self.labelTag]];
    
}
@end
