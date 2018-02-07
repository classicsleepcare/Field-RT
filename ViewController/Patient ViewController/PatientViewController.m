//
//  PatientViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "PatientViewController.h"
#import "DoctorDetailCell.h"
#import "PatientList.h"
#import "PatientView.h"
#import "HistoryView.h"
#import "HistoryModel.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "SearchPatientViewController.h"
#import "SearchReferralViewController.h"

#define ACCEPTABLE_CHARECTERS @"0123456789"
@interface PatientViewController ()
{
    int selectListNumber;
  
    
    BOOL isEnterManually_Cal;
      PatientView *object_PV;
    NSArray *arr_dropdownlist;
   NSDictionary *dict_tble;
    HistoryModel *object_HM;
    
    NSArray *arr_drList,
            *arr_statusList,
            *arr_primaryList,
            *arr_drFacilityList,
            *arr_dateRange;
    NSString *str_rowIdForFacility,
             *str_rowIdForDr;
    
    UIPopoverController *popover;
    UITableViewController *tableViewController;
    UIViewController *controller_popover;
}

@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@end

@implementation PatientViewController
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
    
    arryDate                                            = [[NSMutableArray alloc] init];
    str_rowIdForDr                                      = @"";
    str_rowIdForFacility                                = @"";
    
    
	// Do any additional setup after loading the view.
    controller_popover                                  = [[UIViewController alloc]init];
    tableViewController                                 = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller_popover.preferredContentSize             = CGSizeMake(300,500);
    tableViewController.clearsSelectionOnViewWillAppear = NO;
    tableViewController.tableView.tag                   = 123;
    tableViewController.tableView.delegate              = self;
    tableViewController.tableView.dataSource            = self;
    UIView *view_toolBar                                = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(controller_popover.view.bounds), 50)];
    view_toolBar.backgroundColor                        = [UIColor colorWithRed:179.0/255.0 green:2.0/255.0 blue:6.0/255.0 alpha:1];
    [controller_popover.view addSubview:view_toolBar];
    tableViewController.tableView.frame                 = CGRectMake(0, 50, CGRectGetWidth(controller_popover.view.bounds), CGRectGetHeight(controller_popover.view.bounds)-50);
    [controller_popover.view addSubview:tableViewController.tableView];
    UIButton *clearButton                               =[UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame                                   = CGRectMake(20, 10, 60, 30);
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearTextfields) forControlEvents:UIControlEventTouchUpInside];
    clearButton.titleLabel.textColor                    = [UIColor whiteColor];
    clearButton.titleLabel.font                         = [UIFont systemFontOfSize:20.0];
    [view_toolBar addSubview:clearButton];
    
    
    popover                                             = [[UIPopoverController alloc] initWithContentViewController:controller_popover];
    arr_dateRange                                       = @[@"Month to Date",@"Year to Date",@"Quarter to Date"];
    lbl_Heading.text                                    = @"Patient Search ";
    
    // Date Picker
    
    pickerController            = [UIViewController new];
    pickerController.view.frame = CGRectMake(300, 200, 300, 530);
    
    datePicker                  = [[UIDatePicker alloc] initWithFrame:CGRectMake (-160, 10, 650, 600)];
    datePicker.datePickerMode   = UIDatePickerModeDate;
    pickerController.view       = datePicker;
    
//    UIView *vw                  = [UIView new];
//    vw.frame                    = CGRectMake(380, 200, 300, 530);
//    [vw addSubview:datePicker];
//    
//    pickerController.view       = vw;

    
    
    
    
    object_PV = [PatientView new]; // dod crash

    //txt_FirstName.text=dict [@"Pt_First"];
    dispatch_queue_t myQueue = dispatch_queue_create("DrList", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_PV getDetailListForId:RT_ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
            PatientList *object_PL = [[PatientList alloc]initDetailListWithDictionary:dict];
            [self detailListResponseObject:object_PL];
            }
        });
    });
}

-(void)detailListResponseObject:(PatientList*)object
{
    arr_drFacilityList  = object.arr_drFacility;
    arr_drList          = object.arr_drList;
    arr_primaryList     = object.arr_PrimaryList;
    arr_statusList      = object.arr_statusList;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

      //[[NSNotificationCenter defaultCenter] addObserver:self
          //                                             selector:@selector(keyboardWillShow:)
          //                                                 name:UIKeyboardWillShowNotification
          //                                               object:nil];

    
    
    if(self.navigationController.viewControllers.count>1)
    {
        btn_Back.hidden=NO;
    }
    else  btn_Back.hidden=YES;
    
    

   
   
    
}
-(void)viewDidAppear:(BOOL)animated
{
//    lbl_PatienNameWithID.text=@"";
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [self resetMainView];
}

