//
//  AppDelegate.m
//  RAP APP
//
//  Created by Anil Prasad on 4/4/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "FSVerticalTabBarController.h"
#import <QuartzCore/QuartzCore.h>
#define USE_ENCRYPTED_STORE 1

@implementation AppDelegate
{
    UIView *view_loading,*aboveView;
    UIActivityIndicatorView *activity_indicator;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    float loanAmt = 500000;
    float interestRate = 10.25;
    
    float withoutInterestInstalment = loanAmt / 12;
    float monthlyInterest = interestRate * loanAmt / 100;
    float monthlyInstalment = withoutInterestInstalment + monthlyInterest;
    
    NSLog(@"First: %f", monthlyInstalment);
    
    float payableAmt = 0;
    
    for (int count = 0; count < 60; count++) {
        loanAmt = loanAmt - withoutInterestInstalment;
        float monthlyInterest = interestRate * loanAmt / 100;
        float monthlyInstalment = withoutInterestInstalment + monthlyInterest;
        
        payableAmt += monthlyInstalment;
        NSLog(@"%i: %f", count, monthlyInstalment);
    }
     
    
    NSLog(@"Total : %f", payableAmt);
    */
    
    sleep(0);
    
    aboveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 ,1024,768)];
   
    [aboveView setBackgroundColor:[UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:121.0/255.0 alpha:0.4]];

    view_loading =[[UIView alloc] initWithFrame:CGRectMake(370,250,120,107)];
    view_loading.backgroundColor = [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:61.0/255.0 alpha:1.0];
    activity_indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity_indicator.frame = CGRectMake(35,30,45,45);
    activity_indicator.color= [UIColor whiteColor];
    activity_indicator.alpha=1.0;
    view_loading.center=aboveView.center;
    [view_loading addSubview:activity_indicator];
    view_loading.layer.cornerRadius = 20.0;
    //self.window.backgroundColor = [UIColor whiteColor];
        
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
+(AppDelegate *)sharedInstance
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}
-(void)showAlertMessage :(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message!" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    alert = nil;
}
-(void)showSuccesMessage :(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success!" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    alert = nil;
}

-(void)showCustomLoader:(UIViewController*)viewController
{
    
    
    if ([viewController isKindOfClass:[LoginViewController class]]) {
        CGPoint point =viewController.view.center;
        view_loading.center = point;
    }
    else
    {
        view_loading.center= CGPointMake(430, 303);
    }
   
    [activity_indicator startAnimating];
    [viewController.view addSubview:aboveView];
    [viewController.view bringSubviewToFront:aboveView];
    [self addSubviewWithBounce:view_loading onView:aboveView];
   
}
-(void)removeCustomLoader
{
    [activity_indicator stopAnimating];
    [aboveView removeFromSuperview];
}
-(void)addSubviewWithBounce:(UIView*)theView onView:(UIView *)mainView
{
    theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0);
    
    [mainView addSubview:theView];
    
    [UIView animateWithDuration:0.3/1.5 animations:
     ^{
         theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.3/2 animations:^
          {
              theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
          }
                          completion:^(BOOL finished)
          {
              [UIView animateWithDuration:0.3/2 animations:^
               {
                   theView.transform = CGAffineTransformIdentity;
               }];
          }];
     }];
    
}

#pragma mark - Core Data
//
//+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
//    static NSPersistentStoreCoordinator *coordinator = nil;
//    static dispatch_once_t token;
//    dispatch_once(&token, ^{
//        
//        // get the model
//        NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
//        
//        // get the coordinator
//        coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
//        
//        // add store
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSURL *applicationSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
//        [fileManager createDirectoryAtURL:applicationSupportURL withIntermediateDirectories:NO attributes:nil error:nil];
//        NSURL *databaseURL = [applicationSupportURL URLByAppendingPathComponent:@"databaseee.sqlite"];
//        NSError *error = nil;
//        
//        //        [[NSFileManager defaultManager] removeItemAtURL:databaseURL error:&error];
//        
//        NSDictionary *options = @{
//                                  EncryptedStorePassphraseKey : @"DB_KEY_HERE",
//                                  EncryptedStoreDatabaseLocation : databaseURL,
//                                  NSMigratePersistentStoresAutomaticallyOption : @YES,
//                                  NSInferMappingModelAutomaticallyOption : @YES
//                                  };
//        
//        NSPersistentStore *store = [coordinator
//                                    addPersistentStoreWithType:EncryptedStoreType
//                                    configuration:nil
//                                    URL:databaseURL
//                                    options:options
//                                    error:&error];
//        //        coordinator = [EncryptedStore makeStoreWithOptions:options managedObjectModel:model];
//        
//        NSAssert(store, @"Unable to add persistent store!\n%@", error);
//        
//    });
//    return coordinator;
//}
//
//+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator_CoreData {
//    NSError *error = nil;
//    NSURL *storeURL = [[[[NSFileManager defaultManager]
//                         URLsForDirectory:NSDocumentDirectory
//                         inDomains:NSUserDomainMask]
//                        lastObject]
//                       URLByAppendingPathComponent:@"cleardb.sqlite"];
//    
//    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
//    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
//    
//    return coordinator;
//    
//}
//
//+ (NSManagedObjectContext *)managedObjectContext {
//    static NSManagedObjectContext *context = nil;
//    static dispatch_once_t token;
//    dispatch_once(&token, ^{
//        context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//#if USE_ENCRYPTED_STORE
//        [context setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
//#else
//        [context setPersistentStoreCoordinator:[self persistentStoreCoordinator_CoreData]];
//#endif
//    });
//    return context;
//}
//
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
