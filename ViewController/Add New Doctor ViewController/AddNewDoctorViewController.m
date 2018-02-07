//
//  AddNewDoctorViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 5/28/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "AddNewDoctorViewController.h"
#import "AddDoctorModel.h"
#import "AddDoctorView.h"
#import "AppDelegate.h"
#import "PopoverViewController.h"

#define ACCEPTABLE_CHARECTERS @"0123456789"

@interface AddNewDoctorViewController ()<UITextViewDelegate>

{
    BOOL checkboxSelected;
    NSString *str_DoctorState , *str_facilityState;
    NSString *str_date, *str_facilityId;
    NSString *str_modemState ,*str_MDAccess;
    NSDateFormatter *FormatDate;
     NSMutableArray *arr_referrals;
    
     UITableViewController *tableViewController;
    UIPopoverController *popover;
    UIPopoverController *popover_detaiList;
    UIDatePicker* datePicker;
    UIViewController* pickerController;
    UITextField *temp_textField;
    UITextView *temp_textView;
    NSDictionary *dict_states;
    NSArray *arr_states, *arr_dropdownlist;
  
    AddDoctorView *object_ADV;
}
@property(nonatomic,weak)UISwitch * switch_temp;
@end

@implementation AddNewDoctorViewController

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
   
    [self arrayAndStringInialization];
    [self setupTextViewBorder];
    
    dict_states = @{@"AL":@"Alabama", @"AK" : @"Alaska",@"AZ" : @"Arizona",@"AR" : @"Arkansas",@"CA" : @"California",@"CO" : @"Colorado",@"CT" : @"Connecticut",@"DE" : @"Delaware",
                    @"DC" : @"Washington DC",@"FL" : @"Florida",@"GA" : @"Georgia",@"HI" : @"Hawaii",@"ID" : @"Idaho",@"IL" : @"Illinois",@"IN" : @"Indiana",@"IA" : @"Iowa",@"KS" : @"Kansas",@"KY" : @"Kentucky",
                    @"LA" : @"Louisiana",@"ME" : @"Maine",@"MD" : @"Maryland",@"MA" : @"Massachusetts",@"MI" : @"Michigan",@"MN" : @"Minnesota",@"MS" : @"Mississippi",@"MO" : @"Missouri",@"MT" : @"Montana",
                    @"NE" : @"Nebraska",@"NV" : @"Nevada",@"NH" : @"New Hampshire",@"NJ" : @"New Jersey",@"NM" : @"New Mexico",@"NY" : @"New York",@"NC" : @"North Carolina",@"ND" : @"North Dakota",@"OH" : @"Ohio",
                    @"OK" : @"Oklahoma",@"OR" : @"Oregon",@"PA" : @"Pennsylvania",@"RI" : @"Rhode Island",@"SC" : @"South Carolina",@"SD" : @"South Dakota",@"TN" : @"Tennessee",@"TX" : @"Texas",@"UT" : @"Utah",@"VT" : @"Vermont",
                    @"VA" : @"Virginia",@"WA" : @"Washington",@"WV" : @"West Virginia",@"WI" : @"Wisconsin",@"WY" : @"Wyoming"};
    
    arr_states = [[dict_states allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        return [str1 compare:str2];
    }];

    NSDate *currDate = [NSDate date];
    FormatDate = [[NSDateFormatter alloc]init];
    [FormatDate setDateFormat:@"MM/dd/YYYY"];
    NSString *dateString = [FormatDate stringFromDate:currDate];
    lbl_date.text=dateString;
    checkboxSelected=YES;
    str_facilityId =@"";

    scroll_Form.frame = CGRectMake(20, 90, 855, 500);
    [scroll_Form setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:scroll_Form];
    [self setRadioBtnImgz];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake (-180, 10, 650, 600)];
    [datePicker addTarget:self action:@selector(dateGetChanged) forControlEvents:UIControlEventValueChanged];
    //[datePicker sizeToFit];
    datePicker.datePickerMode=UIDatePickerModeDate;
    pickerController=[UIViewController new];
    pickerController.view.frame=CGRectMake(300, 200, 300, 530);
    UIView *vw=[UIView new];
    [vw setBackgroundColor:[UIColor redColor]];
    vw.frame=CGRectMake(380, 200, 300, 530);
    //    [vw addSubview:pickerController.view];
    pickerController.view=datePicker;
    [vw addSubview:datePicker];
    pickerController.view = vw;
    pickerController.preferredContentSize = CGSizeMake(300,200);
    popover = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    [self showPopover];
    [self addPopoverForPickerView];
    
	// Do any additional setup after loading the view.
}
-(void)viewDidLayoutSubviews
{
    scroll_Form.contentSize = CGSizeMake(CGRectGetWidth(view_form.frame), CGRectGetHeight(view_form.frame)-150);
    scroll_Form.minimumZoomScale = 0.5;
    scroll_Form.maximumZoomScale = 3;
    scroll_Form.layer.borderWidth=0.8;
    scroll_Form.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}
