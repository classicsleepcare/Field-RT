//
//  SearchReferralViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 5/20/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "SearchReferralViewController.h"

#import "PatientList.h"
#import "AppDelegate.h"
#import "HistoryModel.h"
#import "HistoryView.h"
#import "PatientInformationViewController.h"
#import "HistoryCell.h"
#import "DoctorViewController.h"
@interface SearchReferralViewController ()<TabBarTextSearchDelegate>
{
    NSMutableArray  *arr_headerButtons;
    UIPopoverController *popover_dropDown;
    UITableViewController *tableview_controller;
    
    int columnHighlighted;
    NSString *str_columName;
    dispatch_queue_t mQueue;
    
    
    UIScrollView *scroll_infoView;
    NSArray *arr_TableSearchData;
    
    BOOL isFnameSorted_l, isLnameSorted_l, isRdateSorted_l, isADdateSorted_l, isSetupDateSorted_l, isDoctorSorted_l, isInsuranceSorted_l, isStatusSorted_l;
    BOOL isFnameSorted_r, isLnameSorted_r, isStatusSorted_r, isCitySorted_r, isSecondarySorted_r, isMachineSorted_r, isMaskSorted_r, isRtSorted_r;
}

@end

@implementation SearchReferralViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)searchedDataFromText:(NSString *)text
{
   
    arr_TableSearchData = [_arr_searchedPatientList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSDictionary *dict1 = evaluatedObject;
        NSString *name = [dict1 objectForKey:@"Pt_First"];
     
        NSString *lastName = [[dict1 objectForKey:@"Pt_Last"] lowercaseString];
        name =[name lowercaseString];
       
        NSString *searchStr =[text lowercaseString];
        if([name rangeOfString:searchStr].location != NSNotFound || [lastName rangeOfString:searchStr].location != NSNotFound) {
            return YES;
        }
        return NO;
        
    }]];
    
    if (arr_TableSearchData.count==0&&text.length>0) {
        [[AppDelegate sharedInstance] showAlertMessage:@"No Result Found"];
        lbl_showCount.text = [NSString stringWithFormat:@"%i",_arr_searchedPatientList.count];
    }
    else if(arr_TableSearchData.count>0)
    {
              lbl_showCount.text = [NSString stringWithFormat:@"%i",arr_TableSearchData.count];
     
    }
    else
    {
       lbl_showCount.text = [NSString stringWithFormat:@"%i",_arr_searchedPatientList.count];
    }
    [tabel_searchePatientOne reloadData];
    
    [tabel_searchePatientSecond reloadData];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
     mQueue = dispatch_queue_create("sort", 0);
    
    imageView_backArrow.hidden =YES;
    imageViewForwardArrow.hidden = NO;
    lbl_swipeLeft.hidden =YES;
    lbl_swipeRight.hidden =NO;
    
    [btn_pageControl addTarget:self action:@selector(ChngePage:) forControlEvents:UIControlEventValueChanged];
     //[scroll_view addSubview:mGridDetailVw];
    
//    view_LeftHeaderButtons.layer.borderWidth=1.0;
//    view_LeftHeaderButtons.layer.borderColor=[[UIColor blackColor] CGColor];
//    view_RightHeaderButtons.layer.borderWidth=1.0;
//    view_RightHeaderButtons.layer.borderColor=[[UIColor blackColor] CGColor];
    
    lbl_showCount.text=[NSString stringWithFormat:@"%i",_arr_searchedPatientList.count];
  
  
   
    arr_Dropdownlist=@[@"First Name",@"Last Name",@"Referral Date",@"App/Den Date",@"Setup Date",@"Doctor",@"Status",@"City",@"Secondary",@"Machine",@"Mask",@"RT"];
   
   
    [self creatPopoverForDropDown];
    
    
    [self addScrollView];
    
   
    btn_pageControl.pageIndicatorTintColor= customGrayColor();
    
    arr_headerButtons = [[NSMutableArray alloc] initWithObjects:btn_appdate,btn_City,btn_doctor,btn_insurance,btn_leftFirstName,btn_leftLastName,btn_machine,btn_mask,btn_referraldate,btn_rightfirstName,btn_rightLastName,btn_rightStatus,btn_RT,btn_secondary,btn_setupDate,btn_status, nil];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    DoctorViewController *object_tabBar = (DoctorViewController*)self.navigationController.parentViewController;
    object_tabBar.searchDelagate = self;
}

