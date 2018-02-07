//
//  Utils.m
//  RT APP
//
//  Created by Anil Prasad on 15/10/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (Utils *)sharedInstance {
    static Utils * __sharedInstance;
    if (!__sharedInstance) {
        __sharedInstance = [[Utils alloc] init];
    }
    
    return __sharedInstance;
}

+ (UIImage*)getImage:(NSString*)initialFileName{
    UIImage *signImg                = nil;
    NSString *urlString             = [NSString stringWithFormat:url_nivImage, initialFileName];
    signImg                         = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    
    return signImg;
}

+ (void)saveAllKeysAndValues:(NSMutableDictionary *)formData{
    [formData enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL* stop) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([value isKindOfClass:[UIImage class]]) {
            NSData* imageData = UIImagePNGRepresentation(value);
            [defaults setObject:imageData forKey:key];
        } else {
            [defaults setObject:value forKey:key];
        }
        [defaults synchronize];
    }];
}

+ (NSString*)getTextForKey:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* text = [defaults objectForKey:key];
    return text;
}

+ (void)saveImage:(UIImage *)image forKey:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData* imageData = UIImagePNGRepresentation(image);
    [defaults setObject:imageData forKey:key];
    [defaults synchronize];
}

+ (UIImage *)getImageForKey:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData* myEncodedImageData = [defaults objectForKey:key];
    UIImage* image = [UIImage imageWithData:myEncodedImageData];
    return image;
}

+ (void)resetDefaults{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        
        if ([key isEqualToString:@"Username"]) {}
        else if ([key isEqualToString:@"Password"]) {}
        else if ([key isEqualToString:@"RT_NAME"]) {}
        else if ([key isEqualToString:@"RT_ID"]) {}
        else if ([key isEqualToString:@"Keep Me Logged In"]) {}
        else if ([key isEqualToString:@"lat"]) {}
        else if ([key isEqualToString:@"lon"]) {}
        else {[defs removeObjectForKey:key];}
    }
    [defs synchronize];
}

+ (void)setEditingMode:(BOOL)mode{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:@"editMode"];
}

+ (BOOL)isEditingMode{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"editMode"]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Dates

+ (NSString*)setDateFormatFormString:(NSDate*)date {
    NSDateFormatter *FormatDate1 = [[NSDateFormatter alloc] init];
    [FormatDate1 setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate1 setDateFormat:@"MM/dd/yy"];
    NSString *selectedDate = [FormatDate1 stringFromDate:date];
    
    return selectedDate;
}

+ (NSString*)setDateFormatForAPI:(NSDate*)dateStr{
    NSDateFormatter *FormatDate1 = [[NSDateFormatter alloc] init];
    [FormatDate1 setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate1 setDateFormat:@"yyyy-MM-dd"];
    NSString *selectedDate = [FormatDate1 stringFromDate:dateStr];
    return selectedDate;
}

+ (NSDate*)stringToDateWithFormat:(NSString*)format andStringDate:(NSString*)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format]; // @"dd-MM-yyyy"
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}


#pragma mark - Checkbox Control

+ (void)checkBox:(UIButton*)sender{
    [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
}

+ (void)uncheckBox:(UIButton*)sender{
    [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
}

+ (void)uncheckBoxes:(NSArray*)buttons{
    for (UIButton *sender in buttons) {
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

+ (BOOL)performCheckboxSelection:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [self checkBox:sender];
        return true;
    }
    else{
        [self uncheckBox:sender];
        return false;
    }
}

+ (BOOL)isChecked:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) return true;
    return false;
}

+ (void)setTodaysDateToTextFields:(NSArray*)array{
    for (UITextField *textField in array) {
        NSDateFormatter *FormatDate1 = [[NSDateFormatter alloc] init];
        [FormatDate1 setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
        [FormatDate1 setDateFormat:@"MM/dd/yy"];
        textField.text = [FormatDate1 stringFromDate:[NSDate date]];
    }
}

+ (void)takeScreenshot:(UIScrollView*)scrollView
{
    UIImage* image = nil;
    
    UIGraphicsBeginImageContext(scrollView.contentSize);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        [UIImagePNGRepresentation(image) writeToFile: @"/Users/anilprasad/Desktop/test.png" atomically: YES];
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
}

+ (void)emptyTextFields:(NSArray*)array{
    for (UITextField *textField in array) {
        textField.text = @"";
    }
}

+ (BOOL)validateEmptyTextFields:(NSArray*)array{
    __block BOOL check;
    for (UITextField *textField in array) {
        if (textField.text && textField.text.length > 0){
            check = true;
        }
        else{
            check = false;
            break;
        }
    }
    return check;
}

+ (NSString*)createJSON:(id)dictionaryOrArrayToOutput{
    NSError *error;
    NSString *jsonString;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryOrArrayToOutput
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"Error generating JSON: %@", error);
    } else {
         jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
