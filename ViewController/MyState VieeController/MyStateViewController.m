//
//  MyStateViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "MyStateViewController.h"
#import "StatsModel.h"
#import "StatsView.h"
#import "AppDelegate.h"
#import "SearchReferralViewController.h"
#import "StateTallyUsers.h"

#import "HistoryCell.h"

/*
 
 StatsTallyCell
 */

@interface MyStateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int selectedDropDownMenu, selectYearTab , monthNumber;
    
    NSString *selectedMonthFromTblView, *currentYear , *currentMonth , *currentMonthYear;
    
    dispatch_queue_t newQueue;
    NSArray *arr_sortedDates;
    
    NSMutableDictionary *dict_information;
    
   
    
    UIPopoverController *popover_dropDown;
    UITableViewController *table_dropDown;
    
    NSArray *arr_Dropdownlist;
    NSArray *arr_date;
}

@end

@implementation MyStateViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(labelClicked:) name:@"CLICKED_LABEL" object:nil];
    selectYearTab=0;
    NSDateFormatter *formt = [NSDateFormatter new];
    [formt setDateFormat:@"MM/dd/yyyy"];
    arr_date = [[formt stringFromDate:[NSDate date]] componentsSeparatedByString:@"/"];
    
    [self creatPopoverForDropDown];
    [self callWebserviceForMonth:arr_date[0]:arr_date[2]];
    currentMonth = arr_date[0];
    currentMonthYear = arr_date[2];
    
    [formt setDateFormat:@"MMMM"];
   lbl_year.text = arr_date[2];
    lbl_month.text = [NSString stringWithFormat:@"%@ %@",[formt stringFromDate:[NSDate date]],arr_date[2]];
   
    
    currentYear = lbl_year.text;
	// Do any additional setup after loading the view.
}




-(void)callWebserviceForMonth:(NSString*)month :(NSString*)year
{
    newQueue = dispatch_queue_create("stats", 0);
    
    dispatch_async(newQueue, ^{
        
        StatsView *object_view = [StatsView new];
        NSDictionary *dict = [object_view getStatsInformationForID:[[AppDelegate sharedInstance] rep_patientID] Month:month Year:year];
       if(dict)
       {
        NSDictionary* dict_monthly = dict[@"monthly_tally"];
        NSArray *arr_monthDates = [dict_monthly allKeys];
        
        arr_sortedDates= [arr_monthDates sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *str1 =  obj1;
            NSString *str2 = obj2;
            
            return [str1 compare:str2];
        }];
        dict_information = [NSMutableDictionary dictionary];
        int key = 0;
        for (NSString *str in arr_sortedDates)
        {
           
            StatsModel *modelObj = [StatsModel getObjectFromDictionary:dict andDate:str];
            NSString *mKey = [NSString stringWithFormat:@"%i",key];
           
            
            StatsModelKeys *modelKeyObj = [modelObj.arr_dateInfo objectAtIndex:0];
            
            
             [dict_information setObject:modelKeyObj forKey:mKey];
            
                       
            key++;
            
        }

       }
        dispatch_async(dispatch_get_main_queue(), ^{
            
             [[AppDelegate sharedInstance]  removeCustomLoader];
            if(dict)
            {
            lbl_MonthReferral.text=dict[@"Total_Ref_Count"];
            lbl_MonthApp.text=dict[@"Total_App_Count"];
            lbl_MonthDen.text=dict[@"Total_Den_Count"];
            lbl_MonthSetup.text=dict[@"Total_SU_Count"];
            lbl_MonthNSU.text = dict[@"Total_NSU_U_Count"];
            lbl_MonthNSUU.text = dict[@"Total_NSU_O_Count"];
                if(monthNumber>0)currentMonth = [NSString stringWithFormat:@"%i",monthNumber];
                
                int yearLength = lbl_month.text.length-4;
                currentMonthYear = [lbl_month.text substringFromIndex:yearLength];
            
            [table_monthTally reloadData];
            }
           
        });
        
        
    });
    
    [[AppDelegate sharedInstance]  showCustomLoader:self];
}

