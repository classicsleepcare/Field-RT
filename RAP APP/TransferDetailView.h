//
//  TransferDetailView.h
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransferDetailView : NSObject{
    NSDictionary *dictionary;
}

-(NSDictionary*)getTransferDetailsOfRT:(NSString*)rtId transferID:(NSString*)ID;

//-(NSDictionary*)receiveTransfersOfRT:(NSString*)rtId transfer_id:(NSString*)transfer_id from_id:(NSString*)fromId json_request:(NSString*)json;

@end