-(void)arrayAndStringInialization
{
    arr_referrals = [NSMutableArray array];
    arr_machine = [NSMutableArray array];
    arr_mask= [NSMutableArray array];
    arr_referrals_D= [NSMutableArray array];
    arr_machine_D= [NSMutableArray array];
    arr_mask_D= [NSMutableArray array];
    str_modemState = @"";
    str_MDAccess= @"";
    str_14= @"0";
    str_25= @"0";
    str_30= @"0";
    str_45= @"0";
    str_60= @"0";
    str_90= @"0";
    str_120= @"0";
    str_Modem_D= @"";
    str_MDAccess_D= @"";
    str_14_D= @"0";
    str_25_D= @"0";
    str_30_D= @"0";
    str_45_D= @"0";
    str_60_D= @"0";
    str_90_D= @"0";
    str_120_D= @"0";
    str_date = @"";
    str_DoctorState = @"";
    str_facilityState = @"";
    
}
-(void)setupTextViewBorder
{
    txt_Nuance_Doc.layer.borderWidth = 1.0;
    txt_Nuance_Doc.layer.borderColor = [[UIColor blackColor] CGColor];
    
    txt_Nuance_Fac.layer.borderWidth = 1.0;
    txt_Nuance_Fac.layer.borderColor = [[UIColor blackColor] CGColor];
    
    txt_addNotes_Doc.layer.borderWidth = 1.0;
    txt_addNotes_Doc.layer.borderColor = [[UIColor blackColor] CGColor];
    
    txt_addNotes_Fac.layer.borderWidth = 1.0;
    txt_addNotes_Fac.layer.borderColor = [[UIColor blackColor] CGColor];
    
    txt_OtherInstructions_U.layer.borderWidth = 1.0;
    txt_OtherInstructions_U.layer.borderColor = [[UIColor blackColor] CGColor];
    
    txt_OtherInstructions_D.layer.borderWidth = 1.0;
    txt_OtherInstructions_D.layer.borderColor = [[UIColor blackColor] CGColor];
    
    
}
- (void)dateGetChanged
{
    
    //format date
   FormatDate = [[NSDateFormatter alloc] init];
    [FormatDate setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    
    //set date format
    [FormatDate setDateFormat:@"MM/dd/YYYY"];
   
    //update date textfield
    str_date= [FormatDate stringFromDate:[datePicker date]];
    
    lbl_date.text = str_date;
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:txt_Phone]||[textField isEqual:txt_ConfFax]||[textField isEqual:txt_faciltyPhone]||[textField isEqual:txt_facilityFax])
       
    {
        BOOL returnValue;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        returnValue =  [string isEqualToString:filtered];
        
        if(textField.text.length<10 && ![string isEqualToString:@""])
                return returnValue;
        else if([string isEqualToString:@""])
        {
            return  TRUE;
        }
        else
        {
            return NO;
        }
        
    }
    else if ([textField isEqual:txt_Zip_Doc]||[textField isEqual:txt_Zip_Facility])
    {
        BOOL returnValue;
                    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
            
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            
            returnValue = [string isEqualToString:filtered];
        if(textField.text.length<14 && ![string isEqualToString:@""])
            return returnValue;
        else if([string isEqualToString:@""])
        {
            return  TRUE;
        }
        else
        {
            return NO;
        }
        
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   temp_textField = textField;
   
    if ([textField isEqual:txt_NPI]) {
        [self animateScrollFormWithOriginY:100];
    }
    else if ([textField isEqual:txt_licence])
    {
        [self animateScrollFormWithOriginY:148];
    }
    else if ([textField isEqual:txt_firstName])
    {
        [self animateScrollFormWithOriginY:253];
    }
    else if ([textField isEqual:txt_MiddleName])
    {
        [self animateScrollFormWithOriginY:297];
    }
    else if ([textField isEqual:txt_lastName])
    {
        [self animateScrollFormWithOriginY:348];
    }
    else if ([textField isEqual:txt_Phone])
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [self animateScrollFormWithOriginY:397];
    }
    else if ([textField isEqual:txt_ConfFax])
    {
         textField.keyboardType = UIKeyboardTypeNumberPad;
        [self animateScrollFormWithOriginY:454];
    }
    else if ([textField isEqual:txt_DocContact])
    {
        [self animateScrollFormWithOriginY:508];
    }
    else if ([textField isEqual:txt_address_Doctor])
    {
        textField.returnKeyType = UIReturnKeyNext;
        [self animateScrollFormWithOriginY:561];
    }
    else if ([textField isEqual:txt_city_Doc]||[textField isEqual:txt_Zip_Doc])
    {
        [self animateScrollFormWithOriginY:615];
    }
    else if ([textField isEqual:txt_UPIN])
    {
      
        [self animateScrollFormWithOriginY:202];
    }
    else if ([textField isEqual:txt_Other_Referral_U])
    {
        
        [self animateScrollFormWithOriginY:1037];
    }
    else if ([textField isEqual:txt_Other_Machine_U])
    {
       
        [self animateScrollFormWithOriginY:1171];
    }
    else if ([textField isEqual:txt_Other_Mask_U])
    {
       
        [self animateScrollFormWithOriginY:1294];
    }
    
    else if ([textField isEqual:txt_faciltyName]||[textField isEqual:txt_faciltyNickName])
    {
        [self animateScrollFormWithOriginY:1723];
    }
    else if ([textField isEqual:txt_faciltyPhone])
    {
//        if (! [self ComparingAlphabet]) {
//            [[AppDelegate sharedInstance]showAlertMessage:@"Please enter your Facility Name & Facility Nick Name with the same alphabet"];
//            txt_faciltyName.text=@"";
//            txt_faciltyNickName.text=@"";
//        }

         textField.keyboardType = UIKeyboardTypeNumberPad;
        [self animateScrollFormWithOriginY:1771];
    }
    else if ([textField isEqual:txt_faciltyContact])
    {
        [self animateScrollFormWithOriginY:1821];
    }
    else if ([textField isEqual:txt_address_Facility])
    {
        [self animateScrollFormWithOriginY:1872];
    }
    else if ([textField isEqual:txt_city_Facility] || [textField isEqual:txt_Zip_Facility])
    {
        [self animateScrollFormWithOriginY:1931];
    }
    else if ([textField isEqual:txt_Other_Referral_D])
    {
        [self animateScrollFormWithOriginY:2425];
    }
    else if ([textField isEqual:txt_Other_Machine_D])
    {
        [self animateScrollFormWithOriginY:2546];
    }
    else if ([textField isEqual:txt_Other_Mask_D])
    {
        [self animateScrollFormWithOriginY:2687];
    }
}
//-(BOOL)ComparingAlphabet
//{
//    NSString *firstLetter = [txt_faciltyName.text substringToIndex:1];
//    NSString *NickName = [txt_faciltyNickName.text substringToIndex:1];
//    if ([firstLetter isEqualToString:NickName]) {
//        return YES;
//    }
//    else return NO;
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if([textField isEqual:txt_NPI])
    {
        [txt_licence becomeFirstResponder];
    }
    else if ([textField isEqual:txt_licence])
    {
        [txt_UPIN becomeFirstResponder];
    }
    else if ([textField isEqual:txt_UPIN])
    {
        [txt_firstName becomeFirstResponder];
    }
    else if ([textField isEqual:txt_firstName])
    {
        [txt_MiddleName becomeFirstResponder];
    }
    else if ([textField isEqual:txt_MiddleName])
    {
        [txt_lastName becomeFirstResponder];
    }
    else if ([textField isEqual:txt_lastName])
    {
        [txt_Phone becomeFirstResponder];
    }
    else if ([textField isEqual:txt_Phone])
    {
        [txt_ConfFax becomeFirstResponder];
    }
    else if ([textField isEqual:txt_ConfFax])
    {
        [txt_DocContact becomeFirstResponder];
    }
    else if ([textField isEqual:txt_DocContact])
    {
        [txt_address_Doctor becomeFirstResponder];
    }
    else if ([textField isEqual:txt_address_Doctor])
    {
        [txt_city_Doc becomeFirstResponder];
    }
    
    else if ([textField isEqual:txt_city_Doc])
    {
        [txt_Zip_Doc becomeFirstResponder];
    }
    else if ([textField isEqual:txt_faciltyName])
    {
        [txt_faciltyNickName becomeFirstResponder];
    }
    else if ([textField isEqual:txt_faciltyNickName])
    {
        [txt_faciltyPhone becomeFirstResponder];
    }
    else if ([textField isEqual:txt_faciltyPhone])
    {
        [txt_faciltyContact becomeFirstResponder];
    }
    else if ([textField isEqual:txt_faciltyContact])
    {
        [txt_address_Facility becomeFirstResponder];
    }
    else if ([textField isEqual:txt_address_Facility])
    {
        [txt_city_Facility becomeFirstResponder];
    }
    else if ([textField isEqual:txt_city_Facility])
    {
        [txt_Zip_Facility becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
   }
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    temp_textView = textView;
    if([textView isEqual:txt_Nuance_Doc])
    {
               [self animateScrollFormWithOriginY:713];
    }
    else if([textView isEqual:txt_addNotes_Doc])
    {
        [self animateScrollFormWithOriginY:828];
    }
   else if([textView isEqual:txt_OtherInstructions_U])
    {
        [self animateScrollFormWithOriginY:1490];
    }
   else if([textView isEqual:txt_Nuance_Fac])
    {
        [self animateScrollFormWithOriginY:2068];
    }
   else if([textView isEqual:txt_addNotes_Fac])
   {
       [self animateScrollFormWithOriginY:2190];
   }
   else if([textView isEqual:txt_OtherInstructions_D])
   {
       [self animateScrollFormWithOriginY:2845];
   }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView isEqual:txt_OtherInstructions_D])
    {
        [self resetScrollFormView];
    }
}
-(void)animateScrollFormWithOriginY:(float)y
{
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [scroll_Form setContentOffset:CGPointMake(0, y) animated:NO];
        
    } completion:nil];
}