-(void)callWebserviceForAnnual:(NSString*)year
{
    newQueue = dispatch_queue_create("stats", 0);
    
    dispatch_async(newQueue, ^{
        
        StatsView *object_view = [StatsView new];
        NSDictionary *dict = [object_view getStatsYearInformationForID:[[AppDelegate sharedInstance] rep_patientID] Year:year];
      if(dict)
      {
        NSDictionary* dict_monthly = dict[@"annual_tally"];
        NSArray *arr_YearMonth = [dict_monthly allKeys];
        
             NSMutableDictionary*   dict_yearInformation = [NSMutableDictionary dictionary];
       
        for (NSString *str in arr_YearMonth)
        {
            
            StatsModel *modelObj = [StatsModel getObjectFromDictionary:dict forMonth:str];
            
            
            
            StatsModelKeys *modelKeyObj = [modelObj.arr_dateInfo objectAtIndex:0];
            
            
            [dict_yearInformation setObject:modelKeyObj forKey:str];
            
            
           
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[AppDelegate sharedInstance]  removeCustomLoader];
            lbl_yearReferral.text=dict[@"Total_Ref_Count"];
            lbl_yearApp.text=dict[@"Total_App_Count"];
            lbl_yearDen.text=dict[@"Total_Den_Count"];
            lbl_yearSetup.text=dict[@"Total_SU_Count"];
            lbl_yearNSU.text = dict[@"Total_NSU_O_Count"];
            lbl_yearNSUU.text = dict[@"Total_NSU_U_Count"];
            currentYear=lbl_year.text;
            [self yearLabelValueFromDictionary:dict_yearInformation];
            
//            [view_month setHidden:YES];
//            [view_year setHidden:NO];
        });
        
      }
        else
        {
              dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance]  removeCustomLoader];
              });
  
        }
    });
    
    [[AppDelegate sharedInstance]  showCustomLoader:self];
}
-(void)yearLabelValueFromDictionary:(NSDictionary*)yearDictionary
{
    StatsModelKeys *modelKeyObj = [yearDictionary valueForKey:@"January"];
    lbl_JanApp.text = modelKeyObj.str_Total_App;
    lbl_Janden.text = modelKeyObj.str_Total_Den;
    lbl_JanRef.text = modelKeyObj.str_Total_Ref;
    lbl_JanSetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"February"];
    lbl_FebApp.text = modelKeyObj.str_Total_App;
    lbl_Febden.text = modelKeyObj.str_Total_Den;
    lbl_FebRef.text = modelKeyObj.str_Total_Ref;
    lbl_FebSetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"March"];
    lbl_MarApp.text = modelKeyObj.str_Total_App;
    lbl_Marden.text = modelKeyObj.str_Total_Den;
    lbl_MarRef.text = modelKeyObj.str_Total_Ref;
    lbl_MarSetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"April"];
    lbl_AprApp.text = modelKeyObj.str_Total_App;
    lbl_Aprden.text = modelKeyObj.str_Total_Den;
    lbl_AprRef.text = modelKeyObj.str_Total_Ref;
    lbl_AprSetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"May"];
    lbl_MayApp.text = modelKeyObj.str_Total_App;
    lbl_Mayden.text = modelKeyObj.str_Total_Den;
    lbl_MayRef.text = modelKeyObj.str_Total_Ref;
    lbl_MaySetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"June"];
    lbl_JunApp.text = modelKeyObj.str_Total_App;
    lbl_Junden.text = modelKeyObj.str_Total_Den;
    lbl_JunRef.text = modelKeyObj.str_Total_Ref;
    lbl_JunSetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"July"];
    lbl_JulApp.text = modelKeyObj.str_Total_App;
    lbl_Julden.text = modelKeyObj.str_Total_Den;
    lbl_JulRef.text = modelKeyObj.str_Total_Ref;
    lbl_JulSetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"August"];
    lbl_AugApp.text = modelKeyObj.str_Total_App;
    lbl_Augden.text = modelKeyObj.str_Total_Den;
    lbl_AugRef.text = modelKeyObj.str_Total_Ref;
    lbl_AugSetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"September"];
    lbl_SepApp.text = modelKeyObj.str_Total_App;
    lbl_Sepden.text = modelKeyObj.str_Total_Den;
    lbl_SepRef.text = modelKeyObj.str_Total_Ref;
    lbl_SepSetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"October"];
    lbl_OctApp.text = modelKeyObj.str_Total_App;
    lbl_Octden.text = modelKeyObj.str_Total_Den;
    lbl_OctRef.text = modelKeyObj.str_Total_Ref;
    lbl_OctSetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"November"];
    lbl_NovApp.text = modelKeyObj.str_Total_App;
    lbl_Novden.text = modelKeyObj.str_Total_Den;
    lbl_NovRef.text = modelKeyObj.str_Total_Ref;
    lbl_NovSetup.text = modelKeyObj.str_Total_SU;
    
    modelKeyObj =[yearDictionary valueForKey:@"December"];
    lbl_DecApp.text = modelKeyObj.str_Total_App;
    lbl_Decden.text = modelKeyObj.str_Total_Den;
    lbl_DecRef.text = modelKeyObj.str_Total_Ref;
    lbl_DecSetup.text = modelKeyObj.str_Total_SU;
    
   
    
}

