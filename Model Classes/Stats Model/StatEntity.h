//
//  StatEntity.h
//  RAP APP
//
//  Created by Anil Prasad on 5/1/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatEntity : NSObject

@property (nonatomic, strong) NSString *str_entityTitle;
@property (nonatomic, strong) NSMutableArray *arr_entityRows;
@property (nonatomic, strong) NSArray *arr_source;
+(StatEntity *) getObjectUsingInfo:(NSDictionary *)dictInfo;
-(id)initWithResponseUsingInfo:(NSDictionary*)dictInfo;
@end


@interface StatEntityRow : NSObject

@property (nonatomic, strong) NSString *str_approved;
@property (nonatomic, strong) NSString *str_denied;
@property (nonatomic, strong) NSString *str_setup;
@property (nonatomic, strong) NSString *str_referred;
@property (nonatomic, strong) NSString *str_nsu;
@property (nonatomic, strong) NSString *str_rowTitle;
@property (nonatomic, strong) NSString *str_supply;

@property (nonatomic, weak) StatEntity *attributeEntity;

+(StatEntityRow *) getObjectUsingInfo:(NSDictionary *)dictInfo;

@end