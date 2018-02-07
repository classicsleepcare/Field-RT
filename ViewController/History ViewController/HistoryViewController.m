//
//  HistoryViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "HistoryViewController.h"
#import "DoctorDetailCell.h"
#import "HistoryView.h"
#import "HistoryModel.h"
#import "AppDelegate.h"
#import "PatientInformationViewController.h"
#import "HistoryCell.h"
#import <CoreLocation/CoreLocation.h>


@interface HistoryViewController ()<TabBarTextSearchDelegate, CLLocationManagerDelegate>
{
    NSArray *arr_TableSearchData;
    
    NSArray *arr_historyList;
    NSArray *arr_referral , *arr_setup, *arr_headerButtons ;
    NSMutableArray *arr_serial;
    HistoryModel *object_HM;
    
    CGRect framePDF;
    UISwitch *switchBtn;
    
   
    
    dispatch_queue_t myqueue;
}

@property (nonatomic,retain) CLLocationManager *locationManager;


@end

@implementation HistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}



#pragma mark - TabBarSearch Delegates

-(void)searchedDataFromText:(NSString *)text
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
    
    
    if (arr_TableSearchData)
    {
        
        arr_TableSearchData=nil;
        
    }
        arr_TableSearchData = [arr_historyList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSDictionary *dict1 = evaluatedObject;
        NSString *name = [dict1 objectForKey:@"Pt_First"];
        name =[name lowercaseString];
         NSString *lastName = [[dict1 objectForKey:@"Pt_Last"] lowercaseString];
        NSString *searchStr =[text lowercaseString];
        if([name rangeOfString:searchStr].location != NSNotFound || [lastName rangeOfString:searchStr].location != NSNotFound) {
            return YES;
        }
        return NO;
        
    }]];
    
    if (arr_TableSearchData.count==0&&text.length>0) {
        [[AppDelegate sharedInstance] showAlertMessage:@"No Result Found"];
    }
    else
    {
        
    }
    [table_historyView reloadData];
    [table_historyView setContentOffset:CGPointMake(0, 0)];
}

- (void)searchBarClearButtonClicked:(NSString *)seTxt {
    
    // if ([seTxt isEqualToString:@""]) {
    
    arr_TableSearchData=nil;
    
    [table_historyView reloadData];
    //}
}
// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
    
    NSString *lat = [NSString stringWithFormat:@"%f", manager.location.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f", manager.location.coordinate.longitude];
    
    NSLog(@"lat=%@, lon=%@", lat, lon);
    
    [[NSUserDefaults standardUserDefaults] setObject:lat forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults] setObject:lon forKey:@"lon"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    
    
    
    NSDate *date_current = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:date_current];
    [[AppDelegate sharedInstance] showCustomLoader:self];
     myqueue = dispatch_queue_create("Kumar", 0);
    
    dispatch_async(myqueue, ^{
        HistoryView *object_HV = [HistoryView new];
        NSDictionary *dict = [object_HV getHistoryListForId:[[AppDelegate sharedInstance] rep_patientID]FromDate:date];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            if(dict)
            {
            object_HM = [[HistoryModel alloc]initWithDictionary:dict];
            [self responseData:object_HM];
            }
        });
    });
    switchBtn.on=YES;
    arr_serial = [NSMutableArray array];
    arr_headerButtons = @[btn_appDate,btn_deniedDate,btn_doctor,btn_FirstName,btn_insurance,btn_LastName,btn_RefDate,btn_setupDate,btn_status];
}


-(void)viewDidAppear:(BOOL)animated
{
    DoctorViewController *object_tabBar = (DoctorViewController*)self.navigationController.parentViewController;
    object_tabBar.searchDelagate = self;
}
-(void)responseData:(HistoryModel*)object
{
    if([object.msg isEqualToString:@"Record(s) found"])
    {
        arr_referral = object.arr_Referral;
        arr_setup=object.arr_setup;
        arr_historyList=[self sortedDictionaryByNames:arr_referral:@"Ref_Date"];

    }
    else
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"No Setup & Referral History for last 30 Days from today"];
       
    }
    [table_historyView reloadData];
 }

