//
//  OrderDetailModel.h
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property (strong, nonatomic) NSDictionary *dict_rt_order_detail;
@property (strong, nonatomic) NSArray *arr_items_receiving;
@property (strong, nonatomic) NSString *msg;
@property (strong, nonatomic) NSString *from_location;
@property (strong, nonatomic) NSString *transfer_id;
@property (strong, nonatomic) NSString *pt_notes;

@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *date_shipped;
@property (strong, nonatomic) NSString *items;


-(id)initWithDictionary:(NSDictionary*)dict;


@end
