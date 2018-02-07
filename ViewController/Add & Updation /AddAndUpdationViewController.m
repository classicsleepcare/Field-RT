//
//  AddAndUpdationViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 6/24/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "AddAndUpdationViewController.h"
#import "UpdateDoctorViewController.h"
#import "AddNewDoctorViewController.h"
#import "AddDoctorView.h"
#import "AddDoctorModel.h"
#import "AppDelegate.h"

@interface AddAndUpdationViewController ()
{
    UITabBarController *tabBarController;
}

@end

@implementation AddAndUpdationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tabBarController = [[UITabBarController alloc] init];

   // tabBarController.view.frame = CGRectMake(0, 80,1024, 738);
    tabBarController.view.frame = CGRectMake(0, 80,1024, 924);
    
    UINavigationController *firstRootNavigation = [[UINavigationController alloc]initWithRootViewController:[[AddNewDoctorViewController alloc]initWithNibName:@"AddNewDoctorViewController" bundle:nil]];
    UINavigationController *secondRootNavigation = [[UINavigationController alloc]initWithRootViewController:[[UpdateDoctorViewController alloc]initWithNibName:@"UpdateDoctorViewController" bundle:nil]];
    firstRootNavigation.navigationBarHidden=YES;
      secondRootNavigation.navigationBarHidden=YES;
    
    tabBarController.viewControllers = @[firstRootNavigation,secondRootNavigation];
    [self.view addSubview:tabBarController.view];
    [self getFacilities];
	// Do any additional setup after loading the view.
}

-(void)getFacilities
{
    dispatch_queue_t newQ = dispatch_queue_create("new", 0);
    dispatch_async(newQ, ^{
        
        AddDoctorView *object_view = [AddDoctorView new];
        NSDictionary *dict = [object_view getAllFacilty:[AppDelegate sharedInstance].rep_patientID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            if(dict)
            {
                AddDoctorModel *object_model = [AddDoctorModel allFacilitiesFromDictionary:dict];
                [AppDelegate sharedInstance].arr_facilities = object_model.arr_Facilities;
            }
        });
    });
    [[AppDelegate sharedInstance] showCustomLoader:self];
}


- (IBAction)addAndUpdateSegment:(UISegmentedControl*)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        tabBarController.selectedIndex = 0;
    }
    else tabBarController.selectedIndex = 1;
}
-(void)action_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
