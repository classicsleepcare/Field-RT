//
//  HistoryView.h
//  RAP APP
//
//  Created by Anil Prasad on 4/20/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryView : NSObject
{
    NSDictionary *dictionary;
}
-(NSDictionary *)getHistoryListForId:(NSString*)ID FromDate:(NSString*)date;
-(NSDictionary *)getDetailListForPatientOfId:(NSString *)ID;

-(NSDictionary *)getAllHistroyItemsOfId:(NSString *)ID;

@end