-(void)clearTextfields
{
    switch (selectListNumber) {
        case 0:
            txt_Facility.text=@"";
           
            str_rowIdForFacility=@"";
            break;
        case 1:
            
            txt_Insurance.text=@"";
            break;
        case 2:
            txt_Doctor.text=@"";
             str_rowIdForDr=@"";
            break;
        case 3:
            txt_Ref_DateRange.text=@"";
            txt_Ref_F_Day.text=@"";
            txt_Ref_F_Month.text=@"";
            txt_Ref_F_Year.text=@"";
            txt_Ref_T_Day.text=@"";
            txt_Ref_T_Month.text=@"";
            txt_Ref_T_Year.text=@"";
            break;
        case 4:
            txt_App_DateRange.text=@"";
            txt_App_F_Day.text=@"";
            txt_App_F_Month.text=@"";
            txt_App_F_Year.text=@"";
            txt_App_T_Day.text=@"";
            txt_App_T_Month.text=@"";
            txt_App_T_Year.text=@"";
            break;
        case 5:
            txt_Den_DateRange.text=@"";
            txt_Den_F_Day.text=@"";
            txt_Den_F_Month.text=@"";
            txt_Den_F_Year.text=@"";
            txt_Den_T_Day.text=@"";
            txt_Den_T_Month.text=@"";
            txt_Den_T_Year.text=@"";
            break;
        case 6:
            txt_Set_DateRange.text=@"";
            txt_Set_F_Day.text=@"";
            txt_Set_F_Month.text=@"";
            txt_Set_F_Year.text=@"";
            txt_Set_T_Day.text=@"";
            txt_Set_T_Month.text=@"";
            txt_Set_T_Year.text=@"";
            break;
        case 7:
            txt_RefDown_DateRange.text=@"";
            txt_RefDown_F_Day.text=@"";
            txt_RefDown_F_Month.text=@"";
            txt_RefDown_F_Year.text=@"";
            txt_RefDown_T_Day.text=@"";
            txt_RefDown_T_Month.text=@"";
            txt_RefDown_T_Year.text=@"";
            break;
        case 8:
            txt_Status.text=@"";
            break;
        default:
            break;
    }
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 100:
             return arr_SearchListOfPatients.count;
            break;
         case 123:
            return arr_dropdownlist.count;
            break;
        default:
            break;
    }
    
    
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell_table;
    
    if (tableView.tag==123)
    {
        static NSString * strID = @"dropDownList";
        cell_table = [tableView dequeueReusableCellWithIdentifier:strID];
        if (!cell_table) {
            cell_table = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        }
        
        NSString *str_cellText;
        id objectInArray = arr_dropdownlist[indexPath.row];
        if ([objectInArray isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dict =objectInArray;
            str_cellText=dict[@"Dr_Name"];
            if (!str_cellText) {
                str_cellText=dict[@"fac_name"];
            }
            
        }
        else str_cellText = objectInArray;
        
        cell_table.textLabel.text =str_cellText;
        cell_table.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];

    }
    return cell_table;
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (tableView.tag==123)
    {
        NSArray *arr_currentDate = [self currentDate];
        NSArray *arr_date;
        if ([arr_dropdownlist isEqual:arr_dateRange])
        {
            
            switch (indexPath.row) {
                case 0:
                    arr_date = [self  startOfMonth];
                    break;
                case 1:
                    arr_date = [self  startOfYear];
                    break;
                case 2:
                    arr_date = [self  quarterOfYear];
                    break;
                    
                default:
                    break;
            }
        }
        @try {
            
            
            
            switch (selectListNumber) {
                case 0:
                    txt_Facility.text =arr_dropdownlist[indexPath.row][@"fac_name"];
                    str_rowIdForFacility=arr_dropdownlist[indexPath.row][@"fac_id"];
                    
                    break;
                case 1:
                    txt_Insurance.text =arr_dropdownlist[indexPath.row];
                    break;
                case 2:
                    txt_Doctor.text =arr_dropdownlist[indexPath.row][@"Dr_Name"];
                    str_rowIdForDr=arr_dropdownlist[indexPath.row][@"Dr_ID"];
                    break;
                case 3:
                    txt_Ref_DateRange.text = arr_dateRange[indexPath.row];
                    txt_Ref_F_Day.text=arr_date[1];
                    txt_Ref_F_Month.text=arr_date[0];
                    txt_Ref_F_Year.text=arr_date[2];
                    txt_Ref_T_Day.text=arr_currentDate[1];
                    txt_Ref_T_Month.text=arr_currentDate[0];
                    txt_Ref_T_Year.text=arr_currentDate[2];
                    break;
                case 4:
                    txt_App_DateRange.text = arr_dateRange[indexPath.row];
                    txt_App_F_Day.text=arr_date[1];
                    txt_App_F_Month.text=arr_date[0];
                    txt_App_F_Year.text=arr_date[2];
                    txt_App_T_Day.text=arr_currentDate[1];
                    txt_App_T_Month.text=arr_currentDate[0];
                    txt_App_T_Year.text=arr_currentDate[2];
                    break;
                case 5:
                    txt_Den_DateRange.text = arr_dateRange[indexPath.row];
                    txt_Den_F_Day.text=arr_date[1];
                    txt_Den_F_Month.text=arr_date[0];
                    txt_Den_F_Year.text=arr_date[2];
                    txt_Den_T_Day.text=arr_currentDate[1];
                    txt_Den_T_Month.text=arr_currentDate[0];
                    txt_Den_T_Year.text=arr_currentDate[2];
                    break;
                case 6:
                    txt_Set_DateRange.text = arr_dateRange[indexPath.row];
                    txt_Set_F_Day.text=arr_date[1];
                    txt_Set_F_Month.text=arr_date[0];
                    txt_Set_F_Year.text=arr_date[2];
                    txt_Set_T_Day.text=arr_currentDate[1];
                    txt_Set_T_Month.text=arr_currentDate[0];
                    txt_Set_T_Year.text=arr_currentDate[2];
                    break;
                case 7:
                    txt_RefDown_DateRange.text = arr_dateRange[indexPath.row];
                    txt_RefDown_F_Day.text=arr_date[1];
                    txt_RefDown_F_Month.text=arr_date[0];
                    txt_RefDown_F_Year.text=arr_date[2];
                    txt_RefDown_T_Day.text=arr_currentDate[1];
                    txt_RefDown_T_Month.text=arr_currentDate[0];
                    txt_RefDown_T_Year.text=arr_currentDate[2];
                    
                    break;
                case 8:
                    txt_Status.text =arr_dropdownlist[indexPath.row];
                    break;
                    
                default:
                    break;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"exception --- %@",exception);
        }
        [popover dismissPopoverAnimated:YES];
    }
    
    
}