-(void)addScrollView
{
    float height = 45+CGRectGetHeight(tabel_searchePatientSecond.frame);
    CGRect frame = CGRectMake(8, 115, 883, height);
    scroll_infoView = [[UIScrollView alloc]initWithFrame:frame];
    scroll_infoView.delegate=self;
    scroll_infoView.pagingEnabled =YES;
    scroll_infoView.minimumZoomScale = 0.5;
    scroll_infoView.maximumZoomScale = 3;
    scroll_infoView.showsHorizontalScrollIndicator = NO;
    scroll_infoView.contentSize=CGSizeMake(878*2+10, height);
    tabel_searchePatientOne.frame = CGRectMake(0, 25, CGRectGetWidth(tabel_searchePatientOne.frame), CGRectGetHeight(tabel_searchePatientOne.frame));
    view_LeftHeaderButtons.frame = CGRectMake(0, 0, 810, 26);
    view_RightHeaderButtons.frame= CGRectMake(883, 0, 810, 26);
    tabel_searchePatientSecond.frame = CGRectMake(883, 25, CGRectGetWidth(tabel_searchePatientSecond.frame), CGRectGetHeight(tabel_searchePatientSecond.frame));
    [scroll_infoView addSubview:view_LeftHeaderButtons];
    [scroll_infoView addSubview:tabel_searchePatientOne];
    [scroll_infoView addSubview:view_RightHeaderButtons];
    [scroll_infoView addSubview:tabel_searchePatientSecond];
    [self.view addSubview:scroll_infoView];
    
}
-(void)creatPopoverForDropDown
{
   
    tableview_controller=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];

    tableview_controller.preferredContentSize = CGSizeMake(180,200);
    tableview_controller.tableView.tag= 456;
   
    tableview_controller.tableView.delegate=self;
    tableview_controller.tableView.dataSource=self;
    
    tableview_controller.tableView.separatorInset = UIEdgeInsetsZero;
    
    //[controller_popover.view addSubview:tableview_controller.tableView];
   
    popover_dropDown = [[UIPopoverController alloc] initWithContentViewController:tableview_controller];
   
}


