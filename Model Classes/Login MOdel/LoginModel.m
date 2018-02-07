//
//  LoginModel.m
//  RAP APP
//
//  Created by Anil Prasad on 4/8/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

-(id)initWithPtientDetailsFromDictionary :(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        _ID                 = dict[@"id"];
        _username           = dict[@"username"];
        _access_level       = dict[@"access_level"];
        _emp_access         = dict[@"emp_access"];
        _user_id            = dict[@"user_id"];
        _emp_id             = dict[@"emp_id"];
        _msg                = dict[@"msg"];
        _access_id          = dict[@"access_id"];
        _rt_name            = dict[@"rt_name"];

        _rt_access_id       = dict[@"rt_access_id"];
        _str_profilePic     = dict[@"profile_pic"];
        _change_passwords   = dict[@"change_password"] ;
        
    }
    return self;
}

@end
