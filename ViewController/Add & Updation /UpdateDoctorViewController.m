//
//  UpdateDoctorViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 6/24/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "UpdateDoctorViewController.h"
#import "AppDelegate.h"
#import "AddDoctorModel.h"
#import "AddDoctorView.h"


#define ACCEPTABLE_CHARECTERS @"0123456789"

@interface UpdateDoctorViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int StoreTag;
    UITableViewController *tableViewController;
    UIPopoverController *popover_detaiList;
    UIViewController *controller_popover;
    NSArray *arr_dropdownlist, *arr_states, *arr_doctors;
    NSString *str_facilityId, *str_doctorId;
    UIDatePicker* datePicker;
    UIViewController *pickerController;
    UITextField *temp_textField;
    UITextView *temp_textView;
    NSDateFormatter *FormatDate;
    NSString *str_DoctorState;
    NSString *str_date;
    NSString *str_modemState ,*str_MDAccess;
  
    NSString *str_14, *str_25, *str_30, *str_45,*str_60, *str_90,*str_120;
    NSString *str_Modem_D , *str_MDAccess_D;
    NSString *str_14_D, *str_25_D, *str_30_D, *str_45_D,*str_60_D, *str_90_D,*str_120_D;
    
    NSMutableArray *arr_machine;
    NSMutableArray *arr_mask;
    NSMutableArray *arr_referrals;
    NSDictionary *dict_states;
    
    
    NSMutableArray *arr_referrals_D;
    NSMutableArray *arr_machine_D;
    NSMutableArray *arr_mask_D;
}
@property(nonatomic,weak)UISwitch *switch_temp;

@end

@implementation UpdateDoctorViewController

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
    scroll_Form.frame = CGRectMake(20, 90, 855, 500);
    [self.view addSubview:scroll_Form];
    [super viewDidLoad];
    arry_DoctorList = [[NSMutableArray alloc] init];
    arry_NameChnaged = [[NSMutableArray alloc] init];
    
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

    [self setCheckImage];
    [self showPopover];
    [self datePicker];
    [self getDoctorList];
    [self setupTextViewBorder];
    [self arrayAndStringInialization];
    [self facultyArr];
	// Do any additional setup after loading the view.

}
-(void)viewDidLayoutSubviews
{
    scroll_Form.contentSize = CGSizeMake(CGRectGetWidth(scroll_Form.frame), CGRectGetHeight(view_form.frame)-150);
    scroll_Form.minimumZoomScale = 0.5;
    scroll_Form.maximumZoomScale = 3;
    scroll_Form.layer.borderWidth=0.8;
    scroll_Form.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}
-(void)setupTextViewBorder
{
    txt_Nuance_Doc.layer.borderWidth = 1.0;
    txt_Nuance_Doc.layer.borderColor = [[UIColor blackColor] CGColor];
    txt_Nuance_Doc.backgroundColor = [UIColor whiteColor];
    
    txt_Nuance_Fac.layer.borderWidth = 1.0;
    txt_Nuance_Fac.layer.borderColor = [[UIColor blackColor] CGColor];
    txt_Nuance_Fac.backgroundColor = [UIColor whiteColor];
    
    txt_addNotes_Doc.layer.borderWidth = 1.0;
    txt_addNotes_Doc.layer.borderColor = [[UIColor blackColor] CGColor];
    txt_addNotes_Doc.backgroundColor = [UIColor whiteColor];
    
    txt_addNotes_Fac.layer.borderWidth = 1.0;
    txt_addNotes_Fac.layer.borderColor = [[UIColor blackColor] CGColor];
    txt_addNotes_Fac.backgroundColor = [UIColor whiteColor];
    
    txt_OtherInstructions_U.layer.borderWidth = 1.0;
    txt_OtherInstructions_U.layer.borderColor = [[UIColor blackColor] CGColor];
    txt_OtherInstructions_U.backgroundColor = [UIColor whiteColor];
    
    txt_OtherInstructions_D.layer.borderWidth = 1.0;
    txt_OtherInstructions_D.layer.borderColor = [[UIColor blackColor] CGColor];
    txt_OtherInstructions_D.backgroundColor = [UIColor whiteColor];
    
    
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
    str_doctorId = @"";
    str_facilityId = @"";
    
}

- (void)facultyArr {
    
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dic22 in [AppDelegate sharedInstance].arr_facilities) {
        
        NSLog(@"arr for facility:%@",[AppDelegate sharedInstance].arr_facilities);
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:dic22];
        NSString *strName = [dic objectForKey:@"fac_name"];
        
        NSString *sectionChar = strName.length ? [NSString stringWithFormat:@"%c",[[strName uppercaseString] characterAtIndex:0]] : @"#";
        
        [dic setObject:sectionChar forKey:@"SectionCharacter"];
        [temp addObject:dic];
    }
    
    arr_dropdownlist = [temp mutableCopy];
}
- (void)filter:(NSMutableArray *)tempArry {
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Dr_Last" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSArray *sortedArray = [tempArry sortedArrayUsingDescriptors:sortDescriptors];
    
    arry_NameChnaged  = [sortedArray mutableCopy];
    
    NSLog(@"filtered arry_NameChnaged:%@",arry_NameChnaged);
    
}
-(void)getDoctorList
{
    dispatch_queue_t docQueue = dispatch_queue_create("docQueue", 0);
    dispatch_async(docQueue, ^{
        
        AddDoctorView *object_new = [AddDoctorView new];
        NSDictionary *dict =   [object_new getAllDoctors:[AppDelegate sharedInstance].rep_patientID];
        
        NSLog(@"response dict:%@",dict);
        
        
        [arry_DoctorList addObjectsFromArray:[dict valueForKey:@"listing"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            if(dict)
            {
                AddDoctorModel *object_model = [AddDoctorModel allDoctorsFromDictionary:dict];
                arr_doctors = object_model.arr_Doctors;
                
                for (NSDictionary *dic22 in arry_DoctorList) {
                    
                    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:dic22];
                    NSString *strName = [dic objectForKey:@"Dr_Last"];
                    
                    NSString *sectionChar = strName.length ? [NSString stringWithFormat:@"%c",[[strName uppercaseString] characterAtIndex:0]] : @"#";
                    
                    [dic setObject:sectionChar forKey:@"SectionCharacter"];
                    
                    [arry_NameChnaged addObject:dic];
                                   }
                
                [self filter:arry_NameChnaged];
            }
        });
    });
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
}

