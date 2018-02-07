//
//  InventoryView.h
//  RT APP
//
//  Created by Anil Prasad on 23/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InventoryView : NSObject
{
    NSDictionary *dictionary;
}

-(NSDictionary*)getListOfInventoryWithID:(NSString*)ID page:(NSString*)page limit:(NSString*)limit;

-(NSDictionary*)getTicketNumOfItem:(NSString*)ID withSerial:(NSString*)num;


@end