-(void)resetScrollFormView
{
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [scroll_Form setContentOffset:CGPointMake(0,2595) animated:NO];
        
    } completion:nil];
}


- (IBAction)action_SwitchCondition:(UISwitch*)sender
{
   if(sender.tag != self.switch_temp.tag) self.switch_temp.on = NO;
    self.switch_temp = sender;
    if (sender.tag==0) {
        if(sender.on)
        {
        view_DoctorInfoGrayedOut.hidden = YES;
        view_ExistingFacilityGrayedOut.hidden = NO;
        view_FacilityGrayedOut.hidden = NO;
        }
        else
        {
            view_DoctorInfoGrayedOut.hidden = NO;
            view_ExistingFacilityGrayedOut.hidden = NO;
            view_FacilityGrayedOut.hidden = NO;
  
        }
        [self animateScrollFormWithOriginY:0];
    }
    else if (sender.tag==1)
    {
        [self animateScrollFormWithOriginY:0];
        if(sender.on)
        {
        
        view_DoctorInfoGrayedOut.hidden = YES;
        view_ExistingFacilityGrayedOut.hidden = YES;
        view_FacilityGrayedOut.hidden = NO;
        }
        else {
            view_DoctorInfoGrayedOut.hidden = NO;
            view_ExistingFacilityGrayedOut.hidden = NO;
            view_FacilityGrayedOut.hidden = NO;
        }}
    else if (sender.tag==2)
    {
        [self animateScrollFormWithOriginY:1678];
        if(sender.on)
        {
        
        view_DoctorInfoGrayedOut.hidden = NO;
        view_ExistingFacilityGrayedOut.hidden = NO;
        view_FacilityGrayedOut.hidden = YES;
        }
         else
         {
             view_DoctorInfoGrayedOut.hidden = NO;
             view_ExistingFacilityGrayedOut.hidden = NO;
             view_FacilityGrayedOut.hidden = NO;
         }
    }
    else if (sender.tag==3)
    {
        [self animateScrollFormWithOriginY:0];
        if(sender.on)
        {
        
        view_DoctorInfoGrayedOut.hidden = YES;
        view_ExistingFacilityGrayedOut.hidden = NO;
        view_FacilityGrayedOut.hidden = YES;
        }
         else
         {
             view_DoctorInfoGrayedOut.hidden = NO;
             view_ExistingFacilityGrayedOut.hidden = NO;
             view_FacilityGrayedOut.hidden = NO;
         }
    }
}

-(IBAction)showPop:(UIButton *)sender
{
    StoreTag = sender.tag;
    [temp_textField resignFirstResponder];
    [temp_textView resignFirstResponder];
    tableViewController.tableView.contentOffset=CGPointMake(0, 0);
 
    if (sender.tag==2)
   {
       [self animateScrollFormWithOriginY:663];
        arr_dropdownlist = arr_states;
      [popover_detaiList setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
   }
    else if (sender.tag == 4)
    {
        [self animateScrollFormWithOriginY:2002];
        arr_dropdownlist = arr_states;
        [popover_detaiList setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    }
    else
    {
        arr_dropdownlist = [[AppDelegate sharedInstance] arr_facilities];
         [popover_detaiList setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    }

    [popover_detaiList presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    [tableViewController.tableView reloadData];
    
 }
- (void)createPopOver:(int)yAxis xAxis:(int)xAxis
{
    popover = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popover.popoverContentSize=CGSizeMake(300, 220);
    [popover presentPopoverFromRect:CGRectMake(xAxis,yAxis, 2, 2) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    popover.delegate=self;
}

-(void)showPopover
{
    UIViewController *controller_popover = [[UIViewController alloc]init];
    tableViewController=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller_popover.preferredContentSize = CGSizeMake(300,200);
    tableViewController.clearsSelectionOnViewWillAppear = NO;
    tableViewController.tableView.tag=123;
    tableViewController.tableView.delegate=self;
    tableViewController.tableView.dataSource=self;
    
    UIView *view_toolBar =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(controller_popover.view.bounds), 50)];
    view_toolBar.backgroundColor=[UIColor colorWithRed:179.0/255.0 green:2.0/255.0 blue:6.0/255.0 alpha:1];
    [controller_popover.view addSubview:view_toolBar];
    tableViewController.tableView.frame = CGRectMake(0, 50, CGRectGetWidth(controller_popover.view.bounds), CGRectGetHeight(controller_popover.view.bounds)-50);
    [controller_popover.view addSubview:tableViewController.tableView];
    UIButton *clearButton =[UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(20, 10, 60, 30);
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearTextfields) forControlEvents:UIControlEventTouchUpInside];
    clearButton.titleLabel.textColor = [UIColor whiteColor];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [view_toolBar addSubview:clearButton];
    popover_detaiList = [[UIPopoverController alloc] initWithContentViewController:controller_popover];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(StoreTag==2||StoreTag==4)return arr_states.count;
    return arr_dropdownlist.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"popover"];
    if(!cell) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"popover"];
    if(StoreTag==2 || StoreTag == 4)
    {
        cell.textLabel.text = dict_states[arr_states[indexPath.row]];
    }
    else
    {
        NSDictionary *dict = arr_dropdownlist[indexPath.row];
       
        cell.textLabel.text = dict[@"fac_name"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (StoreTag==2) {
        lbl_showDocState.text = dict_states[arr_states[indexPath.row]];
        str_DoctorState = arr_states[indexPath.row];
       
    }
    else if (StoreTag==4)
    {
        lbl_StateFacility.text = dict_states[arr_states[indexPath.row]];
        str_facilityState = arr_states[indexPath.row];
       
    }
    else if (StoreTag==3)
    {
        NSDictionary *dict = arr_dropdownlist[indexPath.row];
        str_facilityId =dict[@"fac_id"];
        txt_SelectFacility.text = dict[@"fac_name"];
       
    }
     [popover_detaiList dismissPopoverAnimated:FALSE];
}
-(void)clearTextfields
{
    if(StoreTag==2)
    {
    lbl_showDocState.text = @"Select State";
       
    }
   else if(StoreTag==4)
    {
        lbl_StateFacility.text = @"Select State";
       
    }
    else
    {
       txt_SelectFacility.text = @"";
        txt_SelectFacility.placeholder = @"Select a facility";
    }
     [popover_detaiList dismissPopoverAnimated:YES];
}

- (void)setRadioBtnImgz {
    
    [btn_traditional_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_HST_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_other_Referral_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_NoPreference_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Repirionics_Machine_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_ResMed_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Fischer_Machine_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_other_Machine_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_other_Machine_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_ft_pt_Comfort_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_followScipt_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Repirionics_Mask_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Fischer_Mask_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_other_Mask_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Modem_Y_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Modem_N_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_MD_Y_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_MD_N_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_14Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_30Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_60Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_90Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_OnceYear_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_HST_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_traditional_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_other_Referral_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_NoPreference_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Repirionics_Machine_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_ResMed_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Fischer_Machine_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_other_Machine_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_ft_pt_Comfort_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_followScipt_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Repirionics_Mask_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Fischer_Mask_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Fischer_Mask_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_other_Mask_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Modem_Y_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Modem_N_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_MD_Y_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_MD_N_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_14Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_30Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_60Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_90Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_OnceYear_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_25Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_45Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_25Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_45Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    
}
-(IBAction)action_HST_U:(id)sender
{
        UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_HST_U.selected) {
        [arr_referrals addObject:@"HST"];
    }
else if([arr_referrals containsObject:@"HST"])
    [arr_referrals removeObject:@"HST"];
    
}
-(IBAction)action_Traditional_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_traditional_U.selected) {
        [arr_referrals addObject:@"Traditional"];
    }
    else if([arr_referrals containsObject:@"Traditional"])
        [arr_referrals removeObject:@"Traditional"];
    
    }