- (IBAction)showDatePicker:(UIButton*)sender
{
     popover_detaiList = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    [popover_detaiList presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [self dateGetChanged];
}

- (void)dateGetChanged
{
    
    //format date
    NSDateFormatter *FormatDate1 = [[NSDateFormatter alloc] init];
    [FormatDate1 setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    
    //set date format
    [FormatDate1 setDateFormat:@"MM/dd/YYYY"];
    
    //update date textfield
   str_date= [FormatDate1 stringFromDate:[datePicker date]];
   lbl_date.text = str_date;
  
}
- (IBAction)checkBox_referralTypesFirst:(UIButton*)sender
{
    sender.selected = !sender.selected;
    switch (sender.tag) {
        case 1:
            if (sender.selected) {
                [arr_referrals addObject:@"HST"];
            }
            else [arr_referrals removeObject:@"HST"];
            
            break;
        case 2:
            if (sender.selected) {
                [arr_referrals addObject:@"Traditional"];
            }
            else [arr_referrals removeObject:@"Traditional"];
            
            break;
        case 3:
            if (sender.selected) {
                txt_Other_Referral_U.placeholder = @"Enter text....";
                txt_Other_Referral_U.userInteractionEnabled = YES;
            }
            else
            {
                txt_Other_Referral_U.text = @"";
                txt_Other_Referral_U.placeholder = @"";
                txt_Other_Referral_U.userInteractionEnabled = NO;
            }
            break;
        default:
            break;
    }

}

-(NSArray *)sectionsWithArray:(NSMutableArray *)arrData
{
    NSArray *arr = [arrData valueForKeyPath:@"@distinctUnionOfObjects.Dr_First"];
    
    return [arr sortedArrayUsingSelector:@selector(compare:)];
}

-(NSArray *) sectionsInArray2:(NSArray *)array
{
    NSLog (@"sorted arry:%@",[[array valueForKeyPath:@"@distinctUnionOfObjects.SectionCharacter"] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
    
    return [[array valueForKeyPath:@"@distinctUnionOfObjects.SectionCharacter"] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(NSArray *) sectionsInArray:(NSArray *)array
{
    
    return [[array valueForKeyPath:@"@distinctUnionOfObjects.SectionCharacter"] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *titleStr = nil;
    
    if (StoreTag == 1) {
        
        titleStr =  [[self sectionsInArray:arry_NameChnaged] objectAtIndex:section];
        
        //[[self sectionsWithArray:arrTableData] objectAtIndex:section];
    }
    
    else if (StoreTag == 3) {
        
        NSLog(@"arr_dropdownlist:%@",arr_dropdownlist);
        titleStr =  [[self sectionsInArray2:arr_dropdownlist] objectAtIndex:section];
        
        NSLog(@"title sectionnnnnnnn:%@",[[self sectionsInArray2:arr_dropdownlist] objectAtIndex:section]);
    }
    else {
        titleStr = nil;
    }
    return titleStr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int cout = 0;
    
    if (StoreTag == 1) {
        
        //cout = [[self sectionsWithArray:arrTableData] count];
        cout = [[self sectionsInArray:arry_NameChnaged] count];
        //cout = [[self filter:arry_NameChnaged] count];
    }
    else if (StoreTag == 3) {
        
        [self facultyArr];
        cout = [[self sectionsInArray2:arr_dropdownlist] count];
    }
    else {
        cout = 1;
    }
    return cout;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int countt = 0;
    if (StoreTag == 1) {
        
        NSString *strChar = [[self sectionsInArray:arry_NameChnaged] objectAtIndex:section];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SectionCharacter beginswith [cd] %@",strChar];
        countt = [[arry_NameChnaged filteredArrayUsingPredicate:predicate] count];
    }
    else if (StoreTag == 3) {
        
        NSString *strChar = [[self sectionsInArray:arr_dropdownlist] objectAtIndex:section];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SectionCharacter beginswith [cd] %@",strChar];
        countt = [[arr_dropdownlist filteredArrayUsingPredicate:predicate] count];
        //countt = [arr_dropdownlist count];
    }
    else {
        if(StoreTag==2 || StoreTag == 4)
            
            countt = dict_states.count;
    }
        return countt;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"popover"];
    if(!cell) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"popover"];
    if(StoreTag == 2 || StoreTag == 4)
    {
        
        cell.textLabel.text = dict_states[arr_states[indexPath.row]];
    }
    else if(StoreTag == 3)
    {
        //NSDictionary *dict = arr_dropdownlist[indexPath.row];
        
        NSString *strChar = [[self sectionsInArray:arr_dropdownlist] objectAtIndex:indexPath.section];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SectionCharacter beginswith [cd] %@",strChar];
        NSArray* filteredArry= [arr_dropdownlist filteredArrayUsingPredicate:predicate];
        NSDictionary *dictt = [filteredArry objectAtIndex:indexPath.row];
        
       //cell.textLabel.text = dictt[@"fac_full_name"];fac_name
        
        cell.textLabel.text = dictt[@"fac_full_name"];
        
        NSLog(@"cell.textLabel.textttttyyyryryrryryr:%@",cell.textLabel.text);
    //    cell.textLabel.font=[UIFont systemFontOfSize:14];
      //  NSLog(@"cellText:%@",cell.textLabel.text);
    }
    else if (StoreTag == 1)
    {
        
        NSString *strChar = [[self sectionsInArray:arry_NameChnaged] objectAtIndex:indexPath.section];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SectionCharacter beginswith [cd] %@",strChar];
        NSArray* filteredArry= [arry_NameChnaged filteredArrayUsingPredicate:predicate];
        NSDictionary *dict = [filteredArry objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@, %@ %@",dict[@"Dr_Last"],dict[@"Dr_First"],dict[@"Dr_Middle"]];
        //  NSLog(@"cellText:%@",cell.textLabel.text);
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(StoreTag == 1)
    {//Dr_ID
          //NSDictionary *dict = arry_NameChnaged[indexPath.row];
        
        NSInteger rowNumber = 0;
        
        for (NSInteger i = 0; i < indexPath.section; i++) {
            rowNumber += [self tableView:tableView numberOfRowsInSection:i];
        }
        
        rowNumber += indexPath.row;
        
        NSLog (@"rowNumber ddddddddddddddddddddd:%d",rowNumber);

        NSDictionary *dict = [arry_NameChnaged objectAtIndex:rowNumber];
        NSLog(@"indexPath sectionnnnnnnnnnnnnnnn:%d",indexPath.row);
        NSLog(@"selected dictdtaaaaaaaaaaaaasassa:%@",dict);
        NSLog(@"arry_NameChnaged*************************:%@",arry_NameChnaged);
        
        txt_selectDoctorname.text = (![dict[@"Dr_Middle"] isEqualToString:@""]) ?[NSString stringWithFormat:@"%@ %@ %@",dict[@"Dr_First"],dict[@"Dr_Middle"],dict[@"Dr_Last"]]:[NSString stringWithFormat:@"%@ %@",dict[@"Dr_First"],dict[@"Dr_Last"]];
        str_doctorId = dict[@"Dr_ID"];
        dispatch_queue_t selectRowQueue = dispatch_queue_create("slectedRow", 0);
        dispatch_async(selectRowQueue, ^{
            AddDoctorView *object_view = [AddDoctorView new];
            NSDictionary *dict1 = [object_view getDoctorDetailForId:str_doctorId];
            AddDoctorModel *object_model = [AddDoctorModel doctorsDetailFromDictionary:dict1];
            NSArray *arr = object_model.arr_doctorDetail;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AppDelegate sharedInstance] removeCustomLoader];
                if(arr)
                {
                [self showDoctorDetailInTextField:arr[0]];
                    
                }
                
            });
        });
      
        [[AppDelegate sharedInstance] showCustomLoader:self];
      
    }
   else if (StoreTag==2) {
        lbl_selectStateDoc.text = dict_states[arr_states[indexPath.row]];
       str_DoctorState = arr_states[indexPath.row];
        
    }
    else if (StoreTag==4)
    {
        lbl_selectStatefac.text = dict_states[arr_states[indexPath.row]];
        
        str_facilityState =arr_states[indexPath.row];
        
    }
    else if (StoreTag==3)
    {
        NSInteger rowNumber = 0;
        
        for (NSInteger i = 0; i < indexPath.section; i++) {
            rowNumber += [self tableView:tableView numberOfRowsInSection:i];
        }
        
        rowNumber += indexPath.row;
        
         NSLog(@"arr_dropdownlistDidSelect:%@",arr_dropdownlist);
        NSDictionary *dict = [arr_dropdownlist objectAtIndex:rowNumber];

        NSLog (@"rowNumber ddddddddddddddddddddd:%d",rowNumber);
        
        NSLog(@"indexPath sectionnnnnnnnnnnnnnnn:%d",indexPath.row);
        NSLog(@"selected dictdtaaaaaaaaaaaaasassa:%@",dict);
        NSLog(@"arr_dropdownlist*************************:%@",arr_dropdownlist);

        //NSDictionary *dict = arr_dropdownlist[indexPath.row];
        
        str_facilityId =dict[@"fac_id"];
        txt_SelectFacility.text = dict[@"fac_name"];
        
        dispatch_queue_t selectRowQueue = dispatch_queue_create("slectedRow", 0);
        dispatch_async(selectRowQueue, ^{
            
            AddDoctorView *object_view = [AddDoctorView new];
            NSDictionary *dict1 = [object_view getFacilityDetailForId:str_facilityId];
            AddDoctorModel *object_model = [AddDoctorModel facilitieDetailFromDictionary:dict1];
            NSArray *arr = object_model.arr_facilityDetail;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AppDelegate sharedInstance] removeCustomLoader];
                if(arr)
                {
                    [self showDetailsForFacilityFromDictionary:arr[0]];
                    
                }
                
            });
        });
        
        [[AppDelegate sharedInstance] showCustomLoader:self.tabBarController];
            }
    [popover_detaiList dismissPopoverAnimated:FALSE];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self sectionsInArray:arry_NameChnaged];
}


