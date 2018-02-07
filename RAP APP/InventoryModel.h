//
//  InventoryModel.h
//  RT APP
//
//  Created by Anil Prasad on 23/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InventoryModel : NSObject{
}

@property (strong, nonatomic) NSArray *arr_serialized;
@property (strong, nonatomic) NSArray *arr_unSerialized;
@property (strong, nonatomic) NSDictionary *dictionary;
@property (strong, nonatomic) NSString *msg;

@property (strong, nonatomic) NSString *ticket_id;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