-(void)clearTextfields
{
   
    [popover_dropDown dismissPopoverAnimated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   if(scroll_infoView.contentOffset.x>=883)
   {
       btn_pageControl.currentPage=1;
       imageView_backArrow.hidden =NO;
       imageViewForwardArrow.hidden = YES;
       lbl_swipeLeft.hidden =NO;
       lbl_swipeRight.hidden =YES;
      
   }
    else if(scroll_infoView.contentOffset.x<883)
    {
        imageView_backArrow.hidden =YES;
        imageViewForwardArrow.hidden = NO;
         btn_pageControl.currentPage=0;
        lbl_swipeLeft.hidden =YES;
        lbl_swipeRight.hidden =NO;
    }
}
-(void)ChngePage:(UIPageControl*)sender

{
    if(sender.currentPage==0)
    {
        [scroll_infoView setContentOffset:CGPointMake(0, 0) animated:YES];
        imageView_backArrow.hidden =YES;
        imageViewForwardArrow.hidden = NO;
        lbl_swipeLeft.hidden =YES;
        lbl_swipeRight.hidden =NO;
    }
    else
    {
        [scroll_infoView setContentOffset:CGPointMake(883, 0) animated:YES];
        imageView_backArrow.hidden =NO;
        imageViewForwardArrow.hidden = YES;
        lbl_swipeLeft.hidden =NO;
        lbl_swipeRight.hidden =YES;
       
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==456) return arr_Dropdownlist.count;
    if(arr_TableSearchData.count>0)return arr_TableSearchData.count;
    return _arr_searchedPatientList.count;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell_main;
   
    /*
     searchReferralSecond
     */
    if([tableView isEqual:tabel_searchePatientOne])
    {
        NSDictionary *dict;
        
        if(arr_TableSearchData.count>0)
        {
            dict = arr_TableSearchData[indexPath.row];
        }
        else
        {
            dict = _arr_searchedPatientList[indexPath.row];
        }
        
        static NSString *CellIdentifier = @"searchReferral";
         HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        [cell customizeLabelInCell];
        cell.lbl_serial.text = [NSString stringWithFormat:@"%i",indexPath.row+1];
        
        cell.lbl_lastName.attributedText = [self getUnderlineText:dict[@"Pt_Last"]];
        
        cell.lbl_firstName.attributedText = [self getUnderlineText:dict[@"Pt_First"]];
        
        cell.lbl_refDate.text = dict[@"Ref_Date"];
        cell.lbl_appDate.text = dict[@"Stat_Date"];
        cell.lbl_setupDate.text = dict[@"SU_Date"];
        cell.lbl_doc.text = dict[@"doctor"];
        cell.lbl_insurance.text = dict[@"Pri_Ins"];
        cell.lbl_status.text = dict[@"status"];
        
        cell.btn_selectedPatient.tag = indexPath.row;
        [cell.btn_selectedPatient addTarget:self action:@selector(action_selectedRow:) forControlEvents:UIControlEventTouchUpInside];
        cell_main = cell;
        
        
    }
   else if([tableView isEqual:tabel_searchePatientSecond])
   {
       NSDictionary *dict;
       
       if(arr_TableSearchData.count>0)
       {
           dict = arr_TableSearchData[indexPath.row];
       }
       else
       {
           dict = _arr_searchedPatientList[indexPath.row];
       }

       static NSString *CellIdentifier = @"searchReferralSecond";
        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       [cell customizeLabelInCell];
       
       cell.lbl_serial.text = [NSString stringWithFormat:@"%i",indexPath.row+1];
       cell.lbl_lastName.attributedText = [self getUnderlineText:dict[@"Pt_Last"]];
       
       cell.lbl_firstName.attributedText = [self getUnderlineText:dict[@"Pt_First"]];
       
       cell.lbl_city.text = dict[@"Pt_City"];
       cell.lbl_secondary.text = dict[@"Sec_Ins"];
       cell.lbl_machine.text = dict[@"pt_machine"];
       cell.lbl_mask.text = dict[@"pt_mask"];
       cell.lbl_RT.text = dict[@"Ship_Rep_Name"];
       cell.lbl_status.text = dict[@"status"];
       cell.btn_selectedPatient.tag = indexPath.row;
       [cell.btn_selectedPatient addTarget:self action:@selector(action_selectedRow:) forControlEvents:UIControlEventTouchUpInside];
       
        cell_main = cell;
   }
    
    else
    {
        static NSString *CellIdentifier = @"dropDown";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
        cell.textLabel.text = arr_Dropdownlist[indexPath.row];
        cell_main = cell;
    }
    
   
    return cell_main;
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(tableView.tag==456) return 34.0;
    return 35;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==456)
    {
        dispatch_async(mQueue, ^{
            
            
            switch (indexPath.row) {
                case 0:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Pt_First"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_First"];
                    
                    str_columName = @"First Name";
                    break;
                case 1:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Pt_Last"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_Last"];
                    str_columName = @"Last Name";
                    break;
                case 2:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Ref_Date"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Ref_Date"];
                    str_columName = @"Referral Date";
                    break;
                case 3:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Stat_Date"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Stat_Date"];
                    str_columName = @"App/Den Date";
                    break;
                case 4:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"SU_Date"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"SU_Date"];
                    str_columName = @"Setup Date";
                    break;
                case 5:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"doctor"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"doctor"];
                    str_columName = @"Doctor";
                    break;
                case 6:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"status"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"status"];
                    str_columName = @"Status";
                    break;
                case 7:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Pt_City"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_City"];
                    str_columName = @"City";
                    break;
                case 8:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Sec_Ins"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Sec_Ins"];
                    str_columName = @"Secondary";
                    break;
                case 9:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"pt_machine"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"pt_machine"];
                    str_columName = @"Machine";
                    break;
                case 10:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"pt_mask"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"pt_mask"];
                    str_columName = @"Mask";
                    break;
                case 11:
                    if(arr_TableSearchData.count>0)
                    {
                        arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Ship_Rep_Name"];
                    }
                    else
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Ship_Rep_Name"];
                    str_columName = @"RT";
                    break;
                    
                default:
                    break;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AppDelegate sharedInstance ] removeCustomLoader];
                NSString *string=[NSString stringWithFormat:@"%@",[arr_Dropdownlist objectAtIndex:indexPath.row] ];
                lbl_showSelectedValue.text=string;
                [self selectedButton:str_columName];
               
                [tabel_searchePatientOne reloadData];
              
                [tabel_searchePatientSecond reloadData];
            });
            
        });
        [popover_dropDown dismissPopoverAnimated:NO];
        [[AppDelegate sharedInstance] showCustomLoader:self];
    }
    
    
}

-(void)action_selectedRow:(UIButton*)btn