-(void)creatPopoverForDropDown
{
   
    table_dropDown=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
  
    table_dropDown.preferredContentSize = CGSizeMake(150,200);
    
    table_dropDown.tableView.tag=513;
    table_dropDown.tableView.delegate=self;
    table_dropDown.tableView.dataSource=self;
     table_dropDown.tableView.separatorInset = UIEdgeInsetsZero;
    
  
    
    popover_dropDown = [[UIPopoverController alloc] initWithContentViewController:table_dropDown];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==513) return arr_Dropdownlist.count;
    
    return arr_sortedDates.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell_main;
    
    if([tableView isEqual:table_monthTally])
    {
        static NSString *str = @"StatsTallyCell";
        HistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
        [cell customizeLabelInCell];
         NSString *key = [NSString stringWithFormat:@"%i",indexPath.row];
        StatsModelKeys *object_SMK = [dict_information valueForKey:key];
        cell.lbl_monthDate.text= [arr_sortedDates[indexPath.row] substringToIndex:5];
        cell.lbl_totalRef.text=[NSString stringWithFormat:@"%@",object_SMK.str_Total_Ref];
        cell.lbl_totalApp.text=[NSString stringWithFormat:@"%@",object_SMK.str_Total_App];
        cell.lbl_totalDen.text=[NSString stringWithFormat:@"%@",object_SMK.str_Total_Den];
        cell.lbl_totalSetup.text=[NSString stringWithFormat:@"%@",object_SMK.str_Total_SU];
        cell.btn_totalReferral.tag = 10*(indexPath.row+1)+1;
        cell.btn_totalApproval.tag  = 10*(indexPath.row+1)+2;
        cell.btn_totalDenied.tag = 10*(indexPath.row+1)+3;
        cell.btn_totalSetup.tag = 10*(indexPath.row+1)+4;
        
        [cell.btn_totalApproval addTarget:self action:@selector(selectedMonthlyLabel:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_totalReferral addTarget:self action:@selector(selectedMonthlyLabel:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_totalDenied addTarget:self action:@selector(selectedMonthlyLabel:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_totalSetup addTarget:self action:@selector(selectedMonthlyLabel:) forControlEvents:UIControlEventTouchUpInside];
        
        if([cell.lbl_totalApp.text isEqualToString:@""])
        {
            cell.btn_totalApproval.userInteractionEnabled=NO;
        }
        else{
            cell.btn_totalApproval.userInteractionEnabled=YES;
            
        }
        if([cell.lbl_totalRef.text isEqualToString:@""])
        {
            cell.btn_totalReferral.userInteractionEnabled=NO;
        }
        else{
            cell.btn_totalReferral.userInteractionEnabled=YES;
        }
        if([cell.lbl_totalDen.text isEqualToString:@""])
        {
            cell.btn_totalDenied.userInteractionEnabled=NO;
        }
        else{
            cell.btn_totalDenied.userInteractionEnabled=YES;
        }
        if([cell.lbl_totalSetup.text isEqualToString:@""])
        {
            cell.btn_totalSetup.userInteractionEnabled=NO;
        }
        else{
            cell.btn_totalSetup.userInteractionEnabled=YES;
        }
        
        cell_main = cell;
    }
    else
    {
        static NSString *str = @"dropDownCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.text = arr_Dropdownlist[indexPath.row];
        cell_main=cell;
    }
    
    return cell_main;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==513) return 35.0;
    return 58.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==513)
    {
        if (selectedDropDownMenu==0)
        {
            lbl_selectedYear.text = arr_Dropdownlist[indexPath.row];
            lbl_year.text =arr_Dropdownlist[indexPath.row];
            
        }
        else if (selectedDropDownMenu==1)
        {
            
            lbl_selectedMonth.text = arr_Dropdownlist[indexPath.row];
            
            NSString *selectedYear = lbl_selectedMonthYear.text;
           selectedMonthFromTblView = lbl_selectedMonth.text;
            if([selectedYear isEqualToString:@"Select Year"])
            {
                selectedYear = arr_date[2];
            }
            if([selectedMonthFromTblView isEqualToString:@"Select Month"])
            {
                selectedMonthFromTblView = arr_date[0];
            }
            else selectedMonthFromTblView = [NSString stringWithFormat:@"%i",indexPath.row+1];
            lbl_month.text = [NSString stringWithFormat:@"%@ %@",lbl_selectedMonth.text,selectedYear];
            monthNumber = indexPath.row+1;
        
        }
        else if (selectedDropDownMenu==2)
        {
            
            lbl_selectedMonthYear.text = arr_Dropdownlist[indexPath.row];
            
            NSString *selectedYear = lbl_selectedMonthYear.text;
            NSString *selectedMonth = lbl_selectedMonth.text;
            if([selectedYear isEqualToString:@"Select Year"])
            {
                selectedYear = arr_date[2];
            }
            if([selectedMonth isEqualToString:@"Select Month"])
            {
                selectedMonth = arr_date[0];
                lbl_month.text = [NSString stringWithFormat:@"%@ %@",[lbl_month.text substringToIndex:(lbl_month.text.length-5)],selectedYear];
            }
            else
            {
                selectedMonth = [NSString stringWithFormat:@"%i",indexPath.row+1];
                lbl_month.text = [NSString stringWithFormat:@"%@ %@",lbl_selectedMonth.text,selectedYear];
            }
           
        }
        
        [popover_dropDown dismissPopoverAnimated:YES];
        

    }
}