-(void)showDoctorDetailInTextField:(NSDictionary*)dict
{
    txt_NPI.text = dict[@"Dr_NPI"];
    txt_licence.text = dict[@"Dr_License"];
    txt_firstName.text =dict[@"Dr_First"];
    txt_middleName.text = dict[@"Dr_Middle"];
    txt_lastName.text = dict[@"Dr_Last"];
    txt_Phone.text = dict[@"Dr_Phone"];
    txt_ConfFax.text = dict[@"Conf_Fax"];
    txt_addNotes_Doc.text = dict[@"dr_notes"];
    txt_address_Doctor.text = dict[@"Dr_Address"];
    txt_Nuance_Doc.text = dict[@"Dr_Nuance"];
    txt_city_Doc.text = dict[@"Dr_City"];
    lbl_selectStateDoc.text = (![dict[@"Dr_State"] isEqualToString:@""])? dict[@"Dr_State"] : @"Select State";
    str_DoctorState=(![dict[@"Dr_State"] isEqualToString:@""])? dict[@"Dr_State"] : @"";
    txt_UPIN.text = dict[@"Dr_UPIN"];
    txt_Zip_Doc.text = dict[@"Dr_Zip"];
    txt_DocContact.text = dict[@"doctor_office_contact"];
    btn_other_Referral_U.selected = (dict[@"dr_other_text"])?YES : NO;
    txt_Other_Referral_U.text= (dict[@"dr_other_text"])? dict[@"dr_other_text"]:@"";
    btn_Modem_Y_U.selected = (![dict[@"Dr_Reg_Encore"] isEqualToString:@""])?[dict[@"Dr_Reg_Encore"] intValue]:NO;
    btn_Modem_N_U.selected = (![dict[@"Dr_Reg_Encore"] isEqualToString:@""])? !btn_Modem_Y_U.selected: NO;
    str_modemState = [NSString stringWithFormat:@"%@",dict[@"Dr_Reg_Encore"]];
    btn_MD_Y_U.selected = (![dict[@"Dr_Req_Encore"]isEqualToString:@""])?[dict[@"Dr_Req_Encore"] intValue]:NO;
    btn_MD_N_U.selected = (![dict[@"Dr_Req_Encore"]isEqualToString:@""])?!btn_MD_Y_U.selected :NO;
    str_MDAccess = [NSString stringWithFormat:@"%@",dict[@"Dr_Req_Encore"]];
    btn_14Days_U.selected = [dict[@"Dr_SC_14"] intValue];
    str_14 =[NSString stringWithFormat:@"%@",dict[@"Dr_SC_14"]];
    btn_25Days_U.selected = [dict[@"Dr_SC_25"] intValue];
    str_25 =[NSString stringWithFormat:@"%@",dict[@"Dr_SC_25"]];
    btn_30Days_U.selected = [dict[@"Dr_SC_30"] intValue];
    str_30 =[NSString stringWithFormat:@"%@",dict[@"Dr_SC_30"]];
    btn_45Days_U.selected = [dict[@"Dr_SC_45"] intValue];
    str_45 =[NSString stringWithFormat:@"%@",dict[@"Dr_SC_45"]];
    btn_60Days_U.selected = [dict[@"Dr_SC_60"] intValue];
    str_60 =[NSString stringWithFormat:@"%@",dict[@"Dr_SC_60"]];
    btn_90Days_U.selected = [dict[@"Dr_SC_90"] intValue];
    str_90 =[NSString stringWithFormat:@"%@",dict[@"Dr_SC_90"]];
    btn_OnceYear_U.selected = [dict[@"Dr_SC_120"] intValue];
    str_120 =[NSString stringWithFormat:@"%@",dict[@"Dr_SC_120"]];
  
}
-(void)showDetailsForFacilityFromDictionary:(NSDictionary*)dict
{
    txt_faciltyName.text = dict[@"fac_full_name"];
    txt_faciltyNickName.text = dict[@"fac_name"];
    txt_address_Facility.text = dict[@"fac_address"];
    txt_city_Facility.text = dict[@"fac_city"];
    lbl_selectStatefac.text = (![dict[@"fac_state"] isEqualToString:@""])? dict[@"fac_state"] : @"Select State";
    str_facilityState = (![dict[@"fac_state"] isEqualToString:@""])? dict[@"fac_state"] : @"";
    txt_Zip_Facility.text = dict[@"fac_zip"];
    txt_faciltyPhone.text = dict[@"fac_phone"];
    txt_faciltyContact.text = dict[@"facility_office_contact"];
    txt_Nuance_Fac.text = dict[@"fac_nuance"];
    btn_Modem_Y_D.selected = (![dict[@"fac_reg_encore"] isEqualToString:@""])?[dict[@"fac_reg_encore"] intValue]:NO;
    btn_Modem_N_D.selected = (![dict[@"fac_reg_encore"] isEqualToString:@""])?!btn_Modem_Y_D.selected:NO;
    str_Modem_D = [NSString stringWithFormat:@"%@",dict[@"fac_reg_encore"]];
    btn_MD_Y_D.selected = (![dict[@"fac_encore"] isEqualToString:@""])?[dict[@"fac_encore"] intValue]:NO;
    btn_MD_N_D.selected = (![dict[@"fac_encore"] isEqualToString:@""])?!btn_MD_Y_D.selected:NO;
    str_MDAccess_D = [NSString stringWithFormat:@"%@",dict[@"fac_encore"]];
    btn_14Days_D.selected = [dict[@"fac_sc_14"] intValue];
    str_14_D =[NSString stringWithFormat:@"%@",dict[@"fac_sc_25"]];
    btn_25Days_D.selected = [dict[@"fac_sc_25"] intValue];
    str_25_D =[NSString stringWithFormat:@"%@",dict[@"fac_sc_25"]];
    btn_30Days_D.selected = [dict[@"fac_sc_30"] intValue];
    str_30_D =[NSString stringWithFormat:@"%@",dict[@"fac_sc_30"]];
    btn_45Days_D.selected = [dict[@"Dr_SC_45"] intValue];
    str_45_D =[NSString stringWithFormat:@"%@",dict[@"Dr_SC_45"]];
    btn_60Days_D.selected = [dict[@"fac_sc_60"] intValue];
    str_60_D =[NSString stringWithFormat:@"%@",dict[@"fac_sc_60"]];
    btn_90Days_D.selected = [dict[@"fac_sc_90"] intValue];
    str_90_D =[NSString stringWithFormat:@"%@",dict[@"fac_sc_90"]];
    btn_OnceYear_D.selected = [dict[@"fac_sc_120"] intValue];
    str_120_D =[NSString stringWithFormat:@"%@",dict[@"fac_sc_120"]];
    
}