{
    int tag = btn.tag;
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_queue_t myqueue = dispatch_queue_create("Kumar", 0);
    
    dispatch_async(myqueue, ^{
        
        NSDictionary* dict_tble;
        if(arr_TableSearchData.count>0)
        {
            dict_tble = arr_TableSearchData[tag];
        }
        
        else dict_tble = _arr_searchedPatientList[tag];
        
        HistoryView *object_HV = [HistoryView new];
        NSDictionary *dict = [object_HV getDetailListForPatientOfId:dict_tble[@"Pt_ID"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            HistoryModel* object_HM = [[HistoryModel alloc]initWithDictionaryForPatientDetail:dict];
            //[self responseForInformation:object_HM];
            PatientInformationViewController *object_PIVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PIVC"];
            
            object_PIVC.dict_patientInfo=object_HM.dict_profileInfo;
            object_PIVC.dict_docInfo=object_HM.dict_docInfo;
            object_PIVC.dict_insInfo=object_HM.dict_insInfo;
            object_PIVC.arr_pdfs=object_HM.arr_pdfs;
            object_PIVC.arr_FileName = object_HM.arr_pdf_name;
            [self.navigationController pushViewController:object_PIVC animated:YES];
            
            
        });
    });
}


-(IBAction)customDropDownMenu:(UIButton*)sender
{
 
[popover_dropDown presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
 
}





-(NSArray*)sortedDictionariesFromArray:(NSArray*)array :(NSString*)key
{
//    BOOL order = YES;
//    if([key isEqualToString:@"SU_Date"]) order = NO;
    NSArray *sortedArray;
    NSSortDescriptor*cityDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:NO];
    NSArray* sortDescriptors = [NSArray arrayWithObject:cityDescriptor];
    sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
}

-(NSArray*)sortedDictionariesFromArray:(NSArray*)array :(NSString*)key order:(BOOL)order
{
    //    BOOL order = YES;
    //    if([key isEqualToString:@"SU_Date"]) order = NO;
    NSArray *sortedArray;
    NSSortDescriptor*cityDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:order];
    NSArray* sortDescriptors = [NSArray arrayWithObject:cityDescriptor];
    sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
}


- (void)didReceiveMemoryWarning
{
    NSLog(@"Memory Warning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
UIColor *customGrayColor()
{
    return [UIColor colorWithRed:146.0/255.0 green:146.0/255.0 blue:146.0/255.0 alpha:1];
}
UIColor *customBlueColor()
{
    return [UIColor colorWithRed:47.0/255.0 green:98.0/255.0 blue:136.0/255.0 alpha:1];
}
- (IBAction)action_HeaderButtons:(UIButton*)sender
{
    
    dispatch_async(mQueue, ^{
   
        int tag = sender.tag;
        if(tag==0)
        {
            NSLog(@"LAST NAME");
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Pt_Last"];
            }
            else{
                if (isLnameSorted_l) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_Last" order:YES];
                    str_columName = @"Last Name";
                    isLnameSorted_l = NO;
                }else {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_Last" order:NO];
                    str_columName = @"Last Name";
                    isLnameSorted_l = YES;
                }
            }
        }
        else if(tag==1)
        {
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Pt_First"];
            }
            
            else{
                if (isFnameSorted_l) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_First" order:YES];
                    str_columName = @"First Name";
                    isFnameSorted_l = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_First" order:NO];
                    str_columName = @"First Name";
                    isFnameSorted_l = YES;
                }
            }
        }
        else if(tag==2)
        {
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Ref_Date"];
            }
            
            else{
                if (isRdateSorted_l) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Ref_Date" order:YES];
                    str_columName = @"Referral Date";
                    isRdateSorted_l = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Ref_Date" order:NO];
                    str_columName = @"Referral Date";
                    isRdateSorted_l = YES;
                }
            }
        }
        else if(tag==3)
        {
           
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Stat_Date"];
            }
            else{
                if (isADdateSorted_l) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Stat_Date" order:YES];
                    str_columName = @"App/Den Date";
                    isADdateSorted_l = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Stat_Date" order:NO];
                    str_columName = @"App/Den Date";
                    isADdateSorted_l = YES;
                }
            }
        }
        
        else if(tag==4)
        {
            
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"SU_Date"];
            }
            else{
                if (isSetupDateSorted_l) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"SU_Date" order:YES];
                    str_columName = @"Setup Date";
                    isSetupDateSorted_l = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"SU_Date" order:NO];
                    str_columName = @"Setup Date";
                    isSetupDateSorted_l = YES;
                }
            }
        }
        else if(tag==5)
        {
            
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"doctor"];
            }
            else{
                if (isDoctorSorted_l) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"doctor" order:YES];
                    str_columName = @"Doctor";
                    isDoctorSorted_l = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"doctor" order:NO];
                    str_columName = @"Doctor";
                    isDoctorSorted_l = YES;
                }
            }
        }
        else if(tag==6)
        {
            
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Pri_Ins"];
            }
            else{
                if (isInsuranceSorted_l) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pri_Ins" order:YES];
                    str_columName = @"Insurance";
                    isInsuranceSorted_l = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pri_Ins" order:NO];
                    str_columName = @"Insurance";
                    isInsuranceSorted_l = YES;
                }
            }
        }
        
        else if(tag==7)
        {
            
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"status"];
            }
            else{
                if (isStatusSorted_l) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"status" order:YES];
                    str_columName = @"Status";
                    isStatusSorted_l = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"status" order:NO];
                    str_columName = @"Status";
                    isStatusSorted_l = YES;
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[AppDelegate sharedInstance] removeCustomLoader];
            lbl_showSelectedValue.text=str_columName;
            [self selectedButton:str_columName];
                      [tabel_searchePatientOne reloadData];
            
                       [tabel_searchePatientSecond reloadData];
            
        });
        
         });
      [[AppDelegate sharedInstance] showCustomLoader:self];
        
        
    
}

