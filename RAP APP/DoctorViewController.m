//
//  DoctorViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//
#import "AppDelegate.h"
#import "DoctorViewController.h"
#import "ListOfDoctorsVC.h"
#import "FSVerticalTabBarController.h"
#import "PatientViewController.h"
#import "MyStateViewController.h"
#import "HistoryViewController.h"
#import "SceduleViewController.h"
#import "FSVerticalTabBarButton.h"
#import "CSCWebViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <QuartzCore/QuartzCore.h>
#import "SetUpTicketVC.h"
#import "InventoryVC.h"
#import "OrdersAndTransfersVC.h"
#import "HistoryVC.h"
#import "NSetups.h"
#import "PatientsSearch.h"

@interface DoctorViewController ()
<UIAlertViewDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

{
    NSArray* viewControllers, *arr_dropDownList;
    UIView *topBar_view;
    UIImageView *profile_imgView;
    UILabel *lbl_username;
    UITextField *txtfield_search;
    UIWebView *web_view;
    UIViewController *myViewController;
    
    UITableViewController *feedback_logout_tableview;
    
    UIPopoverController* popover_dropDown;
// For Search Disable
    
    BOOL isTextFieldDisable;
    
}
@property(nonatomic,weak)UITextField *aTextField;

@end

@implementation DoctorViewController

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
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.delegate = self;
    lbl_username =[[UILabel alloc]initWithFrame:CGRectMake(850, 24, 158, 21)];
    lbl_username.textColor = [UIColor whiteColor];
    lbl_username.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0];
   
    
    

    //Create view controllers
    
    self.view.clipsToBounds=YES;
   
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardTwo" bundle:nil];
//    NIVPatientProg *niv_test = [mainStoryboard instantiateViewControllerWithIdentifier:@"NIVPatientProg"];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"NIVStoryboardOne" bundle:nil];
    NIVSetupTicket *niv_test = [mainStoryboard instantiateViewControllerWithIdentifier:@"NIVSetupTicket"];
    
    
    SceduleViewController *object_SVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SVC"];
    PatientsSearch *object_PVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PSS"];
    HistoryVC *object_HVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HIVC"];
    SetUpTicketVC *object_STVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTVC"];
    InventoryVC *object_INVC = [self.storyboard instantiateViewControllerWithIdentifier:@"INVC"];
    OrdersAndTransfersVC *object_OATVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OATVC"];
    StockTake *object_stockVC = [self.storyboard instantiateViewControllerWithIdentifier:@"STOCK"];

    UINavigationController *nv_SVC, *nv_PVC, *nv_HVC, *nv_STVC, *nv_INVC, *nv_OATVC, *nv_stockVC;
    
    
    nv_SVC = [[UINavigationController alloc]initWithRootViewController:object_SVC];
    nv_SVC.navigationBarHidden=YES;
    
    nv_PVC = [[UINavigationController alloc]initWithRootViewController:object_PVC];
