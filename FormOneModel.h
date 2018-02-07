//
//  FormOneModel.h
//  RT APP
//
//  Created by Anil Prasad on 03/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormOneModel : NSObject

@property (strong, nonatomic) NSString *itemID;
@property (strong, nonatomic) NSString *itemType;
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSString *quantity;
@property (strong, nonatomic) NSString *size;
@property (strong, nonatomic) NSString *notes;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