-(IBAction)action_other__Referral_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_other_Referral_U.selected) {
       
        txt_Other_Referral_U.placeholder = @"Enter text....";
        txt_Other_Referral_U.userInteractionEnabled = YES;
        
    }
    else
    {
        txt_Other_Referral_U.text = @"";
        txt_Other_Referral_U.placeholder = @"";
        txt_Other_Referral_U.userInteractionEnabled = NO;
       
    }
 }
-(IBAction)action_NoPref__Machine_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_NoPreference_U.selected) {
        [arr_machine addObject:@"No Preference"];
    }
    else if([arr_machine containsObject:@"No Preference"])
        [arr_machine removeObject:@"No Preference"];

    }
-(IBAction)action_Repirionics_Machine_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_Repirionics_Machine_U.selected) {
        [arr_machine addObject:@"Respironics"];
    }
    else if([arr_machine containsObject:@"Respironics"])
        [arr_machine removeObject:@"Respironics"];

}
-(IBAction)action_ResMed_Machine_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_ResMed_U.selected) {
        [arr_machine addObject:@"ResMed"];
    }
    else if([arr_machine containsObject:@"ResMed"])
        [arr_machine removeObject:@"ResMed"];

}
-(IBAction)action_Fischer_Machine_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_Fischer_Machine_U.selected) {
        [arr_machine addObject:@"Fisher/Paykel"];
    }
    else if([arr_machine containsObject:@"Fisher/Paykel"])
        [arr_machine removeObject:@"Fisher/Paykel"];
}
-(IBAction)action_other__Machine_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_other_Machine_U.selected) {
       
        txt_Other_Machine_U.userInteractionEnabled=YES;
        txt_Other_Machine_U.placeholder = @"Enter Text....";
    }
    else if([arr_machine containsObject:@"Other"])
    {
        txt_Other_Machine_U.userInteractionEnabled=NO;
        txt_Other_Machine_U.placeholder = @"";
        txt_Other_Machine_U.text = @"";
        
    }
    }
-(IBAction)action_FtComfort_Mask_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_ft_pt_Comfort_U.selected) {
        [arr_mask addObject:@"Ft to Pt.Comfort"];
    }
    else if([arr_mask containsObject:@"Ft to Pt.Comfort"])
        [arr_mask removeObject:@"Ft to Pt.Comfort"];
 
}
-(IBAction)action_FollowScirpt_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_followScipt_U.selected) {
        [arr_mask addObject:@"Follow Script"];
    }
    else if([arr_mask containsObject:@"Follow Script"])
        [arr_mask removeObject:@"Follow Script"];

}
-(IBAction)action_Repirionics_Mask_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_Repirionics_Mask_U.selected) {
        [arr_mask addObject:@"Respironics"];
    }
    else if([arr_mask containsObject:@"Respironics"])
        [arr_mask removeObject:@"Respironics"];

}
-(IBAction)action_Fischer_Mask_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_Fischer_Mask_U.selected) {
        [arr_mask addObject:@"Fisher/Paykel"];
    }
    else if([arr_mask containsObject:@"Fisher/Paykel"])
        [arr_mask removeObject:@"Fisher/Paykel"];
}
-(IBAction)action_other__Mask_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_other_Mask_U.selected) {
        
        txt_Other_Mask_U.userInteractionEnabled = YES;
        txt_Other_Mask_U.placeholder = @"Enter Text....";
       
    }
    else
    {
        txt_Other_Mask_U.text = @"";
        txt_Other_Mask_U.userInteractionEnabled = NO;
        txt_Other_Mask_U.placeholder = @"";
        
    }
    
}
-(IBAction)action_Modem_Y_U:(id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_Modem_Y_U.selected) {
        btn_Modem_N_U.selected = NO;
        
        btn_MD_Y_U.userInteractionEnabled = YES;
        btn_MD_N_U.userInteractionEnabled =YES;
        btn_MD_Y_U.selected = NO;
        btn_MD_N_U.selected = NO;
        btn_MD_Y_U.enabled = YES;
        btn_MD_N_U.enabled = YES;
        [self ButtonState];
        str_30=@"1";
        str_90=@"1";
        str_MDAccess = @"";
        str_modemState = @"1";
    }
    else {
        
        NSLog(@"btn unselected");
        
        [self ButtonState];
    }
    
}

-(void)ButtonState
{
    if(btn_Modem_Y_U.selected)
    {
        
    [btn_30Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [btn_90Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];}
    else
    {
         [btn_30Days_U setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [btn_90Days_U setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];}
}
-(IBAction)action_Modem_N_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_Modem_N_U.selected) {
        btn_Modem_Y_U.selected = NO;
        
        btn_MD_Y_U.enabled = NO;
        btn_MD_N_U.enabled = NO;
        str_modemState = @"0";
        str_MDAccess = @"0";
        str_30=@"0";
        str_90=@"0";
        [self ButtonState];
    }
    else {
        
        NSLog(@"btn unselected");
    }
  }
-(IBAction)action_MD_Y_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_MD_Y_U.selected) {
        btn_MD_N_U.selected = NO;
        
        str_MDAccess = @"1";
    }
    else {
        
        NSLog(@"btn unselected");
    }
   }
-(IBAction)action_MD_N_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_MD_N_U.selected) {
        btn_MD_Y_U.selected = NO;
       
        str_MDAccess = @"0";
    }
    else {
        
        NSLog(@"btn unselected");
    }
 }
-(IBAction)action_14Days_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_14Days_U.selected) {
       
       str_14 = @"1";
      }
    else  str_14 = @"0";;
}

- (IBAction)action_25Days_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_25Days_U.selected) {
        
        str_25 = @"1";
    }
    else  str_25 = @"0";
}
-(IBAction)action_30Days_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_30Days_U.selected) {
                str_30 = @"1";
    }
    else str_30 = @"0";
}