//    nv_PVC = [[UINavigationController alloc]initWithRootViewController:niv_test];
    nv_PVC.navigationBarHidden=YES;
    
    nv_HVC = [[UINavigationController alloc]initWithRootViewController:object_HVC];
    nv_HVC.navigationBarHidden=YES;
    
    nv_STVC = [[UINavigationController alloc]initWithRootViewController:object_STVC];
    nv_STVC.navigationBarHidden=YES;
    
    nv_INVC = [[UINavigationController alloc]initWithRootViewController:object_INVC];
    nv_INVC.navigationBarHidden=YES;
    
    nv_OATVC = [[UINavigationController alloc]initWithRootViewController:object_OATVC];
    nv_OATVC.navigationBarHidden=YES;
    
    nv_stockVC = [[UINavigationController alloc]initWithRootViewController:object_stockVC];
    nv_stockVC.navigationBarHidden=YES;
    
    

    if ([RT_ID isEqualToString:@""]) {
        viewControllers = @[nv_SVC];
    }
    else{
//        viewControllers = @[nv_PVC,nv_SVC,nv_STVC,nv_INVC, nv_OATVC, nv_HVC, nv_stockVC];
        viewControllers = @[nv_PVC,nv_SVC,nv_INVC, nv_OATVC, nv_HVC, nv_stockVC];

    }
    
    //set the view controllers of the the tab bar controller left_nav_bg
    [self setViewControllers:viewControllers];
    
    //self.tabBar.backgroundImage = [UIImage imageNamed:@"left_nav_sel"];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,(id)[UIColor lightGrayColor].CGColor, nil];
   
    self.tabBar.backgroundGradientColors = colors;
    
    self.selectedViewController = ((UIViewController*)[viewControllers objectAtIndex:0]);
    myViewController = [[[viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    
    topBar_view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 1024, 70)];
    //topBar_view.backgroundColor = [UIColor lightGrayColor];
    topBar_view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topBar_view];
    
    UIView *line_view = [[UIView alloc] initWithFrame:CGRectMake(0, 89, 1024, 1)];
    [line_view setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:line_view];
    //txtfield_search = [self addTextField];

    profile_imgView.image =[UIImage imageNamed:@"profileDP.png"];
    //[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[AppDelegate sharedInstance].str_profilePic]]];
    [topBar_view addSubview:profile_imgView];
    [topBar_view addSubview:txtfield_search];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(978, 20, 46, 69);
    [btn setBackgroundImage:[UIImage imageNamed:@"logout_btn"] forState:UIControlStateNormal];
    //[btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    //[btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[btn setTitle:@"Logout" forState:UIControlStateNormal];
    //btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    [btn addTarget:self action:@selector(showLogoutAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
    UILabel *lbl_welcome = [[UILabel alloc] initWithFrame:CGRectMake(590, 27, 375, 18)];
    lbl_welcome.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
    lbl_welcome.textAlignment = NSTextAlignmentRight;
    lbl_welcome.text = [NSString stringWithFormat:@"Welcome %@  ",RT_NAME];
    [topBar_view addSubview:lbl_welcome];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: lbl_welcome.attributedText];
    NSString *rt_name = [NSString stringWithFormat:@"%@", RT_NAME];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor colorWithRed:47.0/255.0 green:98.0/255.0 blue:136.0/255.0 alpha:1]
                 range:NSMakeRange(8, rt_name.length)];
    [lbl_welcome setAttributedText: text];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(600, 27,500, 18);
    [btn2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    btn2.tag=1250;
    [btn2 addTarget:self action:@selector(customMethod:) forControlEvents:UIControlEventTouchUpInside];
    //[btn2 addSubview:lbl_username];
    [topBar_view addSubview:btn2];
  
    UIButton *btn_logo = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_logo.frame =CGRectMake(15, 670, 70, 50);
    btn_logo.tag=1251;
    [btn_logo setImage:[UIImage imageNamed:@"csc_web_logo.png"] forState:UIControlStateNormal];
    [btn_logo addTarget:self action:@selector(customMethod:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:btn_logo];
    
    UIImageView *imgview_logo = [UIImageView new];
    imgview_logo.frame= CGRectMake(22, 15, 198, 51);
    imgview_logo.contentMode = UIViewContentModeScaleAspectFit;
    imgview_logo.image=[UIImage imageNamed:@"rtlogo"];
    [topBar_view addSubview:imgview_logo];
    [self.navigationController.navigationBar setHidden:YES];
    [self creatPopoverForDropDown];
    
    UIImageView *imgView;
    
    if ([RT_ID isEqualToString:@""]){
        UIImage *v = [UIImage imageNamed:@"admin_schedule"];
        imgView = [[UIImageView alloc]  initWithFrame:self.tabBar.bounds];
        imgView.image = v;
    }
    else{
        UIImage *v = [UIImage imageNamed:@"patients"]; // leftslide_rect.png
        imgView = [[UIImageView alloc]  initWithFrame:self.tabBar.bounds]; //self.bounds
        //NSLog(@"bounds: %f, %f", self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        imgView.image = v;
    }
    
    
    self.tabBar.backgroundImage = imgView.image;
}

-(void)viewWillAppear:(BOOL)animated
{
   //  lbl_username.text = [NSString stringWithFormat:@"Welcome%@",_str_username];
}

-(UITextField*)addTextField
{
    UIImageView * img_view = [[UIImageView alloc]initWithFrame:CGRectMake(115,20,460,35)];
    img_view.image = [UIImage imageNamed:@"search_bar.png"];
    [topBar_view addSubview:img_view];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(145, 20, 430, 35)];
    textField.borderStyle = UITextBorderStyleNone;
    
    _btn_Clear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn_Clear.frame = CGRectMake(390, 20, 50, 30);
    [_btn_Clear setTitle:@"C" forState:UIControlStateNormal];
    [_btn_Clear addTarget:self action:@selector(reloadListTable:) forControlEvents:UIControlEventTouchUpInside];
    //[topBar_view addSubview:_btn_Clear];

    
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"Enter First or Last Name";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeySearch;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    return textField;
   
}