-(void)clearTextfields
{
    if(StoreTag==2)
    {
        lbl_selectStateDoc.text = @"Select State";
    }
    else if(StoreTag==4)
    {
        lbl_selectStatefac.text = @"Select State";
    }
    else
    {
        txt_SelectFacility.text = @"";
        txt_SelectFacility.placeholder = @"Select a facility";
    }
    [popover_detaiList dismissPopoverAnimated:YES];
}
- (IBAction)action_SwitchCondition:(UISwitch*)sender
{
    if(sender.tag != self.switch_temp.tag) self.switch_temp.on = NO;
    self.switch_temp = sender;
    if (sender.tag==0) {
        if(sender.on)
        {
            view_DoctorInfoGrayedOut.hidden = YES;
            
            view_FacilityGrayedOut.hidden = NO;
        }
        else
        {
            view_DoctorInfoGrayedOut.hidden = NO;
          
            view_FacilityGrayedOut.hidden = NO;
            
        }
        [self animateScrollFormWithOriginY:0];
    }
    else if (sender.tag==1)
    {
        if(sender.on)
        {
            view_DoctorInfoGrayedOut.hidden = YES;
            view_FacilityGrayedOut.hidden = YES;
        }
        else
        {
            view_DoctorInfoGrayedOut.hidden = NO;
            view_FacilityGrayedOut.hidden = NO;
        }
        [self animateScrollFormWithOriginY:0];
    }
    else if (sender.tag==2)
    {
        if(sender.on)
        {
            view_DoctorInfoGrayedOut.hidden = NO;
            view_FacilityGrayedOut.hidden = YES;
        }
        else
        {
            view_DoctorInfoGrayedOut.hidden = NO;
            view_FacilityGrayedOut.hidden = NO;
        }
        [self animateScrollFormWithOriginY:1670];
    }
   }

