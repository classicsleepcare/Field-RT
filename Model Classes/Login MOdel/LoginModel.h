//
//  LoginModel.h
//  RAP APP
//
//  Created by Anil Prasad on 4/8/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject
@property(nonatomic,strong) NSString *ID, *username,
*access_level,
*emp_access,
*user_id,
*emp_id,
*msg;

@property (nonatomic,strong) NSString * change_passwords;
@property(nonatomic,strong)NSString *access_id , *str_profilePic, *rt_access_id, *rt_name;


-(id)initWithPtientDetailsFromDictionary :(NSDictionary*)dict;
@end
