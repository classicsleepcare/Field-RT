//
//  NewTransferModel.h
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewTransferModel : NSObject

@property (strong, nonatomic) NSArray *arr_inventory_on_hand, *arr_rt_transfer_listing;


@property (strong, nonatomic) NSString *msg;

-(id)initWithDictionary:(NSDictionary*)dict;


@end
