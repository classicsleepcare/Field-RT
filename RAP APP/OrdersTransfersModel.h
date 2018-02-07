//
//  OrdersTransfersModel.h
//  RT APP
//
//  Created by Anil Prasad on 11/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrdersTransfersModel : NSObject

@property (strong, nonatomic) NSArray *arr_rt_transfer_listing;
@property (strong, nonatomic) NSArray *arr_rt_order_listing;
@property (strong, nonatomic) NSString *msg;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
