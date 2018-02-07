//
//  StockTakeView.h
//  RT APP
//
//  Created by Anil Prasad on 24/09/15.
//  Copyright © 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockTakeView : NSObject

{
    NSDictionary *dictionary;
}

-(NSDictionary*)submitInventoryOfRT:(NSString*)rtId
                       machinesJson:(NSString*)machine
                      hum_modemJson:(NSString*)hum
                          modemJson:(NSString*)modem
                           maskJson:(NSString*)mask;

@end