-(void)selectedMonthlyLabel :(UIButton*)sender
{
    NSString *str_tag = [NSString stringWithFormat:@"%i",sender.tag];
    int DateValue = str_tag.length-1;
    int infoTypeValue =[[str_tag substringFromIndex:DateValue] intValue];
    
    NSString *infoDate =[str_tag substringToIndex:DateValue];
    
    dispatch_queue_t yearQueue = dispatch_queue_create("YEAR", 0);
    dispatch_async(yearQueue, ^{
        
        StatsView *object_view = [StatsView new];
        NSDictionary *dict = [object_view getMonthTallyUserForID:[[AppDelegate sharedInstance] rep_patientID] Year:currentMonthYear Month:currentMonth andDay:infoDate];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance]removeCustomLoader];
            if(dict){
                StateTallyUsers *object_stu = [StateTallyUsers getAnnualTallyUserInfoFromDict:dict];
                SearchReferralViewController *object_SRVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SRVC"];
                switch (infoTypeValue) {
                    case 1:
                        object_SRVC.arr_searchedPatientList = object_stu.arr_Referral;
                        break;
                    case 2:
                        object_SRVC.arr_searchedPatientList = object_stu.arr_Approved;
                        break;
                    case 3:
                        object_SRVC.arr_searchedPatientList = object_stu.arr_Denied;
                        break;
                    case 4:
                        object_SRVC.arr_searchedPatientList = object_stu.arr_Setup;
                        break;
                        
                    default:
                        break;
                }
                
                [self.navigationController pushViewController:object_SRVC animated:YES];
                
            }
            
        });
        

        

    });
    [[AppDelegate sharedInstance] showCustomLoader:self];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actioSegment:(UISegmentedControl*)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            lbl_title.text=@"Monthly Referral Tally";
            [view_month setHidden:NO];
            [view_year setHidden:YES];
            break;
        case 1:
            if(selectYearTab==0)
            {
                [self callWebserviceForAnnual:arr_date[2]];
                selectYearTab++;
            }
             lbl_title.text=@"Annual Referral Tally";
            [view_month setHidden:YES];
            [view_year setHidden:NO];
            
            break;
        default:
            break;
    }
}

