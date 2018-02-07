//
//  LoginViews.m
//  RAP APP
//
//  Created by Anil Prasad on 4/8/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "LoginViews.h"

@implementation LoginViews



-(NSDictionary*)getDectionaryFromLoginDetails:(NSString*)username password:(NSString*)password
{
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_rtLogin,username,password];
    

    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    
    NSLog(@"Dictionary: %@", dictionary);

    return dictionary;
}


/// Old code
-(NSDictionary *)getDectionaryFromChagePwd:(NSString *)ids currentpassword:(NSString *)currentPwd newPassWord:(NSString *)newPwd confirmPassword:(NSString *)confirmPwd
{
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_ChangePwd,ids,currentPwd,newPwd,confirmPwd];
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    return dictionary;
}

@end