- (IBAction)action_45Days_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_45Days_U.selected) {
               str_45 = @"1";
    }
    else str_45 = @"0";
}
-(IBAction)action_60Days_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_60Days_U.selected) {
                str_60 = @"1";
    }
    else str_60 = @"0";
}
-(IBAction)action_90Days_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_90Days_U.selected) {
        
            str_90 = @"1";
    }
    else  str_90 = @"0";

}
-(IBAction)action_OnceYear_U:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_OnceYear_U.selected) {
               str_120 = @"1";
    }
    else str_120 = @"0";
}
-(IBAction)action_HST_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn_HST_D.selected) {
        [arr_referrals_D addObject:@"HST"];
    }
    else if([arr_referrals_D containsObject:@"HST"])
        [arr_referrals_D removeObject:@"HST"];

}
-(IBAction)action_Traditional_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_HST_D.selected) {
        [arr_referrals_D addObject:@"Traditional"];
    }
    else if([arr_referrals_D containsObject:@"Traditional"])
        [arr_referrals_D removeObject:@"Traditional"];
}
-(IBAction)action_other__Referral_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_other_Referral_D.selected) {
        txt_Other_Referral_D.userInteractionEnabled = YES;
        txt_Other_Referral_D.placeholder = @"Enter Text....";
        
    }
    else
    {
        txt_Other_Referral_D.userInteractionEnabled = NO;
        txt_Other_Referral_D.placeholder = @"";
        txt_Other_Referral_D.text = @"";

    }
}
-(IBAction)action_NoPref__Machine_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_HST_D.selected) {
        [arr_machine_D addObject:@"No Preferences"];
    }
    else if([arr_machine_D containsObject:@"No Preferences"])
        [arr_machine_D removeObject:@"No Preferences"];
}
-(IBAction)action_Repirionics_Machine_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_Repirionics_Machine_D.selected) {
        [arr_machine_D addObject:@"Respironics"];
    }
    else if([arr_machine_D containsObject:@"Respironics"])
        [arr_machine_D removeObject:@"Respironics"];
}
-(IBAction)action_ResMed_Machine_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_ResMed_D.selected) {
        [arr_machine_D addObject:@"ResMed"];
    }
    else if([arr_machine_D containsObject:@"ResMed"])
        [arr_machine_D removeObject:@"ResMed"];
}
-(IBAction)action_Fischer_Machine_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_Fischer_Machine_D.selected) {
        [arr_machine_D addObject:@"Fisher/Paykel"];
    }
    else if([arr_machine_D containsObject:@"Fisher/Paykel"])
        [arr_machine_D removeObject:@"Fisher/Paykel"];
}
-(IBAction)action_other__Machine_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_other_Machine_D.selected) {
        txt_Other_Machine_D.userInteractionEnabled = YES;
        txt_Other_Machine_D.placeholder = @"Enter Text....";
     
    }
    else
    {
        txt_Other_Machine_D.userInteractionEnabled = NO;
        txt_Other_Machine_D.placeholder = @"";
 txt_Other_Machine_D.text = @"";
     
    }
}
-(IBAction)action_FtComfort_Mask_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_ft_pt_Comfort_D.selected) {
        [arr_mask_D addObject:@"Ft to Pt.Comfort"];
    }
    else if([arr_mask_D containsObject:@"Ft to Pt.Comfort"])
        [arr_mask_D removeObject:@"Ft to Pt.Comfort "];
}
-(IBAction)action_FollowScirpt_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_followScipt_D.selected) {
        [arr_mask_D addObject:@"FollowScript"];
    }
    else if([arr_mask_D containsObject:@"FollowScript"])
        [arr_mask_D removeObject:@"FollowScript"];
}
-(IBAction)action_Repirionics_Mask_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_Repirionics_Mask_D.selected) {
        [arr_mask_D addObject:@"Respironics"];
    }
    else if([arr_mask_D containsObject:@"Respironics"])
        [arr_mask_D removeObject:@"Respironics"];
}
-(IBAction)action_Fischer_Mask_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_Fischer_Mask_D.selected) {
        [arr_mask_D addObject:@"Fisher/Paykel"];
    }
    else if([arr_mask_D containsObject:@"Fisher/Paykel"])
        [arr_mask_D removeObject:@"Fisher/Paykel"];
}
-(IBAction)action_other__Mask_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_other_Mask_D.selected) {
        txt_Other_Mask_D.userInteractionEnabled = YES;
        txt_Other_Mask_D.placeholder = @"Enter Text....";
     
    }
    else
    {
         txt_Other_Mask_D.text = @"";
        txt_Other_Mask_D.userInteractionEnabled = NO;
        txt_Other_Mask_D.placeholder = @"";
    
    }
}
-(IBAction)action_Modem_Y_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_Modem_Y_D.selected) {
        btn_Modem_N_D.selected = NO;
        
        btn_MD_Y_D.userInteractionEnabled = YES;
        btn_MD_N_D.userInteractionEnabled = YES;
        btn_MD_Y_D.selected=NO;
        btn_MD_N_D.selected=NO;
        btn_MD_Y_D.enabled = YES;
        btn_MD_N_D.enabled = YES;
        [self CheckState];
        str_30_D=@"1";
        str_90_D=@"1";
        str_MDAccess_D = @"";
        str_Modem_D = @"1";
    }
    else {
        
        NSLog(@"btn unselected");
        
        [self CheckState];
    }
}

-(void)CheckState
{
    if(btn_Modem_Y_D.selected)
    {
        
        [btn_30Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [btn_90Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];}
    else
    {
        [btn_30Days_D setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [btn_90Days_D setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];}

}
-(IBAction)action_Modem_N_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_Modem_N_D.selected) {
        btn_Modem_Y_D.selected = NO;
        
        btn_MD_Y_D.enabled = NO;
        btn_MD_N_D.enabled = NO;
        str_Modem_D = @"0";
        str_MDAccess_D = @"";
        str_30_D=@"0";
        str_90_D=@"0";
        [self CheckState];
    }
    else {
        
        NSLog(@"btn unselected");
    }
    
    }
-(IBAction)action_MD_Y_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_MD_Y_D.selected) {
        btn_MD_N_D.selected = NO;
        
        str_MDAccess_D = @"1";
        
    }
    
}
-(IBAction)action_MD_N_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_MD_N_D.selected) {
        btn_MD_Y_D.selected = NO;
       
         str_MDAccess_D = @"0";
    }
   }
-(IBAction)action_14Days_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_14Days_D.selected) {
                str_14_D = @"1";
    }
    else str_14_D = @"0";
}

- (IBAction)action_25Days_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_25Days_D.selected) {
        
        str_25_D = @"1";
    }
    else str_25_D = @"0";
}
-(IBAction)action_30Days_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_30Days_D.selected) {
       
       str_30_D = @"1";
    }
    else str_30_D = @"0";
}

- (IBAction)action_45Days_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_45Days_D.selected) {
       
        str_45_D = @"1";
    }
    else str_45_D = @"0";
}
-(IBAction)action_60Days_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_60Days_D.selected) {
        
       str_60_D = @"1";
    }
    else str_60_D = @"0";
}

