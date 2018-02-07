//
//  Utils.h
//  RT APP
//
//  Created by Anil Prasad on 15/10/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NonNilString(str) [NSString stringWithFormat:@"%@",str ? str : @""]

@interface Utils : NSObject

+ (Utils *)sharedInstance;

+ (UIImage*)getImage:(NSString*)initialFileName;

+ (void)saveAllKeysAndValues:(NSMutableDictionary *)formData;
+ (NSString*)getTextForKey:(NSString*)key;
+ (void)saveImage:(UIImage *)image forKey:(NSString*)key;
+ (UIImage*)getImageForKey:(NSString*)key;
+ (void)resetDefaults;
+ (void)setEditingMode:(BOOL)mode;
+ (BOOL)isEditingMode;

+ (NSString*)setDateFormatFormString:(NSDate*)date;
+ (NSString*)setDateFormatForAPI:(NSDate*)dateStr;
+ (void)setTodaysDateToTextFields:(NSArray*)array;
+ (NSDate*)stringToDateWithFormat:(NSString*)format andStringDate:(NSString*)dateString;

+ (void)checkBox:(UIButton*)sender;
+ (void)uncheckBox:(UIButton*)sender;
+ (void)uncheckBoxes:(NSArray*)buttons;
+ (BOOL)performCheckboxSelection:(UIButton*)sender;
+ (BOOL)isChecked:(UIButton*)sender;

+ (void)takeScreenshot:(UIScrollView*)scrollView;
+ (void)emptyTextFields:(NSArray*)array;
+ (BOOL)validateEmptyTextFields:(NSArray*)array;

+ (NSString*)createJSON:(id)dictionaryOrArrayToOutput;

@end
