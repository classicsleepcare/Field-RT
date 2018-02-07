//
//  TransferDetailModel.h
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransferDetailModel : NSObject

@property (strong, nonatomic) NSDictionary *dict_rt_transfer_detail;
@property (strong, nonatomic) NSArray *arr_items_receiving;
@property (strong, nonatomic) NSString *msg;
@property (strong, nonatomic) NSString *from_location;
@property (strong, nonatomic) NSString *transfer_id;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