-(IBAction)action_90Days_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_90Days_D.selected) {
               str_90_D = @"1";
    }
    else str_90_D = @"0";
}
-(IBAction)action_OnceYear_D:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn_OnceYear_D.selected) {
       
        str_120_D = @"1";
    }
    else str_120_D = @"0";
}

-(IBAction)action_save:(id)sender;
{
  
    NSString *str_ReferralType =@"";
    NSString *str_machine=@"";
    NSString *str_mask=@"";
    NSString *str_referrals_D=@"";
    NSString *str_machine_D=@"";
    NSString *str_mask_D=@"";
    
    if(arr_referrals)
    {
        str_ReferralType =[arr_referrals componentsJoinedByString:@","];
    }
    if (arr_machine)
    {
        str_machine=[arr_machine componentsJoinedByString:@","];
    }
    if (arr_mask)
    {
        str_mask=[arr_mask componentsJoinedByString:@","];
    }
    
    if (arr_referrals_D)
    {
        str_referrals_D=[arr_referrals_D componentsJoinedByString:@","];
    }
    if (arr_machine_D)
    {
        str_machine_D=[arr_machine_D componentsJoinedByString:@","];
    }
    if (arr_mask_D)
    {
        str_mask_D=[arr_mask_D componentsJoinedByString:@","];
    }
   
    if(!view_DoctorInfoGrayedOut.hidden&&!view_ExistingFacilityGrayedOut.hidden&&!view_FacilityGrayedOut.hidden)
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select a referral source"];
        return;
    }
   else
   {
    
       if (_switch_temp.tag == 0)
       {
           if([self checkValidateFieldForAddNewdoctor]) return;
          
                     dispatch_queue_t addQueue = dispatch_queue_create("addNew", 0);
           dispatch_async(addQueue, ^{
               
               AddDoctorView *object_view = [AddDoctorView new];
               NSDictionary *dict = [object_view addNewDoctorWithId:[AppDelegate sharedInstance].rep_patientID FirstName:txt_firstName.text MiddleName:txt_MiddleName.text LastName:txt_lastName.text NPI:txt_NPI.text License:txt_licence.text Phone:txt_Phone.text Confax:txt_ConfFax.text DrContact:txt_DocContact.text Address:txt_address_Doctor.text City:txt_city_Doc.text State:str_DoctorState Zip:txt_Zip_Doc.text Upin:txt_UPIN.text Nuance:txt_Nuance_Doc.text Notes:txt_addNotes_Doc.text DoctorFacilityID:@"" ReferralType:str_ReferralType ReferralOtherType:txt_Other_Referral_U.text DrMachinePref:str_machine DrMachineOtherPref:txt_Other_Machine_U.text DrMaskPref:str_mask DrMaskOtherPref:txt_Other_Mask_U.text DrModem:str_modemState DrEasyModeCare:str_MDAccess Dr14:str_14 Dr25:str_25 Dr30:str_30 Dr45:str_45 Dr60:str_60 Dr90:str_90 Dr120:str_120 DrOtherIns:txt_OtherInstructions_U.text CurrentDate:str_date DrID:@""];
               [self getStateForAddingDoctorFromResponse:dict forSource:0];

           });
           [[AppDelegate sharedInstance] showCustomLoader:self];
           
       }
       else if (_switch_temp.tag == 1)
       {
           if([self checkValidationForExistingFacility]) return;
           
           dispatch_queue_t addQueue = dispatch_queue_create("addNew", 0);
           dispatch_async(addQueue, ^{
               
               AddDoctorView *object_view = [AddDoctorView new];
               NSDictionary *dict = [object_view addNewDoctorWithId:[AppDelegate sharedInstance].rep_patientID FirstName:txt_firstName.text MiddleName:txt_MiddleName.text LastName:txt_lastName.text NPI:txt_NPI.text License:txt_licence.text Phone:txt_Phone.text Confax:txt_ConfFax.text DrContact:txt_DocContact.text Address:txt_address_Doctor.text City:txt_city_Doc.text State:str_DoctorState Zip:txt_Zip_Doc.text Upin:txt_UPIN.text Nuance:txt_Nuance_Doc.text Notes:txt_addNotes_Doc.text DoctorFacilityID:str_facilityId ReferralType:str_ReferralType ReferralOtherType:txt_Other_Referral_U.text DrMachinePref:str_machine DrMachineOtherPref:txt_Other_Machine_U.text DrMaskPref:str_mask DrMaskOtherPref:txt_Other_Mask_U.text DrModem:str_modemState DrEasyModeCare:str_MDAccess Dr14:str_14 Dr25:str_25 Dr30:str_30 Dr45:str_45 Dr60:str_60 Dr90:str_90 Dr120:str_120 DrOtherIns:txt_OtherInstructions_U.text CurrentDate:lbl_date.text DrID:@""];
               [self getStateForAddingDoctorFromResponse:dict forSource:1];           });
           [[AppDelegate sharedInstance] showCustomLoader:self];
       }
       else if (_switch_temp.tag == 2)
       {
           if([self checkValidationForNewFacility]) return;
           
                     dispatch_queue_t addQueue = dispatch_queue_create("addNew", 0);
           dispatch_async(addQueue, ^{
               
               AddDoctorView *object_view = [AddDoctorView new];
            NSDictionary *dict = [object_view addNewFacilityWithId:[AppDelegate sharedInstance].rep_patientID FacNickNaem:txt_faciltyNickName.text FacName:txt_faciltyName.text FacPhone:txt_faciltyPhone.text Contact:txt_faciltyContact.text Address:txt_address_Facility.text City:txt_city_Facility.text State:str_facilityState Zip:txt_Zip_Facility.text Nuance:txt_Nuance_Fac.text Notes:txt_addNotes_Fac.text FacReferralType:str_referrals_D FacReferralOther:txt_Other_Referral_D.text FacMachineType:str_machine_D FacMachineOther:txt_Other_Machine_D.text FacMaskType:str_mask_D facMaskOther:txt_Other_Mask_D.text FacModem:str_Modem_D FacMDAccess:str_MDAccess_D Fac14:str_14_D Fac25:str_25_D Fac30:str_30_D Fac45:str_45_D Fac60:str_60_D Fac90:str_90_D Fac120:str_120_D FacOtherIns:txt_OtherInstructions_D.text FacilityId:@""FacFax:txt_facilityFax.text];
             [self getStateForAddingDoctorFromResponse:dict forSource:2];
           });
           [[AppDelegate sharedInstance] showCustomLoader:self];
       }
       else if (_switch_temp.tag == 3)
       {
           if([self checkValidationForBothNew]) return;
           
           dispatch_queue_t addQueue = dispatch_queue_create("addNew", 0);
           dispatch_async(addQueue, ^{
               
               AddDoctorView *object_view = [AddDoctorView new];
            NSDictionary *dict = [object_view addNewDoctorAndNewFacilityWithId:[AppDelegate sharedInstance].rep_patientID FirstName:txt_firstName.text MiddleName:txt_MiddleName.text LastName:txt_lastName.text NPI:txt_NPI.text License:txt_licence.text Phone:txt_Phone.text Confax:txt_ConfFax.text DrContact:txt_DocContact.text Address:txt_address_Doctor.text City:txt_city_Doc.text State:str_DoctorState Zip:txt_Zip_Doc.text Upin:txt_UPIN.text Nuance:txt_Nuance_Doc.text Notes:txt_addNotes_Doc.text ReferralType:str_ReferralType ReferralOtherType:txt_Other_Referral_U.text DrMachinePref:str_machine DrMachineOtherPref:txt_Other_Machine_U.text DrMaskPref:str_mask DrMaskOtherPref:txt_Other_Mask_U.text DrModem:str_modemState DrEasyModeCare:str_MDAccess Dr14:str_14 Dr25:str_25 Dr30:str_30 Dr45:str_45 Dr60:str_60 Dr90:str_90 Dr120:str_120 DrOtherIns:txt_OtherInstructions_U.text CurrentDate:lbl_date.text FacNickName:txt_faciltyNickName.text FacName:txt_faciltyName.text FacPhone:txt_faciltyPhone.text Contact:txt_faciltyContact.text Address:txt_address_Facility.text City:txt_city_Facility.text State:str_facilityState Zip:txt_Zip_Facility.text Nuance:txt_Nuance_Fac.text Notes:txt_addNotes_Fac.text FacReferralType:str_referrals_D FacReferralOther:txt_Other_Referral_D.text FacMachineType:str_machine_D FacMachineOther:txt_Other_Machine_D.text FacMaskType:str_mask_D facMaskOther:txt_Other_Mask_D.text FacModem:str_Modem_D FacMDAccess:str_MDAccess_D Fac14:str_14_D Fac25:str_25_D Fac30:str_30_D Fac45:str_45_D Fac60:str_60_D Fac90:str_90_D Fac120:str_120_D FacOtherIns:txt_OtherInstructions_D.text DrId:@"" FacilityId:@""];
             [self getStateForAddingDoctorFromResponse:dict forSource:3];
           });
           [[AppDelegate sharedInstance] showCustomLoader:self];
       }
                     
   }
    
}
-(BOOL)checkValidateFieldForAddNewdoctor
{
    if([txt_firstName.text isEqualToString:@""])
    {
        [txt_firstName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's first name"];
        return YES;
    }
    else if([txt_lastName.text isEqualToString:@""])
    {
        [txt_lastName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's last name"];
        return YES;
    }
    else if([txt_Phone.text isEqualToString:@""])
    {
        [txt_Phone becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's phone number"];
        return YES;
    }
    else if([txt_ConfFax.text isEqualToString:@""])
    {
        [txt_ConfFax becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's fax number"];
        return YES;
    }
    else if([txt_DocContact.text isEqualToString:@""])
    {
        [txt_DocContact becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's contact info"];
        return YES;
    }
    else if([txt_address_Doctor.text isEqualToString:@""])
    {
        [txt_address_Doctor becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's address info"];
        return YES;
    }
    else if([txt_city_Doc.text isEqualToString:@""])
    {
        [txt_city_Doc becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's city info"];
        return YES;
    }
    else if([txt_Zip_Doc.text isEqualToString:@""])
    {
        [txt_Zip_Doc becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's city zip code"];
        return YES;
    }
    else if([str_DoctorState isEqualToString:@""])
    {
       [self animateScrollFormWithOriginY:594];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select doctor's state"];
        return YES;
    }
//    else if([txt_UPIN.text isEqualToString:@""])
//    {
//        [txt_UPIN becomeFirstResponder];
//        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's UPIN"];
//        return YES;
//    }
   else if ([str_modemState isEqualToString:@""])
   {
       [[AppDelegate sharedInstance] showAlertMessage:@"Please select Yes or No for Modem"];
       return YES;
   }
   else if ([str_modemState isEqualToString:@"1"] && [str_MDAccess isEqualToString:@""])
   {
       [[AppDelegate sharedInstance] showAlertMessage:@"Please specify whether MD wants access to Encore/EasyCare"];
       return YES;
   }
    else if ([str_14 isEqualToString:@"0"]&& [str_25 isEqualToString:@"0"]&& [str_30 isEqualToString:@"0"]&& [str_45 isEqualToString:@"0"] && [str_60 isEqualToString:@"0"]&& [str_90 isEqualToString:@"0"]&& [str_120 isEqualToString:@"0"])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select download days for new doctor"];
        return YES;
    }
    return NO;
}
-(BOOL)checkValidationForExistingFacility
{
    if([str_facilityId isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select a facility"];
        return YES;
    }
   else if([txt_firstName.text isEqualToString:@""])
    {
         [txt_firstName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's first name"];
        return YES;
    }
    else if([txt_lastName.text isEqualToString:@""])
    {
         [txt_lastName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's last name"];
        return YES;
    }
    else if([txt_Phone.text isEqualToString:@""])
    {
         [txt_Phone becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's phone number"];
        return YES;
    }
    else if([txt_ConfFax.text isEqualToString:@""])
    {
         [txt_ConfFax becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's fax number"];
        return YES;
    }
    else if([txt_DocContact.text isEqualToString:@""])
    {
         [txt_DocContact becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's contact info"];
        return YES;
    }
    else if([txt_address_Doctor.text isEqualToString:@""])
    {
         [txt_address_Doctor becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's address info"];
        return YES;
    }
    else if([txt_city_Doc.text isEqualToString:@""])
    {
         [txt_city_Doc becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's city info"];
        return YES;
    }
    else if([txt_Zip_Doc.text isEqualToString:@""])
    {
         [txt_Zip_Doc becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's city zip code"];
        return YES;
    }
    else if([str_DoctorState isEqualToString:@""])
    {
        [self animateScrollFormWithOriginY:594];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select doctor's state"];
        return YES;
    }
//    else if([txt_UPIN.text isEqualToString:@""])
//    {
//         [txt_UPIN becomeFirstResponder];
//        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's UPIN"];
//        return YES;
//    }
    else if ([str_modemState isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select Yes or No for Modem"];
        return YES;
    }
    else if ([str_modemState isEqualToString:@"1"] && [str_MDAccess isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please specify whether MD wants access to Encore/EasyCare"];
        return YES;
    }
    else if ([str_14 isEqualToString:@"0"]&& [str_25 isEqualToString:@"0"]&& [str_30 isEqualToString:@"0"]&& [str_45 isEqualToString:@"0"] && [str_60 isEqualToString:@"0"]&& [str_90 isEqualToString:@"0"]&& [str_120 isEqualToString:@"0"])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select download days for new doctor"];
        return YES;
    }

    return NO;
}
-(BOOL)checkValidationForNewFacility
{
    if([txt_faciltyName.text isEqualToString:@""])
    {
        [txt_faciltyName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give a facility name"];
        return YES;
    }
    else if([txt_faciltyNickName.text isEqualToString:@""])
    {
        [txt_faciltyNickName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give a facility nick name"];
        return YES;
    }
    else if ([str_Modem_D isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select Yes or No for Modem"];
        return YES;
    }
    else if ([str_Modem_D isEqualToString:@"1"] && [str_MDAccess_D isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please specify whether MD wants access to Encore/EasyCare"];
        return YES;
    }
    else if ([str_14_D isEqualToString:@"0"]&& [str_25_D isEqualToString:@"0"]&& [str_30_D isEqualToString:@"0"]&& [str_45_D isEqualToString:@"0"] && [str_60_D isEqualToString:@"0"]&& [str_90_D isEqualToString:@"0"]&& [str_120_D isEqualToString:@"0"])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select download days for new facility"];
        return YES;
    }

    return NO;
}
-(BOOL)checkValidationForBothNew
{
    if([txt_firstName.text isEqualToString:@""])
    {
        [txt_firstName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's first name"];
        return YES;
    }
    else if([txt_lastName.text isEqualToString:@""])
    {
        [txt_lastName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's last name"];
        return YES;
    }
    else if([txt_Phone.text isEqualToString:@""])
    {
        [txt_Phone becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's phone number"];
        return YES;
    }
    else if([txt_ConfFax.text isEqualToString:@""])
    {
        [txt_ConfFax becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's fax number"];
        return YES;
    }
    else if([txt_DocContact.text isEqualToString:@""])
    {
        [txt_DocContact becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's contact info"];
        return YES;
    }
    else if([txt_address_Doctor.text isEqualToString:@""])
    {
        [txt_address_Doctor becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's address info"];
        return YES;
    }
    else if([txt_city_Doc.text isEqualToString:@""])
    {
        [txt_city_Doc becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's city info"];
        return YES;
    }
    else if([txt_Zip_Doc.text isEqualToString:@""])
    {
        [txt_Zip_Doc becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's city zip code"];
        return YES;
    }
    else if([str_DoctorState isEqualToString:@""])
    {
        [self animateScrollFormWithOriginY:594];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select doctor's state"];
        return YES;
    }
//    else if([txt_UPIN.text isEqualToString:@""])
//    {
//        [txt_UPIN becomeFirstResponder];
//        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's UPIN"];
//        return YES;
//    }
    else if ([str_modemState isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select Yes or No for Modem"];
        return YES;
    }
    else if ([str_modemState isEqualToString:@"1"] && [str_MDAccess isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please specify whether MD wants access to Encore/EasyCare"];
        return YES;
    }
    else if ([str_14 isEqualToString:@"0"]&& [str_25 isEqualToString:@"0"]&& [str_30 isEqualToString:@"0"]&& [str_45 isEqualToString:@"0"] && [str_60 isEqualToString:@"0"]&& [str_90 isEqualToString:@"0"]&& [str_120 isEqualToString:@"0"])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select download days for new doctor"];
        return YES;
    }
    if([txt_faciltyName.text isEqualToString:@""])
    {
        [txt_faciltyName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give a facility name"];
        return YES;
    }
    else if([txt_faciltyNickName.text isEqualToString:@""])
    {
        [txt_faciltyNickName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give a facility nick name"];
        return YES;
    }
    else if ([str_Modem_D isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select Yes or No for Modem"];
        return YES;
    }
    else if ([str_Modem_D isEqualToString:@"1"] && [str_MDAccess_D isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please specify whether MD wants access to Encore/EasyCare"];
        return YES;
    }
    else if ([str_14_D isEqualToString:@"0"]&& [str_25_D isEqualToString:@"0"]&& [str_30_D isEqualToString:@"0"]&& [str_45_D isEqualToString:@"0"] && [str_60_D isEqualToString:@"0"]&& [str_90_D isEqualToString:@"0"]&& [str_120_D isEqualToString:@"0"])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select download days for new facility"];
        return YES;
    }
    return NO;
}
-(void)getStateForAddingDoctorFromResponse:(NSDictionary*)dict forSource:(int)tag
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[AppDelegate sharedInstance] removeCustomLoader];
        if(dict)
        {
            AddDoctorModel *object_model;
            switch (tag) {
                case 0:
                    object_model = [AddDoctorModel addingDoctorResponseFromDictionary:dict];
                    if([object_model.msg isEqualToString:@"Doctor added successfully"])
                    {
                       [[AppDelegate sharedInstance] showSuccesMessage:@"Your request is being processed"];
                        [self clearAllFields];
                    }
                    else if([object_model.msg isEqualToString:@"Parameter missing"])
                    {
                        [[AppDelegate sharedInstance] showAlertMessage:@"Missing required Fields"];
                    }

                    break;
                case 1:
                     object_model = [AddDoctorModel addingDoctorResponseFromDictionary:dict];
                    if([object_model.msg isEqualToString:@"Doctor added successfully"])
                    {
                        [[AppDelegate sharedInstance] showSuccesMessage:@"Your request is being processed"];
                        [self clearAllFields];
                    }
                    else if([object_model.msg isEqualToString:@"Parameter missing"])
                    {
                        [[AppDelegate sharedInstance] showAlertMessage:@"Please fill first name and last name field"];
                    }

                    break;
                case 2:
                     object_model = [AddDoctorModel addingFacilityResponseFromDictionary:dict];
                    if([object_model.msg isEqualToString:@"Doctor added successfully"])
                    {
                       [[AppDelegate sharedInstance] showSuccesMessage:@"Your request is being processed"];
                        
                        [self clearAllFields];
                    }
                    else if([object_model.msg isEqualToString:@"Parameter missing"])
                    {
                        [[AppDelegate sharedInstance] showAlertMessage:@"Please fill required fields"];
                    }

                    break;
                case 3:
                     object_model = [AddDoctorModel addingDoctorAndFacilityResponseFromDictionary:dict];
                    if([object_model.msg isEqualToString:@"Doctor added successfully"])
                    {
                      [[AppDelegate sharedInstance] showSuccesMessage:@"Your request is being processed"];
                        [self clearAllFields];
                    }
                    else if([object_model.msg isEqualToString:@"Parameter missing"])
                    {
                        [[AppDelegate sharedInstance] showAlertMessage:@"Please fill first name and last name field"];
                    }

                    break;
                    
                default:
                    break;
            }
                    }
    });
    
}

-(void)addPopoverForPickerView
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [datePicker setDate:[NSDate date]];
    datePicker.backgroundColor = [UIColor clearColor];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    [datePicker addTarget:self action:@selector(dateGetChanged) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)showDatePicker:(UIButton*)sender
{
   
    CGRect frame = sender.frame;
    int y = frame.origin.y;
    int x  =frame.origin.x;

    if (sender.tag==0) {
        [self createPopOver:y+25 xAxis:x+100];
    }
    
    [self dateGetChanged];
}

-(void)clearAllFields
{
   
    lbl_showDocState.text =@"Select State";
    lbl_StateFacility.text = @"Select State";
    for (UIView *vw in [view_form subviews])
    {
        if([vw isKindOfClass:[UITextField class]])
        {
            UITextField *temp = (UITextField*)vw;
            temp.text =@"";
        }
       
        if([vw isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton*)vw;
            btn.selected = NO;
        }
        else if ([vw isKindOfClass:[UITextView class]])
        {
            UITextView *temp = (UITextView*)vw;
            temp.text=NO;
        }
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
