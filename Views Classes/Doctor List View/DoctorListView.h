//
//  DoctorListView.h
//  RAP APP
//
//  Created by Anil Prasad on 4/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorListView : NSObject
{
    NSDictionary *dictionary;
}

-(NSDictionary*)getDoctorListForId:(NSString*)ID;
@end
