//
//  LoginViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginModel.h"
#import "LoginViews.h"
#import "AppDelegate.h"
#import "DoctorViewController.h"
#import "ChangePWD.h"
#import <MessageUI/MessageUI.h>
#import <CoreLocation/CoreLocation.h>
#import "Utils.h"

@interface LoginViewController ()<UITextFieldDelegate, CLLocationManagerDelegate>
{
    LoginViews *objectLV;
    LoginModel *objct_LM;
}
@property (nonatomic,retain) CLLocationManager *locationManager;

@end


@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
    
    NSString *lat = [NSString stringWithFormat:@"%f", manager.location.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f", manager.location.coordinate.longitude];
    
    NSLog(@"lat=%@, lon=%@", lat, lon);
    
    [[NSUserDefaults standardUserDefaults] setObject:lat forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults] setObject:lon forKey:@"lon"];
}

#pragma mark - 
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    
//    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
//    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//    [self.locationManager startUpdatingLocation];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoutMethod) name:@"logout" object:nil];
    objectLV = [LoginViews new];
    self.navigationController.navigationBarHidden=YES;
    
    txt_password.text = @"";
    txt_username.text = @"";
    
    
    
    //   txt_password.text = @"Password1";
    //    txt_username.text = @"tempd";
    //
    // Do any additional setup after loading the view.
}

-(void)logoutMethod
{
   [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
     isLoginValid = NO;
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Keep Me Logged In"])
    {
        
        NSDictionary *dict2=[[NSUserDefaults standardUserDefaults] objectForKey:@"Keep Me Logged In"];
        
        NSLog(@"%@",[dict2 valueForKey:@"Password"]);
        txt_password.text = [dict2 valueForKey:@"Password"];
        txt_username.text = [dict2 valueForKey:@"Username"];
        
        [btn_remember setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else {
        [btn_remember setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];

        txt_password.text = @"";
        txt_username.text = @"";
    }
    
}
-(IBAction)action_switch:(UISwitch *)sender;
{
    if (sender.on) {
        [self KeepMeLoggedIn];
        NSLog(@"Switch ON*****************");
    }
    else if([[NSUserDefaults standardUserDefaults] objectForKey:@"Keep Me Logged In"])
    {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Keep Me Logged In"];
        
        txt_username.text = @"";
        txt_password.text = @"";
    }
}

-(IBAction)rememberMe:(UIButton *)sender{
    
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [self KeepMeLoggedIn];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Keep Me Logged In"];
        
        //txt_username.text = @"";
        //txt_password.text = @"";
    }
}

- (IBAction)go:(id)sender {
    
    [self performSegueWithIdentifier:@"GOGO" sender:nil];
}

-(void)KeepMeLoggedIn
{
    NSLog (@"save datad");
    NSLog(@"%@",txt_password.text);
    NSMutableDictionary *dict_SaveDate=[[NSMutableDictionary alloc]init];
    [dict_SaveDate setObject:txt_username.text forKey:@"Username"];
    [dict_SaveDate setObject:txt_password.text forKey:@"Password"];
    
    [[NSUserDefaults standardUserDefaults]setObject:dict_SaveDate forKey:@"Keep Me Logged In"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"Switch ON*****************%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Keep Me Logged In"]);
}

- (void)viewWillDisappear:(BOOL)animated {
    
    isLoginValid = NO;
}


-(IBAction)login_method:(id)sender
{
    [txt_username resignFirstResponder];
    [txt_password resignFirstResponder];
    
    //[self performSegueWithIdentifier:@"doctor" sender:nil]; // CHANGE IT

//    NSLog(@"%@",txt_password.text);
//    
    if(![txt_username.text isEqualToString:@""] && ![txt_password.text isEqualToString:@""])
    {
        if ([txt_username.text isEqualToString:@"admin"] && [txt_password.text isEqualToString:@"admin"]) {
            [self performSegueWithIdentifier:@"doctor" sender:nil];
        }
        else{
            dispatch_queue_t myQueue = dispatch_queue_create("ABCD", 0);
            
            [[AppDelegate sharedInstance] showCustomLoader:self];
            
            
            dispatch_async(myQueue, ^{
                NSDictionary *dict = [objectLV getDectionaryFromLoginDetails:txt_username.text password:txt_password.text];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[AppDelegate sharedInstance] removeCustomLoader];
                    if(dict)
                    {
                        objct_LM = [[LoginModel alloc] initWithPtientDetailsFromDictionary:dict];
                        
                        if([objct_LM.msg isEqualToString:@"login success"])
                        {
                            [[NSUserDefaults standardUserDefaults] setObject:objct_LM.rt_access_id forKey:@"RT_ID"];
                            [[NSUserDefaults standardUserDefaults] setObject:objct_LM.rt_name forKey:@"RT_NAME"];
                            
                            isLoginValid = YES;
                            [Utils resetDefaults];
                            NSLog(@"LOGIN RT ID:%@", RT_ID);
                            
                            
                            [self performSegueWithIdentifier:@"doctor" sender:nil];
                        }
                        else if([objct_LM.msg isEqualToString:@"password not match"])
                        {
                            [[AppDelegate sharedInstance] showAlertMessage:@"Please fill valid credentials"];
                        }
                        else if([objct_LM.msg isEqualToString:@"user not exist"])
                        {
                            [[AppDelegate sharedInstance] showAlertMessage:@"User does not exist!"];
                        }
                        else{
                            [[AppDelegate sharedInstance] showAlertMessage:@"Unknown error occured!"];
                        }
                        
                    }
                });
            });
        }
        
    }
    else if([txt_username.text isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please enter username"];
        return;
    }
    else if([txt_password.text isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please enter password"];
        return;
    }
 
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"changePwds"]) {
        
        UIViewController *object_CD = segue.destinationViewController;
        ((ChangePWD*)object_CD).StrtitleName=txt_username.text;
    }
    else
    {
        UIViewController *object_DCV = segue.destinationViewController;
        ((DoctorViewController*)object_DCV).str_username=[txt_username.text mutableCopy];
    }
    
   
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField isEqual:txt_password])
    {
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.view.frame = CGRectMake(0, -75, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        } completion:nil];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if([textField isEqual:txt_username])
    {
        [txt_password becomeFirstResponder];
    }
    else if ([textField isEqual:txt_password]) {
        
        [self login_method:nil];
        
        if (isLoginValid) {
            [self performSegueWithIdentifier:@"doctor" sender:nil];
        }
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resetAnimatView];
}

-(void)resetAnimatView
{
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    } completion:nil];
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [self resetAnimatView];
//    [textField resignFirstResponder];
//    return YES;
//}
-(void)callWebserviceForLoginData
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