#pragma mark -
#pragma mark -


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arr_TableSearchData.count>0)return arr_TableSearchData.count;
    return arr_historyList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"RSHistoryCell";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    [cell customizeLabelInCell];
    
    NSDictionary *dict;
    if (arr_TableSearchData.count>0)
    {
        dict = arr_TableSearchData[indexPath.row];
    }
    else
    {
        dict = arr_historyList[indexPath.row];
    }
    
    cell.lbl_appDate.text =dict[@"App_Date"];
    cell.lbl_denDate.text =dict[@"Den_Date"];
    cell.lbl_doc.text=dict[@"Doctor"];
    cell.lbl_firstName.attributedText =[self getUnderlineText:dict[@"Pt_First"]];
    cell.lbl_insurance.text =dict[@"Pri_Ins"];
    cell.lbl_lastName.attributedText =[self getUnderlineText:dict[@"Pt_Last"]];
    cell.lbl_refDate.text =dict[@"Ref_Date"];
    cell.lbl_serial.text = [NSString stringWithFormat:@"%i",indexPath.row+1];
    cell.lbl_setupDate.text =dict[@"SU_Date"];
    cell.lbl_status.text =dict[@"Status"];
    cell.btn_selectedPatient.tag = indexPath.row;
    [cell.btn_selectedPatient addTarget:self action:@selector(action_selectedRow:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

#pragma mark -
#pragma mark -

-(NSArray*)sortedDictionaryByNames :(NSArray*)array :(NSString*)key
{
    NSArray *sortedArray;
    NSSortDescriptor*cityDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:NO];
    NSArray* sortDescriptors = [NSArray arrayWithObject:cityDescriptor];
    sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
}

-(void)action_selectedRow:(UIButton*)btn

{
    int tag = btn.tag;
    NSDictionary *dict_info ;
    
     if (arr_TableSearchData.count>0)
     {
         dict_info =arr_TableSearchData[tag];
     }
    else
    {
        dict_info =arr_historyList[tag];
    }
    [[AppDelegate sharedInstance] showCustomLoader:self];
    myqueue = dispatch_queue_create("Kumar", 0);
    
    dispatch_async(myqueue, ^{
        HistoryView *object_HV = [HistoryView new];
        NSDictionary *dict = [object_HV getDetailListForPatientOfId:dict_info[@"Pt_ID"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            if(dict)
            {
            object_HM = [[HistoryModel alloc]initWithDictionaryForPatientDetail:dict];
            PatientInformationViewController *object_PIVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PIVC"];
            object_PIVC.dict_patientInfo=object_HM.dict_profileInfo;
            object_PIVC.dict_docInfo=object_HM.dict_docInfo;
            object_PIVC.dict_insInfo=object_HM.dict_insInfo;
            object_PIVC.arr_pdfs=object_HM.arr_pdfs;
                object_PIVC.arr_FileName = object_HM.arr_pdf_name;
            [self.navigationController pushViewController:object_PIVC animated:YES];
            }
        });
    });
}

- (IBAction)actionSegmentcontrol:(UISegmentedControl*)sender
{
    self.btn_selected.backgroundColor = [UIColor clearColor];
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            arr_historyList = arr_referral;
            lbl_title.text = @"Referral History";
            break;
        case 1:
            arr_historyList = arr_setup;
            lbl_title.text = @"Setup History";
            break;
        default:
            break;
            
    }
    
    [table_historyView reloadData];
    [table_historyView setContentOffset:CGPointMake(0, 0)];
}

- (IBAction)action_headerButton:(UIButton*)sender
{
    dispatch_async(myqueue, ^{
        
   
       switch (sender.tag) {
        case 0:
               
            if (arr_TableSearchData.count>0)
               {
                 arr_TableSearchData = [self sortedDictionaryByNames:arr_TableSearchData :@"Pt_Last"];
               }
            else
                arr_historyList = [self sortedDictionaryByNames:arr_historyList :@"Pt_Last"];
            break;
        case 1:
               if (arr_TableSearchData.count>0)
               {
                   arr_TableSearchData = [self sortedDictionaryByNames:arr_TableSearchData :@"Pt_First"];
               }
            else
                arr_historyList = [self sortedDictionaryByNames:arr_historyList :@"Pt_First"];
            break;
        case 2:
               if (arr_TableSearchData.count>0)
               {
                   arr_TableSearchData = [self sortedDictionaryByNames:arr_TableSearchData :@"Ref_Date"];
               }
            else
                 arr_historyList = [self sortedDictionaryByNames:arr_historyList :@"Ref_Date"];
                break;
        case 3:
               if (arr_TableSearchData.count>0)
               {
                   arr_TableSearchData = [self sortedDictionaryByNames:arr_TableSearchData :@"Doctor"];
               }
            else
                arr_historyList = [self sortedDictionaryByNames:arr_historyList :@"Doctor"];
            break;
        case 4:
               if (arr_TableSearchData.count>0)
               {
                   arr_TableSearchData = [self sortedDictionaryByNames:arr_TableSearchData :@"Status"];
               }
           else
               arr_historyList = [self sortedDictionaryByNames:arr_historyList :@"Status"];
            break;
        case 5:
               if (arr_TableSearchData.count>0)
               {
                   arr_TableSearchData = [self sortedDictionaryByNames:arr_TableSearchData :@"Pri_Ins"];
               }
           else
                 arr_historyList = [self sortedDictionaryByNames:arr_historyList :@"Pri_Ins"];
            break;
        case 6:
               if (arr_TableSearchData.count>0)
               {
                   arr_TableSearchData = [self sortedDictionaryByNames:arr_TableSearchData :@"App_Date"];
               }
               else
                  arr_historyList = [self sortedDictionaryByNames:arr_historyList :@"App_Date"];
            break;
        case 7:
               if (arr_TableSearchData.count>0)
               {
                   arr_TableSearchData = [self sortedDictionaryByNames:arr_TableSearchData :@"Den_Date"];
               }
               else
                  arr_historyList = [self sortedDictionaryByNames:arr_historyList :@"Den_Date"];
                break;
        case 8:
               if (arr_TableSearchData.count>0)
               {
                   arr_TableSearchData = [self sortedDictionaryByNames:arr_TableSearchData :@"SU_Date"];
               }
            else
                  arr_historyList = [self sortedDictionaryByNames:arr_historyList :@"SU_Date"];
            break;
        default:
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.btn_selected.backgroundColor = [UIColor clearColor];
        self.btn_selected =sender;
        
        sender.backgroundColor =customDarkBlueColor();
        [table_historyView reloadData];
        
    });
         });
}


UIColor *customDarkBlueColor()
{
    return [UIColor colorWithRed:47.0/255.0 green:98.0/255.0 blue:136.0/255.0 alpha:1];
};

-(void)lastDatesMethod:(id)sender
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
