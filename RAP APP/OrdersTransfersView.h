//
//  OrdersTransfersView.h
//  RT APP
//
//  Created by Anil Prasad on 11/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrdersTransfersView : NSObject

{
    NSDictionary *dictionary;
}

-(NSDictionary*)getOrderListings:(NSString*)ID;

-(NSDictionary*)getTransferListings:(NSString*)ID;


@end
