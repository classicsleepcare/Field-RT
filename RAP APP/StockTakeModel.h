//
//  StockTakeModel.h
//  RT APP
//
//  Created by Anil Prasad on 24/09/15.
//  Copyright © 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockTakeModel : NSObject

@property (strong, nonatomic) NSString *msg;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