- (void)reloadListTable:(UIButton *)sender {
    
    [self.searchDelagate searchBarClearButtonClicked:sender.titleLabel.text];
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField;  {
    
    [self.searchDelagate searchBarClearButtonClicked:textField.text];
    return YES;

}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if ([textField.text isEqualToString:@""]) {
//        [self.searchDelagate searchBarClearButtonClicked:string];
//    }
//    return YES;
//}
-(void)creatPopoverForDropDown
{
   
    UIViewController* tableViewController=[[UIViewController alloc] init];
    //tableViewController.view.backgroundColor = [UIColor redColor];
    tableViewController.view.frame=CGRectMake(995, 29, 15, 15);
    tableViewController.preferredContentSize = CGSizeMake(250,140); //(250,140) -> orignal value
    
    UIButton *logButton =[UIButton buttonWithType:UIButtonTypeSystem];
    logButton.frame = CGRectMake(10, 80, 230, 50);
    [logButton setTitle:@"Logout" forState:UIControlStateNormal];
    //[logButton addTarget:self action:@selector(customMethod:) forControlEvents:UIControlEventTouchUpInside];
    logButton.titleLabel.textColor = [UIColor redColor];
    logButton.titleLabel.font = [UIFont systemFontOfSize:23.0];
    
    
    UIButton *feedButton =[UIButton buttonWithType:UIButtonTypeSystem];
    feedButton.frame = CGRectMake(10, 12, 230, 50);
    [feedButton setTitle:@"Send Feedback" forState:UIControlStateNormal];
    //[feedButton addTarget:self action:@selector(customMethod:) forControlEvents:UIControlEventTouchUpInside];
    feedButton.titleLabel.textColor = [UIColor redColor];
    feedButton.titleLabel.font = [UIFont systemFontOfSize:23.0];
    
    [feedButton setBackgroundColor:[UIColor grayColor]];
    [logButton setBackgroundColor:[UIColor redColor]];
    [feedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    feedButton.layer.cornerRadius = 8;
    feedButton.clipsToBounds = YES;
    
    logButton.layer.cornerRadius = 8;
    logButton.clipsToBounds = YES;
    
//    logButton .tag = 1253;
//    feedButton .tag = 1254;
    
    [logButton addTarget:self action:@selector(logoutFromApp) forControlEvents:UIControlEventTouchUpInside];
    [feedButton addTarget:self action:@selector(sendFeedback) forControlEvents:UIControlEventTouchUpInside];
    
    [tableViewController.view addSubview:logButton];
    [tableViewController.view addSubview:feedButton];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 70, 250, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [tableViewController.view addSubview:line];
    
    //********* Adding Tableview to solve logout issue ***************//
    
    
//    feedback_logout_tableview=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
//    feedback_logout_tableview.clearsSelectionOnViewWillAppear = YES;
//    feedback_logout_tableview.tableView.scrollEnabled = NO;
//    feedback_logout_tableview.tableView.delegate=self;
//    feedback_logout_tableview.tableView.dataSource=self;
//    
//    feedback_logout_tableview.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(tableViewController.view.bounds), CGRectGetHeight(tableViewController.view.bounds));
//    [tableViewController.view addSubview:feedback_logout_tableview.tableView];

    //****************************************************************//

    
    popover_dropDown = [[UIPopoverController alloc] initWithContentViewController:tableViewController];
    
    //arr_dropDownList = @[@"Send Feedback",@"Logout"];
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellID = @"searchPatient";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    
//    if (indexPath.row == 0) cell.textLabel.text = @"Send Feedback";
//    if (indexPath.row == 1) cell.textLabel.text = @"Logout";
//    
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    if (indexPath.row == 0) [self sendFeedback];
//    if (indexPath.row == 1) [self logoutFromApp];
//}

-(void)logoutFromApp{
    
    [self showLogoutAlert];
    [popover_dropDown dismissPopoverAnimated:NO];
}

-(void)sendFeedback{
    [self ShowEmail];
    [popover_dropDown dismissPopoverAnimated:NO];
}



//-(void)addWebView
//{
//    web_view = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
//
//    
//    NSString *url=@"http://www.classicsleepcare.com";
//    NSURL *nsurl=[NSURL URLWithString:url];
//    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
//    [web_view loadRequest:nsrequest];
//    [self.view addSubview:web_view];
//    [web_view setHidden:YES];
//    UIButton *btn_close = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_close.frame =CGRectMake(917,31,67,42);
//    btn_close.tag=1252;
//    [btn_close setImage:[UIImage imageNamed:@"close_btn.png"] forState:UIControlStateNormal];
//    [btn_close addTarget:self action:@selector(customMethod:) forControlEvents:UIControlEventTouchUpInside];
//    [web_view addSubview:btn_close];
//    
//}


-(void)customMethod :(UIButton*)sender
{
    switch(sender.tag)
    {
        case 1250:{
            //[[AppDelegate sharedInstance] showAlertMessage:@"Coming Soon!!!"];
            //   [popover_dropDown presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            [popover_dropDown presentPopoverFromRect:img.frame inView:img.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
            break;
            
        case 1251:{
            CSCWebViewController *object_CSC = [self.storyboard instantiateViewControllerWithIdentifier:@"CSCWVC"];
            [self.navigationController pushViewController:object_CSC animated:NO];
        }
            break;
            
        case 1252:{
            web_view.hidden=YES;
        }
            break;
            
        case 1253:{
//            [self showLogoutAlert];
//            [popover_dropDown dismissPopoverAnimated:YES];
        }
            break;
            
        case 1254:{
//            [self ShowEmail];
//            [popover_dropDown dismissPopoverAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}
-(void)ShowEmail
{
    if (![MFMailComposeViewController canSendMail]) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Email composer is not-configured/misconfigured or not supported on this device!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
    }
    else{
        NSString * subject = @"Send Feedback";
        
        NSArray * recipients = [NSArray arrayWithObjects:@"RepAppFeedback@classicsleepcare.com", nil];
        
        MFMailComposeViewController * composer = [MFMailComposeViewController new];
        composer.view.frame = CGRectMake(0,0, 1024, 768);
        composer.mailComposeDelegate = self;
        [composer setSubject:subject];
        
        [composer setToRecipients:recipients];
        
        [self presentViewController:composer animated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate methods
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled"); break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved"); break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent"); break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]); break;
        default:
            break;
    }
    
    // close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)showLogoutAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Do you want to logout?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
    alert =nil;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *button_title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([button_title isEqualToString:@"YES"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"RT_ID"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"RT_NAME"];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(BOOL)tabBarController:(FSVerticalTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    isTextFieldDisable = NO;

    _aTextField.text = @"";
    [_aTextField resignFirstResponder];
    myViewController = viewController;

    return YES;
}

-(void)tabBarController:(FSVerticalTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    int tabitem = tabBarController.selectedIndex;
    
    switch (tabitem) {
        case 0:{
            UIImage *v = [UIImage imageNamed:@"patients"]; // leftslide_rect.png
            UIImageView *imgView = [[UIImageView alloc]  initWithFrame:self.tabBar.bounds]; //self.bounds
            //NSLog(@"bounds: %f, %f", self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            imgView.image = v;
            
            self.tabBar.backgroundImage = imgView.image;
        }
            break;
        case 1:{
            UIImage *v = [UIImage imageNamed:@"schedule"]; // leftslide_rect.png
            UIImageView *imgView = [[UIImageView alloc]  initWithFrame:self.tabBar.bounds]; //self.bounds
            //NSLog(@"bounds: %f, %f", self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            imgView.image = v;
            
            self.tabBar.backgroundImage = imgView.image;
        }
            break;
            
            /*
        case 2:{
            UIImage *v = [UIImage imageNamed:@"ticket"]; // leftslide_rect.png
            UIImageView *imgView = [[UIImageView alloc]  initWithFrame:self.tabBar.bounds]; //self.bounds
            //NSLog(@"bounds: %f, %f", self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            imgView.image = v;
            
            self.tabBar.backgroundImage = imgView.image;
        }
            break;
             */
        case 2:{
            UIImage *v = [UIImage imageNamed:@"inventory"]; // leftslide_rect.png
            UIImageView *imgView = [[UIImageView alloc]  initWithFrame:self.tabBar.bounds]; //self.bounds
            //NSLog(@"bounds: %f, %f", self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            imgView.image = v;
            
            self.tabBar.backgroundImage = imgView.image;
        }
            break;
        case 3:{
            UIImage *v = [UIImage imageNamed:@"order"]; // leftslide_rect.png
            UIImageView *imgView = [[UIImageView alloc]  initWithFrame:self.tabBar.bounds]; //self.bounds
            //NSLog(@"bounds: %f, %f", self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            imgView.image = v;
            
            self.tabBar.backgroundImage = imgView.image;
        }
            break;
        case 4:{
            UIImage *v = [UIImage imageNamed:@"history"]; // leftslide_rect.png
            UIImageView *imgView = [[UIImageView alloc]  initWithFrame:self.tabBar.bounds]; //self.bounds
            //NSLog(@"bounds: %f, %f", self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            imgView.image = v;
            
            self.tabBar.backgroundImage = imgView.image;
        }
            break;
            
        case 5:{
            UIImage *v = [UIImage imageNamed:@"stock"]; // leftslide_rect.png
            UIImageView *imgView = [[UIImageView alloc]  initWithFrame:self.tabBar.bounds]; //self.bounds
            //NSLog(@"bounds: %f, %f", self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            imgView.image = v;
            
            self.tabBar.backgroundImage = imgView.image;
        }
            break;
            
        default:
            break;
    }
    
    
    if (tabitem == 4) // That is For MyStateVC
    {
        isTextFieldDisable = YES;
    } // End // 8184420941 //
   // [[tabBarController.viewControllers objectAtIndex:tabitem] popToRootViewControllerAnimated:NO];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (isTextFieldDisable)
        [textField resignFirstResponder];
    else
        _aTextField = textField;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchDelagate searchedDataFromText:textField.text];
    
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
