//
//  ChangePWD.m
//  RAP APP
//
//  Created by prashant sharma on 9/4/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "ChangePWD.h"
#import "AppDelegate.h"
#import "LoginModel.h"
#import "LoginViews.h"
#import "ChangePWDModel.h"
#import "DoctorViewController.h"

@interface ChangePWD ()
{
    LoginViews * object_PVS;
    NSString * str_CurrentPwd,*str_NewPwd,*str_ConfirmPwd;
}
@end

@implementation ChangePWD

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
	// Do any additional setup after loading the view.
    txt_ConfirmPwd.delegate=self;
    txt_NewPwd.delegate=self;
    txt_OldPwd.delegate=self;
    
    str_CurrentPwd=txt_OldPwd.text;
    str_NewPwd=txt_NewPwd.text;
    str_ConfirmPwd=txt_ConfirmPwd.text;
    //Password Updated
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];
    s = [s invertedSet];
    
    NSRange r = [str_ConfirmPwd rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
    }
    
    NSRange rs = [str_NewPwd rangeOfCharacterFromSet:s];
    if (rs.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
    }

    
}
-(BOOL)validateSpacilalChars
{
    if ([txt_ConfirmPwd.text isEqualToString:@""] || [txt_NewPwd.text isEqualToString:@""] ||[txt_OldPwd.text isEqualToString:@""])
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"Please Fill All fields"];
        return YES;
    }
    if ([txt_OldPwd.text isEqualToString:txt_NewPwd.text]||[txt_OldPwd.text isEqualToString:txt_ConfirmPwd.text])
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"old password and new password did not same"];
        return YES;
    }
    if ([txt_NewPwd.text length]<8 || [txt_ConfirmPwd.text length]<8)
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"password must contains 8 characters"];
        return YES;
    }
    if ([txt_NewPwd.text length]>20 || [txt_ConfirmPwd.text length]>20)
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"password to long"];
        return YES;
    }
    if (![txt_NewPwd.text isEqual:txt_ConfirmPwd.text])
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"New password,Confirm password not same"];
        return YES;

    }
    
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];
    s = [s invertedSet];
    
    NSRange r = [str_ConfirmPwd rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
    }
    
    NSRange rs = [str_NewPwd rangeOfCharacterFromSet:s];
    if (rs.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
    }

    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField isEqual:txt_OldPwd])
    {
        [txt_NewPwd becomeFirstResponder];
        
    }
    if([textField isEqual:txt_NewPwd])
    {
        [txt_ConfirmPwd becomeFirstResponder];
    }
    if([textField isEqual:txt_ConfirmPwd])
    {
        [txt_ConfirmPwd resignFirstResponder];
    }
    return YES;
}
- (IBAction)actionGo:(id)sender
{
    
    if ([txt_OldPwd.text isEqualToString:@""])
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"Enter Old password"];
        return ;
    }

    if ([txt_ConfirmPwd.text isEqualToString:@""])
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"Enter confirm password"];
        return ;
    }
    if ([txt_NewPwd.text isEqualToString:@""])
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"Enter New password"];
        return ;
    }
    
    if ([txt_OldPwd.text isEqualToString:txt_NewPwd.text]||[txt_OldPwd.text isEqualToString:txt_ConfirmPwd.text])
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"Temp password and New password should be different"];
        return ;
    }
    
    if ([txt_NewPwd.text length]<8 || [txt_ConfirmPwd.text length]<8)
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"password must contains 8 characters"];
        return ;
    }
    if ([txt_NewPwd.text length]>20 || [txt_ConfirmPwd.text length]>20)
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"password to long"];
        return ;
    }
    if (![txt_NewPwd.text isEqual:txt_ConfirmPwd.text])
    {
        [[AppDelegate sharedInstance]showAlertMessage:@"New password and Confirm password should be same"];
        return ;
        
    }

    else
    {
    dispatch_queue_t myQueue = dispatch_queue_create("DrList", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
        
    dispatch_async(myQueue, ^{
        object_PVS=[[LoginViews alloc]init];
        
        NSDictionary * dicit=[object_PVS getDectionaryFromChagePwd:[AppDelegate sharedInstance].User_id  currentpassword:txt_OldPwd.text newPassWord:txt_NewPwd.text confirmPassword:txt_ConfirmPwd.text];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicit)
            {

                ChangePWDModel * obj_Pwd=[[ChangePWDModel alloc]initWithDetailsOfChangePWD:dicit];
                
                NSLog(@"obj_Pwd is %@",obj_Pwd.mesg);
                if ([obj_Pwd.mesg isEqualToString:@"Password Updated"])
                {

                
                    NSMutableDictionary *dict_SaveDate=[[NSUserDefaults standardUserDefaults]valueForKey:@"Keep Me Logged In"];
;

                    [dict_SaveDate setObject:txt_NewPwd.text forKey:@"Password"];
                    
                    [[NSUserDefaults standardUserDefaults]setObject:dict_SaveDate forKey:@"Keep Me Logged In"];
                    
                    //[[NSUserDefaults standardUserDefaults]synchronize];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                    message:@"Password Updated Successfuly"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                else if([obj_Pwd.mesg isEqualToString:@"Current password is invalid."])
                {
                     [[AppDelegate sharedInstance]showAlertMessage:@"Please ckeck Current password Once"];
                }
                else if ([obj_Pwd.mesg isEqualToString:@"User is invalid, please contact a system administrator."])
                {
                    [[AppDelegate sharedInstance]showAlertMessage:@"User is invalid, please contact a system administrator"];
                }
                
            }
        });
    });
}  //end else
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   
    [self animateTextField:textField up:YES];
    
}
#pragma mark -
#pragma mark Move_View_Up
-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    int movementDistance =0;
    float movementDuration=0;
    if ([textField isEqual:txt_OldPwd])
    {
        movementDistance = -65;      // tweak as needed
        movementDuration = 0.3f;     // tweak as needed
    }
    else if([textField isEqual:txt_NewPwd])
    {
        movementDistance = -95;      // tweak as needed
        movementDuration = 0.3f;     // tweak as needed
    }
    else if ([textField isEqual:txt_ConfirmPwd])
    {
        movementDistance = -124;      // tweak as needed
        movementDuration = 0.3f;     // tweak as needed
    }
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];

    
}


-(void)resetAnimatView
{
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    } completion:nil];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
//    UIStoryboardSegue * segue;
//    
//           UIViewController *object_DCV = segue.destinationViewController;
//        
//        ((DoctorViewController*)object_DCV).str_username=[_StrtitleName copy];
    
    
         [self performSegueWithIdentifier:@"doctors" sender:nil];
   
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *object_DCV = segue.destinationViewController;

     //LoginModel *objct_LMN=[LoginModel new];
     ((DoctorViewController*)object_DCV).str_username=[_StrtitleName copy];
    // [AppDelegate sharedInstance].rep_patientID =objct_LM.access_id;
     //[AppDelegate sharedInstance].User_id=objct_LMN.ID;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