- (IBAction)actionRightHeaderButtons:(UIButton*)sender
{
    dispatch_async(mQueue, ^{
        
        
    
    int tag= sender.tag;
        if(tag==0)
        {
            
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Pt_Last"];
            }
            else{
                if (isLnameSorted_r) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_Last" order:YES];
                    str_columName = @"Last Name";
                    isLnameSorted_r = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_Last" order:NO];
                    str_columName = @"Last Name";
                    isLnameSorted_r = YES;
                }
            }
        }
        else if(tag==1)
        {
           
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Pt_First"];
            }
            else{
                if (isFnameSorted_r) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_First" order:YES];
                    str_columName = @"First Name";
                    isFnameSorted_r = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_First" order:NO];
                    str_columName = @"First Name";
                    isFnameSorted_r = YES;
                }
            }
        }
        
        else if(tag==2)
        {
           
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"status"];
            }
            else{
                if (isStatusSorted_r) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"status" order:YES];
                    str_columName = @"Status";
                    isStatusSorted_r = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"status" order:NO];
                    str_columName = @"Status";
                    isStatusSorted_r = YES;
                }
            }
        }
        else if(tag==3)
        {
          
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Pt_City"];
            }
            else{
                if (isCitySorted_r) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_City" order:YES];
                    str_columName = @"City";
                    isCitySorted_r = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Pt_City" order:NO];
                    str_columName = @"City";
                    isCitySorted_r = YES;
                }
            }
        }
        else if(tag==4)
        {
           
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Sec_Ins"];
            }
            else{
                if (isSecondarySorted_r) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Sec_Ins" order:YES];
                    str_columName = @"Secondary";
                    isSecondarySorted_r = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Sec_Ins" order:NO];
                    str_columName = @"Secondary";
                    isSecondarySorted_r = YES;
                }
            }
        }
        else if(tag==5)
        {
           
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"pt_machine"];
            }
            else{
                if (isMachineSorted_r) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"pt_machine" order:NO];
                    str_columName = @"Machine";
                    isMachineSorted_r = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"pt_machine" order:YES];
                    str_columName = @"Machine";
                    isMachineSorted_r = YES;
                }
            }
        }
        else if(tag==6)
        {
          
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"pt_mask"];
            }
            else{
                if (isMaskSorted_r) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"pt_mask" order:YES];
                    str_columName = @"Mask";
                    isMaskSorted_r = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"pt_mask" order:NO];
                    str_columName = @"Mask";
                    isMaskSorted_r = YES;
                }
            }
        }
        
        else if(tag==7)
        {
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Ship_Rep_Name"];
            }
            else{
                if (isRtSorted_r) {
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Ship_Rep_Name" order:YES];
                    str_columName = @"RT";
                    isRtSorted_r = NO;
                }else{
                    _arr_searchedPatientList = [self sortedDictionariesFromArray:_arr_searchedPatientList :@"Ship_Rep_Name" order:NO];
                    str_columName = @"RT";
                    isRtSorted_r = YES;
                }
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[AppDelegate sharedInstance] removeCustomLoader];
             lbl_showSelectedValue.text=str_columName;
            [self selectedButton:str_columName];
          
            [tabel_searchePatientOne reloadData];
            
            [tabel_searchePatientSecond reloadData];
            
        });
    });
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
}

-(void)selectedButton:(NSString*)btn_title
{
    for (UIButton* sender in arr_headerButtons)
    {
        if([sender.titleLabel.text isEqualToString:btn_title])
        {
            
            sender.backgroundColor = customBlueColor();
        }
        else
        {
            
            sender.backgroundColor=[UIColor clearColor];
        }
    }
}

- (IBAction)actionBack:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];
}
@end