-(NSArray*)startOfMonth
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:today];
    components.day = 1;
    
    NSDate *dayOneInCurrentMonth = [gregorian dateFromComponents:components];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd-YYYY";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"UTC+05:30"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:dayOneInCurrentMonth];
    
    return [timeStamp componentsSeparatedByString:@"-"];
}

-(NSArray*)startOfYear
{
    int yearOffset = 0;
    NSDate *date = [[NSDate alloc] init];
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents * calComponents = [cal components: NSYearCalendarUnit fromDate:date];
    
    [calComponents setYear:([calComponents year] + yearOffset)];
    NSDate *startOfYearWithOffset = [cal dateFromComponents:calComponents];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd-YYYY";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"UTC+05:30"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:startOfYearWithOffset];
    return [timeStamp componentsSeparatedByString:@"-"];
}

-(NSArray*)quarterOfYear
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM";
    NSDateFormatter *dateFormatterDate = [[NSDateFormatter alloc] init];
    dateFormatterDate.dateFormat = @"MM-dd-YYYY";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"UTC+05:30"];
    [dateFormatter setTimeZone:gmt];
    NSTimeZone *gmtDate = [NSTimeZone timeZoneWithAbbreviation:@"UTC+05:30"];
    [dateFormatterDate setTimeZone:gmtDate];
    
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    NSString *timeStampDate = [dateFormatterDate stringFromDate:[NSDate date]];
    int quarter = [timeStamp intValue];
    NSString *quartDate;
    if (quarter <=3)
    {
        NSRange range = NSMakeRange(0,5);
        quartDate = [timeStampDate stringByReplacingCharactersInRange:range withString:@"01-01"];
    }
    
    if (quarter >3 && quarter<=6)
    {
        NSRange range = NSMakeRange(0,5);
        quartDate  = [timeStampDate stringByReplacingCharactersInRange:range withString:@"04-01"];
    }
    
    if (quarter >6 && quarter<=9)
    {
        NSRange range = NSMakeRange(0,5);
        quartDate = [timeStampDate stringByReplacingCharactersInRange:range withString:@"07-01"];
    }
    
    if (quarter >9 && quarter<=12)
    {
        NSRange range = NSMakeRange(0,5);
        quartDate = [timeStampDate stringByReplacingCharactersInRange:range withString:@"10-01"];
    }
    return  [quartDate componentsSeparatedByString:@"-"];
}
-(NSArray*)currentDate
{
    NSDate *date_current =[NSDate date];
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd-YYYY";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"UTC+05:30"];
    [dateFormatter setTimeZone:gmt];
    NSString *currentDate =[dateFormatter stringFromDate:date_current];
    return [currentDate componentsSeparatedByString:@"-"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 34;
}



-(IBAction)action_Search:(id)sender
{
    if([txt_FirstName.text isEqualToString:@""]&&[txt_LastName.text isEqualToString:@""] && [txt_Status.text isEqualToString:@""]&& [txt_Facility.text isEqualToString:@""]&& [txt_Insurance.text isEqualToString:@""]&& [txt_Doctor.text isEqualToString:@""]&& [txt_Ref_F_Month.text isEqualToString:@""]&& [txt_Ref_T_Month.text isEqualToString:@""]&& [txt_Ref_DateRange.text isEqualToString:@""]&& [txt_App_F_Month.text isEqualToString:@""]&& [txt_App_T_Month.text isEqualToString:@""]&& [txt_App_DateRange.text isEqualToString:@""]&& [txt_Den_F_Month.text isEqualToString:@""]&& [txt_Den_T_Month.text isEqualToString:@""]&& [txt_Den_DateRange.text isEqualToString:@""]&& [txt_Status.text isEqualToString:@""]&& [txt_Status.text isEqualToString:@""]&& [txt_Set_F_Month.text isEqualToString:@""]&& [txt_Set_T_Month.text isEqualToString:@""]&& [txt_Set_DateRange.text isEqualToString:@""]&& [txt_RefDown_F_Month.text isEqualToString:@""]&& [txt_RefDown_T_Month.text isEqualToString:@""]&& [txt_RefDown_DateRange.text isEqualToString:@""])
    {
        [[AppDelegate sharedInstance ] showAlertMessage:@"Please input at least one field!"];
        return;
        
    }
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    
  
    dispatch_queue_t myQueue = dispatch_queue_create("Arun", 0);
    
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict = [object_PV getPatientListForId:RT_ID
                                                  FirstName:txt_FirstName.text
                                                   LastName:txt_LastName.text
                                                     Stauts:txt_Status.text
                                                    Facilty:str_rowIdForFacility
                                                  Insurance:txt_Insurance.text
                                                     Doctor:str_rowIdForDr
                                                  Ref_MOn_F:txt_Ref_F_Month.text
                                                  Ref_Day_f:txt_Ref_F_Day.text
                                                 Ref_Year_F:txt_Ref_F_Year.text
                                                  Ref_Mon_T:txt_Ref_T_Month.text
                                                  Ref_Day_T:txt_Ref_T_Day.text
                                                 Ref_Year_T:txt_Ref_T_Year.text
                                              Ref_DataRange:txt_Ref_DateRange.text
                                                  App_MOn_F:txt_App_F_Month.text
                                                  App_Day_F:txt_App_F_Day.text
                                                 App_Year_F:txt_App_F_Year.text
                                                  App_Mon_T:txt_App_T_Month.text
                                                  App_Day_T:txt_App_T_Day.text
                                                 App_Year_T:txt_App_T_Year.text
                                              App_DateRange:txt_App_DateRange.text
                                                  Den_MOn_F:txt_Den_F_Month.text
                                                  Den_Day_F:txt_Den_F_Day.text
                                                 Den_Year_F:txt_Den_F_Year.text
                                                  Den_MOn_T:txt_Den_T_Month.text
                                                  Den_Day_T:txt_Den_T_Day.text
                                                 Den_YEar_T:txt_Den_T_Year.text
                                              Den_DateRange:txt_Den_DateRange.text
                                                  Set_MOn_F:txt_Set_F_Month.text
                                                  Set_Day_F:txt_Set_F_Day.text
                                                 Set_Year_F:txt_Set_F_Year.text
                                                Set_MOnth_T:txt_Set_T_Month.text
                                                  Set_Day_T:txt_Set_T_Day.text
                                                 Set_Year_T:txt_Set_T_Year.text
                                              Set_DAteRange:txt_Set_DateRange.text
                                                 RefD_MOn_F:txt_RefDown_F_Month.text
                                                 RefD_Day_F:txt_RefDown_F_Day.text
                                                RefD_Year_F:txt_RefDown_F_Year.text
                                                 RefD_MOn_T:txt_RefDown_T_Month.text
                                                 RefD_Day_T:txt_RefDown_T_Day.text
                                                RefD_Year_T:txt_RefDown_T_Year.text
                                             RefD_DateRange:txt_RefDown_DateRange.text];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            if(dict)
            {
                PatientList *object_PL = [[PatientList alloc]initWithDictionary:dict];
                if([dict[@"msg"] isEqualToString:@"Result found"])
                {
                    SearchReferralViewController *object_SRVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SRVC"];
                    object_SRVC.arr_searchedPatientList=object_PL.arr_main;
                    
                    [self.navigationController pushViewController:object_SRVC animated:YES];
                }
                else
                {
                    [[AppDelegate sharedInstance] showAlertMessage:@"No result found"];
                }
                
            }
            
        });
    });
    
}