- (IBAction)action_selection:(UIButton*)sender
{
    selectedDropDownMenu = sender.tag;
    [popover_dropDown presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    switch (sender.tag) {
        case 0:
            arr_Dropdownlist = @[@"2014",@"2013",@"2012",@"2011",@"2010",@"2009",@"2008"];
            
           
            
            break;
        case 1:
            arr_Dropdownlist = @[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
            
                       break;
        case 2:
            arr_Dropdownlist = @[@"2014",@"2013",@"2012",@"2011",@"2010",@"2009",@"2008"];
            
           
            
            break;
            
        default:
            break;
    }
    [table_dropDown.tableView setContentOffset:CGPointMake(0, 0)];
    [table_dropDown.tableView reloadData];
}

- (IBAction)actionGo:(UIButton*)sender
{
   
    int monthLength = lbl_month.text.length-4;
    NSString *str_monthYear= [lbl_month.text substringFromIndex:monthLength];
   
    
  
    switch (sender.tag) {
        case 0:
            [self callWebserviceForMonth:selectedMonthFromTblView :str_monthYear];
            break;
        case 1:
            [self callWebserviceForAnnual:lbl_year.text];
            break;
        default:
            break;
    }
}

- (void)labelClicked:(NSNotification *)notification
{
    NSString *str_tag = [NSString stringWithFormat:@"%i",[[notification object] intValue]];
    
    
    int monthValue = str_tag.length-1;
    int infoTypeValue =[[str_tag substringFromIndex:monthValue] intValue];
    
    
    if([[notification object] intValue]<900&&[[notification object] intValue]>800)
    {
        dispatch_queue_t yearQueue = dispatch_queue_create("YEAR", 0);
        dispatch_async(yearQueue, ^{
            
            StatsView *object_view = [StatsView new];
            NSDictionary *dict = [object_view getAnnualTallyTotalUserForID:[[AppDelegate sharedInstance] rep_patientID] Year:currentYear];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate sharedInstance]removeCustomLoader];
                if(dict){
                    StateTallyUsers *object_stu = [StateTallyUsers getAnnualTallyUserInfoFromDict:dict];
                    SearchReferralViewController *object_SRVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SRVC"];
                    switch (infoTypeValue) {
                        case 1:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Referral;
                            break;
                        case 2:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Approved;
                            break;
                        case 3:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Denied;
                            break;
                        case 4:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Setup;
                            break;
                        case 5:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_NSUO;
                            break;
                        case 6:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_NSUU;
                            break;
                            
                        default:
                            break;
                    }
                    
                    [self.navigationController pushViewController:object_SRVC animated:YES];
                    
                }
                
            });
            
            
            
            
        });
        [[AppDelegate sharedInstance] showCustomLoader:self];
    }
  else if([[notification object] intValue]>900)
    {
        dispatch_queue_t yearQueue = dispatch_queue_create("YEAR", 0);
        dispatch_async(yearQueue, ^{
            
            StatsView *object_view = [StatsView new];
            NSDictionary *dict = [object_view getAnnualTallyUserForID:[[AppDelegate sharedInstance] rep_patientID] Year:currentMonthYear andMonth:currentMonth isTotalTally:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate sharedInstance]removeCustomLoader];
                if(dict){
                    StateTallyUsers *object_stu = [StateTallyUsers getAnnualTallyUserInfoFromDict:dict];
                    SearchReferralViewController *object_SRVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SRVC"];
                    switch (infoTypeValue) {
                        case 1:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Referral;
                            break;
                        case 2:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Approved;
                            break;
                        case 3:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Denied;
                            break;
                        case 4:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Setup;
                            break;
                        case 5:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_NSUO;
                            break;
                        case 6:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_NSUU;
                            break;
                            
                        default:
                            break;
                    }
                    
                    [self.navigationController pushViewController:object_SRVC animated:YES];
                    
                }
                
            });
            
            
            
            
        });
        [[AppDelegate sharedInstance] showCustomLoader:self];
    }
    else
    {
   
   
    NSString *month =[str_tag substringToIndex:monthValue];
    
    UILabel *clickedLabel = (UILabel*)[view_year viewWithTag:[str_tag intValue]];
    if(![clickedLabel.text isEqualToString:@""])
    {
        dispatch_queue_t yearQueue = dispatch_queue_create("YEAR", 0);
        dispatch_async(yearQueue, ^{
            
              StatsView *object_view = [StatsView new];
            NSDictionary *dict = [object_view getAnnualTallyUserForID:[[AppDelegate sharedInstance] rep_patientID] Year:currentYear andMonth:month isTotalTally:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate sharedInstance]removeCustomLoader];
                if(dict){
                    StateTallyUsers *object_stu = [StateTallyUsers getAnnualTallyUserInfoFromDict:dict];
                    SearchReferralViewController *object_SRVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SRVC"];
                    switch (infoTypeValue) {
                        case 1:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Referral;
                            break;
                        case 2:
                           object_SRVC.arr_searchedPatientList = object_stu.arr_Approved;
                            break;
                        case 3:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Denied;
                            break;
                        case 4:
                            object_SRVC.arr_searchedPatientList = object_stu.arr_Setup;
                            break;
                            
                        default:
                            break;
                    }
                    
                    [self.navigationController pushViewController:object_SRVC animated:YES];
                    
                }
                
            });
            
            
        });
        
        [[AppDelegate sharedInstance] showCustomLoader:self];
    }
    
}
}

-(NSMutableAttributedString *)getUnderlineText :(NSString *)myText
{
    if (myText.length>0) {
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:myText];
        [attributeString addAttribute:NSUnderlineStyleAttributeName
                                value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                range:(NSRange){0,[attributeString length]}];
        [attributeString addAttribute:NSUnderlineColorAttributeName
                                value:[UIColor blueColor]
                                range:(NSRange){0,[attributeString length]}];
        
        return attributeString;
        
    }
    return nil;
}


@end
