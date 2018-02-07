//
//  ChangePWDModel.h
//  RAP APP
//
//  Created by prashant sharma on 9/4/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangePWDModel : NSObject
@property (nonatomic,strong) NSString * mesg;


-(id)initWithDetailsOfChangePWD:(NSDictionary *)dicit;
@end
