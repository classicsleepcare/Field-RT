//
//  AppDelegate.h
//  RAP APP
//
//  Created by Anil Prasad on 4/4/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <CoreData/CoreData.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *rep_patientID, *str_profilePic,*User_id, *rt_ID;
@property (strong, nonatomic) NSArray *arr_facilities;

-(void)showAlertMessage :(NSString *)message;
-(void)showSuccesMessage :(NSString *)message;

+(AppDelegate*)sharedInstance;
-(void)showCustomLoader:(UIViewController*)viewController;
-(void)removeCustomLoader;

/*
 
 A shared application context created with the main queue concurrency type.
 
 */
//+ (NSManagedObjectContext *)managedObjectContext;

@end
