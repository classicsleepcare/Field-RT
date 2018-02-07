//
//  LoginViews.h
//  RAP APP
//
//  Created by Anil Prasad on 4/8/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViews : NSObject
{
    NSDictionary *dictionary;
}
//url_ChangePwd
-(NSDictionary*)getDectionaryFromLoginDetails:(NSString*)username password:(NSString*)password;

-(NSDictionary *)getDectionaryFromChagePwd:(NSString *)userName currentpassword:(NSString *)currentPwd newPassWord:(NSString *)newPwd confirmPassword:(NSString *)confirmPwd;



@end
