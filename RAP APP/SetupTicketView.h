//
//  SetupTicketView.h
//  RT APP
//
//  Created by Anil Prasad on 24/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetupTicketView : NSObject{
    NSDictionary *dictionary;
}

-(NSDictionary*)getListOfSetupTicketWithID:(NSString*)ID andOption:(NSString*)option;


@end