#pragma mark - Buttons Actions
-(IBAction)action_fromDateCalender:(UIButton *)sender;
{
    CGRect frame = sender.frame;
    
    StoreTag = 0;
    
    StoreTag = [sender tag];
    
    int y = frame.origin.y;
    int x  =frame.origin.x;
    

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   
    [datePicker setDate:[NSDate date]];
    datePicker.backgroundColor = [UIColor clearColor];
    
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];

    
    if (sender.tag==0) {
        [self createPopOver:y+25 xAxis:x+14];
    }
    if (sender.tag==1) {
       [self createPopOver:y+25 xAxis:x+14];
    }
    if (sender.tag==2) {
        [self createPopOver:y+25 xAxis:x+14];
    }
    if (sender.tag==3) {
        [self createPopOver:y+25 xAxis:x+14];
    }
    if (sender.tag==4) {
        [self createPopOver:y+25 xAxis:x+14];
    }
 }
-(IBAction)action_TODateCalender:(UIButton *)sender
{
    CGRect frame = sender.frame;
    
    StoreTag = 0;
    
    StoreTag = [sender tag];
    int y = frame.origin.y;
    int x=frame.origin.x;
    
    
    if (sender.tag==10) {
        [self createPopOver:y+25 xAxis:x+14];
    }
    if (sender.tag==11) {
        [self createPopOver:y+25 xAxis:x+14];
    }
    if (sender.tag==12) {
        [self createPopOver:y+25 xAxis:x+14];
    }
    if (sender.tag==13) {
        [self createPopOver:y+25 xAxis:x+14];
    }
    if (sender.tag==14) {
        [self createPopOver:y+25 xAxis:x+14];
    }
}
- (void)dateChanged
{
    
    //format date
    NSDateFormatter *FormatDate = [[NSDateFormatter alloc] init];
    [FormatDate setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    
    //set date format
    [FormatDate setDateFormat:@"dd/MM/YYYY"];
    
    //update date textfield
    str1= [FormatDate stringFromDate:[datePicker date]];
        
    [self getSelectedDate:str1];
    
}

- (void )getSelectedDate:(NSString *)daStr {
    
    [arryDate removeAllObjects];
    arryDate= (NSMutableArray *)[daStr componentsSeparatedByString:@"/"];
    
    [self enterDate:arryDate];
 
}

-  (void)enterDate:(NSMutableArray *)arry {
    
    switch (StoreTag) {
        case 0:
            txt_Ref_F_Day.text=[arry objectAtIndex:0];
            txt_Ref_F_Month.text=[arry objectAtIndex:1];
            txt_Ref_F_Year.text=[arry objectAtIndex:2];
            break;
        case 1:
            txt_App_F_Day.text=[arry objectAtIndex:0];
            txt_App_F_Month.text=[arry objectAtIndex:1];
            txt_App_F_Year.text=[arry objectAtIndex:2];
            break;
        case 2:
            txt_Den_F_Day.text=[arry objectAtIndex:0];
            txt_Den_F_Month.text=[arry objectAtIndex:1];
            txt_Den_F_Year.text=[arry objectAtIndex:2];
            break;
        case 3:
            txt_Set_F_Day.text=[arry objectAtIndex:0];
            txt_Set_F_Month.text=[arry objectAtIndex:1];
            txt_Set_F_Year.text=[arry objectAtIndex:2];
            break;
        case 4:
            txt_RefDown_F_Day.text=[arry objectAtIndex:0];
            txt_RefDown_F_Month.text=[arry objectAtIndex:1];
            txt_RefDown_F_Year.text=[arry objectAtIndex:2];
            break;
        case 10:
            txt_Ref_T_Day.text=[arry objectAtIndex:0];
            txt_Ref_T_Month.text=[arry objectAtIndex:1];
            txt_Ref_T_Year.text=[arry objectAtIndex:2];
            break;
        case 11:
            txt_App_T_Day.text=[arry objectAtIndex:0];
            txt_App_T_Month.text=[arry objectAtIndex:1];
            txt_App_T_Year.text=[arry objectAtIndex:2];
            break;
        case 12:
            txt_Den_T_Day.text=[arry objectAtIndex:0];
            txt_Den_T_Month.text=[arry objectAtIndex:1];
            txt_Den_T_Year.text=[arry objectAtIndex:2];
            break;
        case 13:
            txt_Set_T_Day.text=[arry objectAtIndex:0];
            txt_Set_T_Month.text=[arry objectAtIndex:1];
            txt_Set_T_Year.text=[arry objectAtIndex:2];
            break;
        case 14:
            txt_RefDown_T_Day.text=[arry objectAtIndex:0];
            txt_RefDown_T_Month.text=[arry objectAtIndex:1];
            txt_RefDown_T_Year.text=[arry objectAtIndex:2];
            break;
            
            
        default:
            break;
    }

  
}
- (void)createPopOver:(int)yAxis xAxis:(int)xAxis
{
    
    
    popoverController = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popoverController.popoverContentSize = CGSizeMake(300, 220);
    [popoverController presentPopoverFromRect:CGRectMake(xAxis,yAxis, 2, 2) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    popoverController.delegate=self;
}

//

//
//#pragma mark -
//#pragma mark Prettifying Methods...
//
//
////Create our little toast notifications.....



//
//#pragma mark -
//#pragma mark Gesture Recognizer
//



-(IBAction)action_Clear:(id)sender
{
    txt_Doctor.text =@"";
   txt_FirstName.text = @"";
    txt_LastName.text = @"";
    txt_Status.text = @"";
    txt_Facility.text = @"";
    txt_Insurance.text = @"";
    txt_Ref_DateRange.text = @"";
    txt_App_DateRange.text = @"";
    txt_Den_DateRange.text = @"";
    txt_Set_DateRange.text = @"";
    txt_RefDown_DateRange.text = @"";
    txt_App_F_Day.text = @"";
    txt_App_F_Month.text = @"";
    txt_App_F_Year.text = @"";
    txt_Ref_F_Day.text = @"";
    txt_Ref_F_Month.text = @"";
    txt_Ref_F_Year.text = @"";
    txt_Den_F_Day.text = @"";
    txt_Den_F_Month.text = @"";
    txt_Den_F_Year.text = @"";
    txt_Set_F_Day.text = @"";
    txt_Set_F_Month.text = @"";
    txt_Set_F_Year.text = @"";
    txt_RefDown_F_Day.text = @"";
    txt_RefDown_F_Month.text = @"";
    txt_RefDown_F_Year.text = @"";
    txt_App_T_Day.text = @"";
    txt_App_T_Month.text = @"";
    txt_App_T_Year.text = @"";
    txt_Ref_T_Day.text = @"";
    txt_Ref_T_Month.text = @"";
    txt_Ref_T_Year.text = @"";
    txt_Den_T_Day.text = @"";
    txt_Den_T_Month.text = @"";
    txt_Den_T_Year.text = @"";
    txt_Set_T_Day.text = @"";
    txt_Set_T_Month.text = @"";
    txt_Set_T_Year.text = @"";
    txt_RefDown_T_Day.text = @"";
    txt_RefDown_T_Month.text = @"";
    txt_RefDown_T_Year.text = @"";
    
    
}

-(IBAction)customDropDownMenu:(UIButton*)sender
{
//    tbl_dropDown.frame = CGRectMake(sender.frame.origin.x+36, sender.frame.origin.y+101, sender.frame.size.width, 0);
//    tbl_dropDown.hidden=YES;
    tableViewController.tableView.contentOffset=CGPointMake(0, 0);
    [popover presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    //[tbl_dropDown setContentOffset:CGPointMake(0, 0)];
    selectListNumber =sender.tag;
    //[UIView animateWithDuration:.25 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        switch (sender.tag) {
            case 0:
                arr_dropdownlist=arr_drFacilityList;
                controller_popover.preferredContentSize = CGSizeMake(300,500);
                [popover setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
              
                break;
            case 1:
                arr_dropdownlist=arr_primaryList;
                controller_popover.preferredContentSize = CGSizeMake(300,500);
                [popover setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
                
                break;
            case 2:
                arr_dropdownlist=arr_drList;
                controller_popover.preferredContentSize = CGSizeMake(300,500);
                [popover setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
              
                break;
          
            case 8:
                arr_dropdownlist=arr_statusList;
                controller_popover.preferredContentSize = CGSizeMake(300,500);
                [popover setPopoverContentSize:CGSizeMake(300, 200) animated:NO];
              
                break;
            default:
                arr_dropdownlist=arr_dateRange;
                controller_popover.preferredContentSize = CGSizeMake(300,200);
                
                [popover setPopoverContentSize:CGSizeMake(300, 200) animated:NO];
              
                break;
        }

        [tableViewController.tableView reloadData];
   
    
}

-(IBAction)action_Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:txt_Ref_F_Month]) {
        [txt_Ref_F_Day becomeFirstResponder];
    }
    else if ([textField isEqual:txt_Ref_F_Day]){
        [txt_Ref_F_Year becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Ref_F_Year]){
        [txt_Ref_T_Month becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Ref_T_Month]){
        [txt_Ref_T_Day becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Ref_T_Day]){
        [txt_Ref_T_Year becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Ref_T_Year]){
        [txt_App_F_Month becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_App_F_Month]){
        [txt_App_F_Day becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_App_F_Day]){
        [txt_App_F_Year becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_App_F_Year]){
        [txt_App_T_Month becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_App_T_Month]){
        [txt_App_T_Day becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_App_T_Day]){
        [txt_App_T_Year becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_App_T_Year]){
        [txt_Den_F_Month becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Den_F_Month]){
        [txt_Den_F_Day becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Den_F_Day]){
        [txt_Den_F_Year becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Den_F_Year]){
        [txt_Den_T_Month becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Den_T_Month]){
        [txt_Den_T_Day becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Den_T_Day]){
        [txt_Den_T_Year becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Den_T_Year]){
        [txt_Set_F_Month becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Set_F_Month]){
        [txt_Set_F_Day becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Set_F_Day]){
        [txt_Set_F_Year becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Set_F_Year]){
        [txt_Set_T_Month becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Set_T_Month]){
        [txt_Set_T_Day becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Set_T_Day]){
        [txt_Set_T_Year becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_Set_T_Year]){
        [txt_RefDown_F_Month becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_RefDown_F_Month]){
        [txt_RefDown_F_Day becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_RefDown_F_Day]){
        [txt_RefDown_F_Year becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_RefDown_F_Year]){
        [txt_RefDown_T_Month becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_RefDown_T_Month]){
        [txt_RefDown_T_Day becomeFirstResponder ];
    }
    else if ([textField isEqual:txt_RefDown_T_Day]){
        [txt_RefDown_T_Year becomeFirstResponder ];
    }
    else  [textField resignFirstResponder];

    [self resetMainView];
   
    return YES;
}
#pragma mark - animate methods
- (void)animateMainView:(CGFloat)yaxix {
    
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(frame.origin.x, yaxix);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame = frame;
    [UIView commitAnimations];
    
}
- (void)resetMainView {
    
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(frame.origin.x, 0);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame = frame;
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:txt_Ref_F_Month]||[textField isEqual:txt_Ref_F_Day]||[textField isEqual:txt_Ref_F_Year])
    [self animateMainView:-10];
    
    else if ([textField isEqual:txt_App_F_Month]||[textField isEqual:txt_App_F_Day]||[textField isEqual:txt_App_F_Year])
        [self animateMainView:-20];
    
    else if ([textField isEqual:txt_Den_F_Month]||[textField isEqual:txt_Den_F_Day]||[textField isEqual:txt_Den_F_Year])
        [self animateMainView:-65];

    else if ([textField isEqual:txt_Set_F_Month]||[textField isEqual:txt_Set_F_Day]||[textField isEqual:txt_Set_F_Year])
        [self animateMainView:-120];
    
    else if ([textField isEqual:txt_RefDown_F_Month]||[textField isEqual:txt_RefDown_F_Day]||[textField isEqual:txt_RefDown_F_Year])
        [self animateMainView:-190];
    
    if ([textField isEqual:txt_Ref_T_Month]||[textField isEqual:txt_Ref_T_Day]||[textField isEqual:txt_Ref_T_Year])
        [self animateMainView:-10];

    else if ([textField isEqual:txt_App_T_Month]||[textField isEqual:txt_App_T_Day]||[textField isEqual:txt_App_T_Year])
        [self animateMainView:-20];
    
    else if ([textField isEqual:txt_Den_T_Month]||[textField isEqual:txt_Den_T_Day]||[textField isEqual:txt_Den_T_Year])
        [self animateMainView:-65];

    else if ([textField isEqual:txt_Set_T_Month]||[textField isEqual:txt_Set_T_Day]||[textField isEqual:txt_Set_T_Year])
        [self animateMainView:-120];
    
    else if ([textField isEqual:txt_RefDown_T_Month]||[textField isEqual:txt_RefDown_T_Day]||[textField isEqual:txt_RefDown_T_Year])
        [self animateMainView:-190];
    

    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:txt_Ref_F_Month]||[textField isEqual:txt_App_F_Month]||[textField isEqual:txt_Den_F_Month]||[textField isEqual:txt_Set_F_Month]||[textField isEqual:txt_RefDown_F_Month]||[textField isEqual:txt_Ref_F_Day]||[textField isEqual:txt_App_F_Day]||[textField isEqual:txt_Den_F_Day]||[textField isEqual:txt_Set_F_Day]||[textField isEqual:txt_RefDown_F_Day]||[textField isEqual:txt_Ref_T_Month]||[textField isEqual:txt_App_T_Month]||[textField isEqual:txt_Den_T_Month]||[textField isEqual:txt_Set_T_Month]||[textField isEqual:txt_RefDown_T_Month]||[textField isEqual:txt_Ref_T_Day]||[textField isEqual:txt_App_T_Day]||[textField isEqual:txt_Den_T_Day]||[textField isEqual:txt_Set_T_Day]||[textField isEqual:txt_RefDown_T_Day])
    {
        BOOL returnValue;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        returnValue =  [string isEqualToString:filtered];
        
        if(textField.text.length<2 && ![string isEqualToString:@""])
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
else  if([textField isEqual:txt_Ref_F_Year]||[textField isEqual:txt_App_F_Year]||[textField isEqual:txt_Den_F_Year]||[textField isEqual:txt_Set_F_Year]||[textField isEqual:txt_RefDown_F_Year]||[textField isEqual:txt_Ref_F_Year]||[textField isEqual:txt_App_F_Year]||[textField isEqual:txt_Den_F_Year]||[textField isEqual:txt_Set_F_Year]||[textField isEqual:txt_RefDown_F_Year]||[textField isEqual:txt_Ref_T_Year]||[textField isEqual:txt_App_T_Year]||[textField isEqual:txt_Den_T_Year]||[textField isEqual:txt_Set_T_Year]||[textField isEqual:txt_RefDown_T_Year]||[textField isEqual:txt_Ref_T_Year]||[textField isEqual:txt_App_T_Year]||[textField isEqual:txt_Den_T_Year]||[textField isEqual:txt_Set_T_Year]||[textField isEqual:txt_RefDown_T_Year])
    {
        BOOL returnValue;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        returnValue = [string isEqualToString:filtered];
        if(textField.text.length<4 && ![string isEqualToString:@""])
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