-(IBAction)showPop:(UIButton *)sender
{
    [temp_textField resignFirstResponder];
    [temp_textView resignFirstResponder];
     popover_detaiList = [[UIPopoverController alloc] initWithContentViewController:controller_popover];
    StoreTag = sender.tag;
    tableViewController.tableView.contentOffset=CGPointMake(0, 0);
    
    //   selectListNumber =sender.tag;
    if(sender.tag==2)
        {
            [self animateScrollFormWithOriginY:690];
        }
        else if (sender.tag==4)
        {
            [self animateScrollFormWithOriginY:2050];
        }
   
   else if(sender.tag == 1)
    {
                arr_dropdownlist = arr_doctors;
    }
    else
    {
        [self animateScrollFormWithOriginY:1662];
        arr_dropdownlist = [[AppDelegate sharedInstance] arr_facilities];
    }
    
     [popover_detaiList setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    [popover_detaiList presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [tableViewController.tableView reloadData];
}

- (IBAction)CheckBoxes_MachinePrefrencesFirst:(UIButton*)sender
{
    sender.selected = !sender.selected;
    switch (sender.tag) {
        case 1:
            if (sender.selected) {
                [arr_machine addObject:@"No Preference"];
            }
            else [arr_machine removeObject:@"No Preference"];
            
            break;
        case 2:
            if (sender.selected) {
                [arr_machine addObject:@"Respironics"];
            }
            else [arr_machine removeObject:@"Respironics"];
            
            break;
        case 3:
            if (sender.selected) {
                [arr_machine addObject:@"ResMed"];
            }
            else [arr_machine removeObject:@"ResMed"];
            
            break;
        case 4:
            if (sender.selected) {
                [arr_machine addObject:@"Fisher/Paykel"];
            }
            else [arr_machine removeObject:@"Fisher/Paykel"];
            
            break;
        case 5:
            if (sender.selected) {
                txt_Other_Machine_U.userInteractionEnabled=YES;
                txt_Other_Machine_U.placeholder = @"Enter Text....";
            }
            else
            {
                txt_Other_Machine_U.userInteractionEnabled=NO;
                txt_Other_Machine_U.placeholder = @"";
                txt_Other_Machine_U.text = @"";
                
            }
            break;
            
        default:
            break;
    }
}

- (IBAction)checkBoxes_MaskPrefrencesFirst:(UIButton*)sender
{
    sender.selected = !sender.selected;
    
    switch (sender.tag) {
        case 1:
            if (sender.selected) {
                [arr_mask addObject:@"Ft to Pt.Comfort"];
            }
            else [arr_mask removeObject:@"Ft to Pt.Comfort"];
            
            break;
        case 2:
            if (sender.selected) {
                [arr_mask addObject:@"Follow Script"];
            }
            else [arr_mask removeObject:@"Follow Script"];
            
            break;
        case 3:
            if (sender.selected) {
                [arr_mask addObject:@"Respironics"];
            }
            else [arr_mask removeObject:@"Respironics"];
            
            break;
        case 4:
            if (sender.selected) {
                [arr_mask addObject:@"Fisher/Paykel"];
            }
            else [arr_mask removeObject:@"Fisher/Paykel"];
            
            break;
        case 5:
            if (sender.selected) {
                txt_Other_Mask_U.userInteractionEnabled = YES;
                txt_Other_Mask_U.placeholder = @"Enter Text....";
            }
            else
            {
                txt_Other_Mask_U.text = @"";
                txt_Other_Mask_U.userInteractionEnabled = NO;
                txt_Other_Mask_U.placeholder = @"";
            }
            break;
        default:
            break;
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

- (IBAction)checkBoxes_ModemFirst:(UIButton*)sender
{
    NSLog(@"tag:%d",[sender tag]);
    
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (sender.tag==1) {
        
        if (btn_Modem_Y_U.selected) {
            btn_Modem_N_U.selected = NO;
            
            btn_MD_Y_U.userInteractionEnabled = YES;
            btn_MD_N_U.userInteractionEnabled =YES;
            btn_MD_Y_U.selected = NO;
            btn_MD_N_U.selected = NO;
            btn_MD_Y_U.enabled = YES;
            btn_MD_N_U.enabled = YES;
            [self ButtonState:[sender tag]];
            str_30=@"1";
            str_90=@"1";
            str_MDAccess = @"";
            str_modemState = @"1";
            
        }
        else
        {
            [self ButtonState:[sender tag]];
        }
    }
    
    if (sender.tag==2)
    {
        NSLog(@"tag:%d",[sender tag]);
        btn_Modem_Y_U.selected = NO;
        btn_MD_Y_U.enabled = NO;
        btn_MD_N_U.enabled = NO;
        str_modemState = @"0";
        str_MDAccess = @"";
        str_30=@"0";
        str_90=@"0";
        [self ButtonState:[sender tag]];
    }
    else
    {
        [self ButtonState:[sender tag]];
    }
}
-(void)ButtonState:(int)tag
{
    if(btn_Modem_Y_U.selected )
    {
        [btn_30Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [btn_90Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];}
    else if (tag == 2)
    {
        [btn_30Days_U setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [btn_90Days_U setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btn_30Days_U setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [btn_90Days_U setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)checkBoxes_MDAcessFirst:(UIButton*)sender
{
    sender.selected = !sender.selected;
    switch (sender.tag)
    {
        case 1:
            btn_MD_N_U.selected = NO;
            str_MDAccess = @"1";
            break;
        case 2:
            btn_MD_Y_U.selected = NO;
            str_MDAccess = @"0";
            break;
        default:
            break;
    }
}

- (IBAction)checkBoxes_downloads:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if(sender.selected)
    {
        switch (sender.tag)
        {
            case 1:
                str_14 = @"1";
                break;
            case 2:
                str_25 = @"1";
                break;
            case 3:
                str_30 = @"1";
                break;
            case 4:
                str_45 = @"1";
                break;
            case 5:
                str_60 = @"1";
                break;
            case 6:
                str_90 = @"1";
                break;
            case 7:
                str_120 = @"1";
                break;
            default:
                break;
        }
    }
    else
    {
        switch (sender.tag)
        {
            case 1:
                str_14 = @"0";
                break;
            case 2:
                str_25 = @"0";
                break;
            case 3:
                str_30 = @"0";
                break;
            case 4:
                str_45 = @"0";
                break;
            case 5:
                str_60 = @"0";
                break;
            case 6:
                str_90 = @"0";
                break;
            case 7:
                str_120 = @"0";
                break;
            default:
                break;
        }
    }
}
- (IBAction)checkBoxes_ReferralTypeSecond:(UIButton*)sender
{
    sender.selected = !sender.selected;
    switch (sender.tag) {
        case 1:
            if (sender.selected)
            {
                [arr_referrals_D addObject:@"HST"];
            }
            else
                [arr_referrals_D removeObject:@"HST"];
            break;
        case 2:
            if (sender.selected)
            {
                [arr_referrals_D addObject:@"Traditional"];
            }
            else
                [arr_referrals_D removeObject:@"Traditional"];
            break;
        case 3:
            if (sender.selected)
            {
                txt_Other_Referral_D.userInteractionEnabled = YES;
                txt_Other_Referral_D.placeholder = @"Enter Text....";
            }
            else
            {
                txt_Other_Referral_D.userInteractionEnabled = NO;
                txt_Other_Referral_D.placeholder = @"";
                txt_Other_Referral_D.text = @"";
            }
            break;
        default:
            break;
    }
}

- (IBAction)checkBoxes_MachinePreferencesSecond:(UIButton*)sender
{
    sender.selected = !sender.selected;
    switch (sender.tag)
    {
        case 1:
        if (sender.selected)
            {
                [arr_machine_D addObject:@"No Preferences"];
            }
        else
                [arr_machine_D removeObject:@"No Preferences"];
            break;
        case 2:
            if (sender.selected)
            {
                [arr_machine_D addObject:@"Respironics"];
            }
         else
                [arr_machine_D removeObject:@"Respironics"];
            break;
        case 3:
            if (sender.selected)
            {
                [arr_machine_D addObject:@"ResMed"];
            }
            else
              [arr_machine_D removeObject:@"ResMed"];
            break;
        case 4:
            if (sender.selected)
            {
                 [arr_machine_D addObject:@"Fisher/Paykel"];
            }
            else
              [arr_machine_D removeObject:@"Fisher/Paykel"];
            break;

        case 5:
            if (sender.selected)
            {
                txt_Other_Machine_D.userInteractionEnabled = YES;
                txt_Other_Machine_D.placeholder = @"Enter Text....";
            }
            else
            {
                txt_Other_Machine_D.userInteractionEnabled = NO;
                txt_Other_Machine_D.placeholder = @"";
                txt_Other_Machine_D.text = @"";
            }
            break;
        default:
            break;
    }
}

- (IBAction)checkBoxes_MaskPreferenceSecond:(UIButton*)sender
{
    sender.selected = !sender.selected;
    switch (sender.tag)
    {
        case 1:
            if (sender.selected)
            {
                [arr_mask_D addObject:@"Ft to Pt.Comfort"];
            }
            else
                [arr_mask_D removeObject:@"Ft to Pt.Comfort"];
            break;
        case 2:
            if (sender.selected)
            {
                [arr_mask_D addObject:@"FollowScript"];
            }
            else
                [arr_mask_D removeObject:@"FollowScript"];
            break;
        case 3:
            if (sender.selected)
            {
                [arr_mask_D addObject:@"Respironics"];
            }
            else
                [arr_mask_D removeObject:@"Respironics"];
            break;
        case 4:
            if (sender.selected)
            {
                [arr_mask_D addObject:@"Fisher/Paykel"];
            }
            else
                [arr_mask_D removeObject:@"Fisher/Paykel"];
            break;
            
        case 5:
            if (sender.selected)
            {
                txt_Other_Mask_D.userInteractionEnabled = YES;
                txt_Other_Mask_D.placeholder = @"Enter Text....";
            }
            else
            {
                txt_Other_Mask_D.text = @"";
                txt_Other_Mask_D.userInteractionEnabled = NO;
                txt_Other_Mask_D.placeholder = @"";
            }
            break;
        default:
            break;
    }

}

- (IBAction)checkBoxes_ModemSecond:(UIButton *)sender
{
    NSLog(@"tag:%d",[sender tag]);
    
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (sender.tag==1111)
    {
        
        if (btn_Modem_Y_D.selected)
        {
            btn_Modem_N_D.selected = NO;
            btn_MD_Y_D.userInteractionEnabled = YES;
            btn_MD_N_D.userInteractionEnabled =YES;
            btn_MD_Y_D.selected = NO;
            btn_MD_N_D.selected = NO;
            btn_MD_Y_D.enabled = YES;
            btn_MD_N_D.enabled = YES;
            [self DownState:[sender tag]];
            str_30_D=@"1";
            str_90_D=@"1";
            str_MDAccess_D = @"";
            str_modemState= @"1";
            
        }
        else
        {
            [self DownState:[sender tag]];
        }
       }
    
    if (sender.tag==2222)
    {
        NSLog(@"tag:%d",[sender tag]);
        btn_Modem_Y_D.selected = NO;
        
        btn_MD_Y_D.enabled = NO;
        btn_MD_N_D.enabled = NO;
        str_modemState = @"0";
        str_MDAccess_D = @"";
        str_30_D=@"0";
        str_90_D=@"0";
        [self DownState:[sender tag]];
    }
   else
    {
        [self DownState:[sender tag]];
    }
}

-(void)DownState:(int)tag
{
    if(btn_Modem_Y_D.selected )
    {
        [btn_30Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [btn_90Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];}
    else if (tag == 2222)
    {
        [btn_30Days_D setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [btn_90Days_D setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    else {
        [btn_30Days_D setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [btn_90Days_D setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)checkBoxes_MDAcessSecond:(UIButton*)sender
{
    sender.selected = !sender.selected;
    switch (sender.tag)
    {
        case 1:
            btn_MD_N_D.selected = NO;
             str_MDAccess_D = @"1";
            break;
        case 2:
            btn_MD_Y_D.selected = NO;
             str_MDAccess_D = @"0";
            break;
        default:
            break;
    }
}

- (IBAction)checkBoxes_DownloadsSecond:(UIButton*)sender
{
   
    sender.selected = !sender.selected;
    if(sender.selected)
    {
        switch (sender.tag)
        {
            case 1:
                str_14_D = @"1";
                break;
            case 2:
                str_25_D = @"1";
                break;
            case 3:
                str_30_D = @"1";
                break;
            case 4:
                str_45_D = @"1";
                break;
            case 5:
                str_60_D= @"1";
                break;
            case 6:
                str_90_D = @"1";
                break;
            case 7:
                str_120_D = @"1";
                break;
            default:
                break;
        }
    }
    else
    {
        switch (sender.tag)
        {
            case 1:
                str_14_D = @"0";
                break;
            case 2:
                str_25_D = @"0";
                break;
            case 3:
                str_30_D = @"0";
                break;
            case 4:
                str_45_D = @"0";
                break;
            case 5:
                str_60_D= @"0";
                break;
            case 6:
                str_90_D = @"0";
                break;
            case 7:
                str_120_D = @"0";
                break;
            default:
                break;
        }
    }
}

- (IBAction)update:(UIButton*)sender
{
    
    if(!view_DoctorInfoGrayedOut.hidden&&!view_FacilityGrayedOut.hidden)
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please on a switch for updating"];
        return;
    }
    
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

    if (_switch_temp.tag == 0)
    {
       // if([self checkValidateFieldForUpdateNewdoctor]) return;
        
        dispatch_queue_t addQueue = dispatch_queue_create("addNew", 0);
        dispatch_async(addQueue, ^{
            
            AddDoctorView *object_view = [AddDoctorView new];
            
            NSDictionary *dict = [object_view addNewDoctorWithId:[AppDelegate sharedInstance].rep_patientID FirstName:txt_firstName.text MiddleName:txt_middleName.text LastName:txt_lastName.text NPI:txt_NPI.text License:txt_licence.text Phone:txt_Phone.text Confax:txt_ConfFax.text DrContact:txt_DocContact.text Address:txt_address_Doctor.text City:txt_city_Doc.text State:str_DoctorState Zip:txt_Zip_Doc.text Upin:txt_UPIN.text Nuance:txt_Nuance_Doc.text Notes:txt_addNotes_Doc.text DoctorFacilityID:@"" ReferralType:str_ReferralType ReferralOtherType:txt_Other_Referral_U.text DrMachinePref:str_machine DrMachineOtherPref:txt_Other_Machine_U.text DrMaskPref:str_mask DrMaskOtherPref:txt_Other_Mask_U.text DrModem:str_modemState DrEasyModeCare:str_MDAccess Dr14:str_14 Dr25:str_25 Dr30:str_30 Dr45:str_45 Dr60:str_60 Dr90:str_90 Dr120:str_120 DrOtherIns:txt_OtherInstructions_U.text CurrentDate:str_date DrID:str_doctorId];
            [self getStateForAddingDoctorFromResponse:dict forSource:0];
        });
        [[AppDelegate sharedInstance] showCustomLoader:self];
        
    }
    else if (_switch_temp.tag == 1)
    {
       // if([self checkValidationForBothNew]) return;
        
               dispatch_queue_t addQueue = dispatch_queue_create("addNew", 0);
        dispatch_async(addQueue, ^{
            
            AddDoctorView *object_view = [AddDoctorView new];
            NSDictionary *dict = [object_view addNewDoctorAndNewFacilityWithId:[AppDelegate sharedInstance].rep_patientID FirstName:txt_firstName.text MiddleName:txt_middleName.text LastName:txt_lastName.text NPI:txt_NPI.text License:txt_licence.text Phone:txt_Phone.text Confax:txt_ConfFax.text DrContact:txt_DocContact.text Address:txt_address_Doctor.text City:txt_city_Doc.text State:str_DoctorState Zip:txt_Zip_Doc.text Upin:txt_UPIN.text Nuance:txt_Nuance_Doc.text Notes:txt_addNotes_Doc.text ReferralType:str_ReferralType ReferralOtherType:txt_Other_Referral_U.text DrMachinePref:str_machine DrMachineOtherPref:txt_Other_Machine_U.text DrMaskPref:str_mask DrMaskOtherPref:txt_Other_Mask_U.text DrModem:str_modemState DrEasyModeCare:str_MDAccess Dr14:str_14 Dr25:str_25 Dr30:str_30 Dr45:str_45 Dr60:str_60 Dr90:str_90 Dr120:str_120 DrOtherIns:txt_OtherInstructions_U.text CurrentDate:lbl_date.text FacNickName:txt_faciltyNickName.text FacName:txt_faciltyName.text FacPhone:txt_faciltyPhone.text Contact:txt_faciltyContact.text Address:txt_address_Facility.text City:txt_city_Facility.text State:str_facilityState Zip:txt_Zip_Facility.text Nuance:txt_Nuance_Fac.text Notes:txt_addNotes_Fac.text FacReferralType:str_referrals_D FacReferralOther:txt_Other_Referral_D.text FacMachineType:str_machine_D FacMachineOther:txt_Other_Machine_D.text FacMaskType:str_mask_D facMaskOther:txt_Other_Mask_D.text FacModem:str_Modem_D FacMDAccess:str_MDAccess_D Fac14:str_14_D Fac25:str_25_D Fac30:str_30_D Fac45:str_45_D Fac60:str_60_D Fac90:str_90_D Fac120:str_120_D FacOtherIns:txt_OtherInstructions_D.text DrId:str_doctorId FacilityId:str_facilityId];
            [self getStateForAddingDoctorFromResponse:dict forSource:1];
        });
        [[AppDelegate sharedInstance] showCustomLoader:self];
    }
    else if (_switch_temp.tag == 2)
    {
     //   if([self checkValidationUpdateNewFacility]) return;
        
        dispatch_queue_t addQueue = dispatch_queue_create("addNew", 0);
        dispatch_async(addQueue, ^{
            
            AddDoctorView *object_view = [AddDoctorView new];
            NSDictionary *dict = [object_view addNewFacilityWithId:[AppDelegate sharedInstance].rep_patientID FacNickNaem:txt_faciltyNickName.text FacName:txt_faciltyName.text FacPhone:txt_faciltyPhone.text Contact:txt_faciltyContact.text Address:txt_address_Facility.text City:txt_city_Facility.text State:str_facilityState Zip:txt_Zip_Facility.text Nuance:txt_Nuance_Fac.text Notes:txt_addNotes_Fac.text FacReferralType:str_referrals_D FacReferralOther:txt_Other_Referral_D.text FacMachineType:str_machine_D FacMachineOther:txt_Other_Machine_D.text FacMaskType:str_mask_D facMaskOther:txt_Other_Mask_D.text FacModem:str_Modem_D FacMDAccess:str_MDAccess_D Fac14:str_14_D Fac25:str_25_D Fac30:str_30_D Fac45:str_45_D Fac60:str_60_D Fac90:str_90_D Fac120:str_120_D FacOtherIns:txt_OtherInstructions_D.text FacilityId:str_facilityId FacFax:txt_facility_fax.text];
            [self getStateForAddingDoctorFromResponse:dict forSource:2];
        });
        [[AppDelegate sharedInstance] showCustomLoader:self];
    }
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
                    if([object_model.msg isEqualToString:@"Doctor updated successfully"])
                    {
                        [self clearAllfields];
                             [[AppDelegate sharedInstance] showSuccesMessage:@"Your request is being processed"];
                    }
                    else if([object_model.msg isEqualToString:@"Nothing updated"])
                    {
                        [[AppDelegate sharedInstance] showAlertMessage:@"No field is updated"];
                    }
                    
                    break;
                case 1:
                    object_model = [AddDoctorModel addingDoctorResponseFromDictionary:dict];
                    if([object_model.msg isEqualToString:@"Updated successfully"])
                    {
                         [self clearAllfields];
                             [[AppDelegate sharedInstance] showSuccesMessage:@"Your request is being processed"];                    }
                    else if([object_model.msg isEqualToString:@"Parameter missing"])
                    {
                        
                        [[AppDelegate sharedInstance] showAlertMessage:@"Missing required Fields"];
                    }
                    
                    break;
                case 2:
                    object_model = [AddDoctorModel addingFacilityResponseFromDictionary:dict];
                    if([object_model.msg isEqualToString:@"Updated successfully"])
                    {
                        [self clearAllfields];
                           [[AppDelegate sharedInstance] showSuccesMessage:@"Your request is being processed"];
                    }
                    else if([object_model.msg isEqualToString:@"Parameter missing"])
                    {
                        [[AppDelegate sharedInstance] showAlertMessage:@"Missing required Fields"];
                    }
                    
                    break;
                    
                default:
                    break;
            }
        }
        
    });
}

-(void)datePicker
{
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake (-180, 10, 650, 600)];
    [datePicker addTarget:self action:@selector(dateGetChanged) forControlEvents:UIControlEventValueChanged];
    //[datePicker sizeToFit];
    datePicker.datePickerMode=UIDatePickerModeDate;
    pickerController=[UIViewController new];
    pickerController.view.frame=CGRectMake(300, 200, 300, 530);
    UIView *vw=[UIView new];
    vw.frame=CGRectMake(380, 200, 300, 530);
    //    [vw addSubview:pickerController.view];
    pickerController.view=datePicker;
    [vw addSubview:datePicker];
    pickerController.view = vw;
    pickerController.preferredContentSize = CGSizeMake(300,200);
   
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    temp_textField = textField;
    textField.returnKeyType = UIReturnKeyDefault;
    

    if ([textField isEqual:txt_NPI]) {
        
        [self animateScrollFormWithOriginY:92];
    }
    else if ([textField isEqual:txt_licence])
    {
        [self animateScrollFormWithOriginY:150];
    }
    else if ([textField isEqual:txt_firstName])
    {
        [self animateScrollFormWithOriginY:252];
    }
    else if ([textField isEqual:txt_middleName])
    {
        [self animateScrollFormWithOriginY:304];
    }
    else if ([textField isEqual:txt_lastName])
    {
        [self animateScrollFormWithOriginY:354];
    }
    else if ([textField isEqual:txt_Phone])
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [self animateScrollFormWithOriginY:405];
    }
    else if ([textField isEqual:txt_ConfFax])
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [self animateScrollFormWithOriginY:460];
    }
    else if ([textField isEqual:txt_DocContact])
    {
        [self animateScrollFormWithOriginY:513];
    }
    else if ([textField isEqual:txt_address_Doctor])
    {
        [self animateScrollFormWithOriginY:567];
    }
    else if ([textField isEqual:txt_city_Doc]||[textField isEqual:txt_Zip_Doc])
    {
        [self animateScrollFormWithOriginY:622];
    }
    else if ([textField isEqual:txt_UPIN])
    {
        [self animateScrollFormWithOriginY:201];
    }
    else if ([textField isEqual:txt_Other_Referral_U])
    {
        [self animateScrollFormWithOriginY:1088];
    }
    else if ([textField isEqual:txt_Other_Machine_U])
    {
        [self animateScrollFormWithOriginY:1223];
    }
    else if ([textField isEqual:txt_Other_Mask_U])
    {
        [self animateScrollFormWithOriginY:1343];
    }
    else if ([textField isEqual:txt_faciltyNickName])
    {
        [self animateScrollFormWithOriginY:1723];
    }
    else if ([textField isEqual:txt_faciltyName])
    {
        [self animateScrollFormWithOriginY:1765];
    }
    else if ([textField isEqual:txt_faciltyPhone])
    {
//        if (! [self ComparingAlphabet]) {
//            [[AppDelegate sharedInstance]showAlertMessage:@"Please enter your Facility Name & Facility Nick Name with the same alphabet"];
//        }
        [self animateScrollFormWithOriginY:1817];
    }
    else if ([textField isEqual:txt_faciltyContact])
    {
        [self animateScrollFormWithOriginY:1871];
    }
    else if ([textField isEqual:txt_address_Facility])
    {
        [self animateScrollFormWithOriginY:1924];
    }
    else if ([textField isEqual:txt_city_Facility] || [textField isEqual:txt_Zip_Facility])
    {
        [self animateScrollFormWithOriginY:1978];
    }
    else if ([textField isEqual:txt_Other_Referral_D])
    {
        [self animateScrollFormWithOriginY:2475];
    }
    else if ([textField isEqual:txt_Other_Machine_D])
    {
        [self animateScrollFormWithOriginY:2602];
    }
    else if ([textField isEqual:txt_Other_Mask_D])
    {
        [self animateScrollFormWithOriginY:2737];
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:txt_Phone]||[textField isEqual:txt_ConfFax]||[textField isEqual:txt_faciltyPhone]||[textField isEqual:txt_facility_fax])
        
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
        [txt_middleName becomeFirstResponder];
    }
    else if ([textField isEqual:txt_middleName])
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
    else if ([textField isEqual:txt_faciltyNickName])
    {
        [txt_faciltyName becomeFirstResponder];
    }
    else if ([textField isEqual:txt_faciltyName])
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
        [self animateScrollFormWithOriginY:761];
    }
    else if([textView isEqual:txt_addNotes_Doc])
    {
        [self animateScrollFormWithOriginY:871];
    }
    else if([textView isEqual:txt_OtherInstructions_U])
    {
        [self animateScrollFormWithOriginY:1526];
    }
    else if([textView isEqual:txt_Nuance_Fac])
    {
        [self animateScrollFormWithOriginY:2122];
    }
    else if([textView isEqual:txt_addNotes_Fac])
    {
        [self animateScrollFormWithOriginY:2237];
    }
    else if([textView isEqual:txt_OtherInstructions_D])
    {
        [self animateScrollFormWithOriginY:2899];
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
        [scroll_Form setContentOffset:CGPointMake(0,2649) animated:NO];
        
    } completion:nil];
}

-(void)showPopover
{
    controller_popover = [[UIViewController alloc]init];
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
   
   
}
-(void)setCheckImage
{
    [btn_traditional_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_HST_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_other_Referral_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_NoPreference_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Repirionics_Machine_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_ResMed_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_Fischer_Referral_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
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
    [btn_25Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_45Days_U setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
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
    [btn_25Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_45Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_30Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_60Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_90Days_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [btn_OnceYear_D setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
}
-(BOOL)checkValidationForBothNew
{
    if([str_doctorId isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select a doctor first"];
        return YES;
    }
   else if([str_facilityId isEqualToString:@""])
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
    else if([txt_middleName.text isEqualToString:@""])
    {
        [txt_middleName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's middleName"];
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
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's phone"];
        return YES;
    }
    else if([txt_ConfFax.text isEqualToString:@""])
    {
        [txt_ConfFax becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's ConFax"];
        return YES;
    }
    else if([txt_DocContact.text isEqualToString:@""])
    {
        [txt_DocContact becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's DocContact"];
        return YES;
    }
        else if([txt_city_Doc.text isEqualToString:@""])
    {
        [txt_city_Doc becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's city"];
        return YES;
    }
    else if ([txt_Zip_Doc.text isEqualToString:@""])
    {
        [txt_Zip_Doc becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's zip"];
        return YES;
    }
    else if([str_DoctorState isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select doctor's state"];
        return YES;
    }
//    else if ([txt_UPIN.text isEqualToString:@""])
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
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select download days for updating doctor"];
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
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select download days for new doctor"];
        return YES;
    }
    return NO;
}
-(BOOL)checkValidateFieldForUpdateNewdoctor
{
    if([str_doctorId isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select a doctor first"];
        return YES;
    }
    else if([txt_firstName.text isEqualToString:@""])
    {
        [txt_firstName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's first name"];
        return YES;
    }
    else if([txt_middleName.text isEqualToString:@""])
    {
        [txt_middleName becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's middleName"];
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
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's phone"];
        return YES;
    }
    else if([txt_ConfFax.text isEqualToString:@""])
    {
        [txt_ConfFax becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's ConFax"];
        return YES;
    }
    else if([txt_DocContact.text isEqualToString:@""])
    {
        [txt_DocContact becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's DocContact"];
        return YES;
    }
    else if([txt_city_Doc.text isEqualToString:@""])
    {
        [txt_city_Doc becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's city"];
        return YES;
    }
    else if ([txt_Zip_Doc.text isEqualToString:@""])
    {
        [txt_Zip_Doc becomeFirstResponder];
        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's zip"];
        return YES;
    }
    else if([str_DoctorState isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select doctor's state"];
        return YES;
    }
//    else if ([txt_UPIN.text isEqualToString:@""])
//    {
//        [txt_UPIN becomeFirstResponder];
//        [[AppDelegate sharedInstance] showAlertMessage:@"Please give doctor's UPIN"];
//        return YES;
//    }
//    
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
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select download days for updating doctor"];
        return YES;
    }
    return NO;
}

-(BOOL)ComparingAlphabet
{
    NSString *firstLetter = [txt_faciltyName.text substringToIndex:1];
    NSString *NickName = [txt_faciltyNickName.text substringToIndex:1];
    if ([firstLetter isEqualToString:NickName]) {
        return YES;
    }
    else return NO;
}
-(BOOL)checkValidationUpdateNewFacility
{
    if([str_facilityId isEqualToString:@""])
    {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select a facility"];
        return YES;
    }
   else if([txt_faciltyName.text isEqualToString:@""])
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
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select download days for updating doctor"];
        return YES;
    }
    return NO;
}
-(void)clearAllfields
{
    lbl_selectStateDoc.text =@"Select State";
    lbl_selectStatefac.text = @"Select State";
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
