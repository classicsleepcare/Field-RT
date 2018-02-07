//
//  ListOfDoctorsVC.m
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "ListOfDoctorsVC.h"
#import "DoctorDetailCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "DoctorListModel.h"
#import "DoctorListView.h"
#import "DoctorViewController.h"



@interface ListOfDoctorsVC ()<TabBarTextSearchDelegate>
{
    NSString *str1;
    UISwitch *switchBtn;
    NSArray *arr_identifiers;
    NSArray *arr_TableSearchData;
    
    
    DoctorListView *object_DLV;
    NSArray *arr_mainDocList;
    NSArray* arr_sortedDocList;
    NSArray *arr_unsortedDocList;
   
    NSDictionary *dict_docDetail;
    DoctorListModel *object_DLM;
    
    
    NSString *htmlStr;
    
}

@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@end

@implementation ListOfDoctorsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
   
    return self;
}

static int callValue = 0;

#pragma mark - TabBarSearch Delegates
-(void)searchedDataFromText:(NSString *)text
{
    if (arr_TableSearchData)
    {
        arr_TableSearchData=nil;
    }
    
    
    
    arr_TableSearchData = [arr_mainDocList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSDictionary *dict1 = evaluatedObject;
        NSString *firstName = [dict1 objectForKey:@"Dr_First"];
        NSString *lastName = [dict1 objectForKey:@"Dr_Last"];
        lastName = [lastName lowercaseString];
        firstName =[firstName lowercaseString];
        NSString *searchStr =[text lowercaseString];
        if([firstName rangeOfString:searchStr].location != NSNotFound || [lastName rangeOfString:searchStr].location != NSNotFound) {
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
    [table_docList reloadData];
    table_docList.contentSize = CGSizeMake(table_docList.contentSize.width, table_docList.contentSize.height+100);
}

- (void)searchBarClearButtonClicked:(NSString *)seTxt {
    
   // if ([seTxt isEqualToString:@""]) {
        
        arr_TableSearchData=nil;
    
        [table_docList reloadData];
    //}
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    
    callValue = 0;
   
    table_docDetail.layer.borderWidth=0.5;
    
    table_docDetail.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    detail_view.layer.borderWidth=2.0;
    detail_view.layer.borderColor =[[UIColor lightGrayColor] CGColor];
    arr_identifiers = @[@"detailcell",@"nanCell",@"search"];
    
   

    
    
   
}


-(void)viewDidAppear:(BOOL)animated
{
    DoctorViewController *object_tabBar = (DoctorViewController*)self.navigationController.parentViewController;
    object_tabBar.searchDelagate = self;
    if(callValue == 0)
    {

    object_DLV = [DoctorListView new];
    dispatch_queue_t myQueue = dispatch_queue_create("rahul", 0);
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict = [object_DLV getDoctorListForId:[[AppDelegate sharedInstance] rep_patientID]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[AppDelegate sharedInstance] removeCustomLoader];
            if(dict)
            {
            object_DLM = [[DoctorListModel alloc]initWithDictionary:dict];
            [self response:object_DLM];
            }
        });
    });
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    self.btn_selectedHeader.backgroundColor = [UIColor clearColor];
        callValue++;
    }
}
-(void)callWebserviceForDoctorList
{
    
}
-(void)response:(DoctorListModel*)object
{
    arr_unsortedDocList=object.arr_main;
    arr_sortedDocList=[object sortedDictionariesFromArray:object.arr_main];
    arr_mainDocList=arr_unsortedDocList;
   
    [table_docList reloadData];
    table_docList.contentSize = CGSizeMake(table_docList.contentSize.width, table_docList.contentSize.height+100); 
   
}

-(void)viewWillAppear:(BOOL)animated
{
    detail_view.hidden=YES;
   
    table_docList.hidden=NO;
    [self.view bringSubviewToFront:table_docList];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag==1) {
        return 2;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return 1;
    }
    if (arr_TableSearchData.count>0) {
        return arr_TableSearchData.count;
    }
    return [arr_mainDocList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DoctorDetailCell *cell;
    if (tableView.tag==1)
    {
        NSString *str = arr_identifiers[indexPath.section];
        cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[DoctorDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            
        }
        switch (indexPath.section) {
            case 0:
                
               
                cell.lbl_docPhone.text = [self stringWithParenthsisForText:dict_docDetail[@"Dr_Phone"]];
                cell.lbl_fax.text= dict_docDetail[@"Conf_Fax"];
                cell.lbl_npi.text = dict_docDetail[@"Dr_NPI"];
               cell.lbl_facFax.text= dict_docDetail[@"fac_fax"];
                
                 cell.lbl_facAdd.attributedText = [self getUnderlineText:dict_docDetail[@"Dr_Address"] isNumber:NO];
                 cell.lbl_facPhone.attributedText = [self getUnderlineText:dict_docDetail[@"fac_phone"]isNumber:YES];
                cell.lbl_lastRef.text= dict_docDetail[@"Ref_Date"];
               
                cell.lbl_DoctorOfficeContact.text=dict_docDetail[@"doctor_office_contact"];
                cell.lbl_facOfficeContact.text=dict_docDetail[@"facility_office_contact"];
                [cell.btn_docDetailAddress addTarget:self action:@selector(getDirection:) forControlEvents:UIControlEventTouchUpInside];
                
                break;
               
                case 1:
//                cell.txtView_nuance.text = dict_docDetail[@"Dr_Nuance"];
//                if([cell.txtView_nuance.text isEqualToString:@""])
//                {
//                    cell.txtView_nuance.textColor = [UIColor darkGrayColor];
//                     cell.txtView_nuance.text = @"There is no Nuance for this doctor.";
//                }
                
                htmlStr = [NSString stringWithFormat:@"<html><body><p>%@</p></body></html>", dict_docDetail[@"Dr_Nuance"]];
                [cell.webView_nuance loadHTMLString:htmlStr baseURL:nil];
                
                
                if([dict_docDetail[@"Dr_Nuance"] isEqualToString:@""])
                {
                    [cell.webView_nuance loadHTMLString:@"<html><body><p>There is no Nuance for this doctor.</p></body></html>" baseURL:nil];
                }
                break;
            default:
                break;
        }
    }
    else
    {
        NSDictionary *dict;
        if (arr_TableSearchData.count>0)
        {
            dict =arr_TableSearchData[indexPath.row];
        }
        else
        {
            
            
            dict = arr_mainDocList[indexPath.row];
            
        }
    static NSString *str = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[DoctorDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
        cell.lbl_docName.attributedText = [self getUnderlineText:[NSString stringWithFormat:@"%@, %@",dict[@"Dr_Last"],dict[@"Dr_First"]] isNumber:NO];
        cell.lbl_cityName.text = [NSString stringWithFormat:@"%@, %@",dict [@"Dr_City"],dict[@"Dr_State"]];
        
    cell.lbl_address.attributedText = [self getUnderlineText:dict[@"Dr_Address"] isNumber:NO];
        cell.lbl_contact.text = [self stringWithParenthsisForText:dict[@"Dr_Phone"]];
        cell.btn_doctorListAddress.tag =indexPath.row;
        [cell.btn_doctorListAddress addTarget:self action:@selector(getAlertForAddressWithRow:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return cell;
}
-(NSMutableAttributedString *)getUnderlineText :(NSString *)myText isNumber:(BOOL)isnumber
{
    NSString *text;
    
        
    
    if (myText.length>0) {
        text = isnumber ? [self stringWithParenthsisForText:myText]:myText;
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
        [attributeString addAttribute:NSUnderlineStyleAttributeName
                                value:[NSNumber numberWithInt:1]
                                range:(NSRange){0,[attributeString length]}];
        return attributeString;

    }
    return nil;
   }

-(NSString*)stringWithParenthsisForText:(NSString*)str
{
    NSString* str_text =str;
   
    if(str_text.length>0)
    {
   str_text =[NSString stringWithFormat:@"%@(%@", [str_text substringToIndex:1], [str_text substringFromIndex:1]];
    str_text =[NSString stringWithFormat:@"%@) %@", [str_text substringToIndex:5], [str_text substringFromIndex:5]];
    str_text = [NSString stringWithFormat:@"%@ %@", [str_text substringToIndex:10], [str_text substringFromIndex:10]];
    }
    return str_text;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 0:
            return 0;
            case 1:
            switch (section) {
                case 0:
                    return 0;
                    break;
                case 1:
                    return 30;
                    break;
                case 2:
                    return 30;
                    break;
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return 0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 1:
            switch (section) {
                case 0:
                    return nil;
                    break;
                
                case 1:
                    return @"Nuance";
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 1:
            switch (indexPath.section) {
                case 0:
                    return 297.0;
                    break;
                
                case 1:
                    return 316.0;
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return 100.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detail_view.frame=CGRectMake(1024,0,526,768);
    if (dict_docDetail)  dict_docDetail=nil;
       
   
    if (arr_TableSearchData.count>0)
    {
        dict_docDetail=arr_TableSearchData[indexPath.row];
    }
    else   dict_docDetail = arr_mainDocList[indexPath.row];
    
    [table_docDetail reloadData];
    table_docList.contentSize = CGSizeMake(table_docList.contentSize.width, table_docList.contentSize.height+100);
    lbl_docDetail_name.text = [NSString stringWithFormat:@"%@, %@",dict_docDetail[@"Dr_Last"],dict_docDetail[@"Dr_First"]];
    lbl_docDetail_city.text = [NSString stringWithFormat:@"%@, %@",dict_docDetail [@"Dr_City"],dict_docDetail[@"Dr_State"]];
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
       detail_view.frame=CGRectMake(394,0,526,768);
        [self.view bringSubviewToFront:detail_view];
        [self.view sendSubviewToBack:table_docList];
         detail_view.hidden=NO;
    } completion:^(BOOL finished) {
        
        
    }];
   
   
   
}

-(void)getAlertForAddressWithRow:(UIButton*)btn
{
    if (arr_TableSearchData.count>0)
    {
        dict_docDetail=arr_TableSearchData[btn.tag];
    }
    else   dict_docDetail = arr_mainDocList[btn.tag];
    [self showMapAlert:@"Do you want to get directions?" withOKButton:@"No" WithCancelButton:@"Yes"];
}
-(void)getDirection:(UIButton*)btn
{
    [self showMapAlert:@"Do you want to get directions?" withOKButton:@"No" WithCancelButton:@"Yes"];
}
-(void)directionAndNuanceMethod:(UIButton*)sender
{

     
    switch (sender.tag) {
        case 0:
           

            [self showMapAlert:@"Do you want to get directions?" withOKButton:@"No" WithCancelButton:@"Yes"];
           
            
            break;
        case 1:
            if([dict_docDetail[@"Dr_Nuance"] isEqualToString:@""])
          
                   [[AppDelegate sharedInstance] showAlertMessage:@"No Nuance"];
            
            else [[AppDelegate sharedInstance] showAlertMessage:dict_docDetail[@"Dr_Nuance"]];
            break;
        default:
            break;
    }
   
}
-(void)showMapAlert:(NSString*)msg withOKButton:(NSString*)okBtn WithCancelButton:(NSString*)canBtn
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Google Maps" message:msg delegate:self cancelButtonTitle:okBtn otherButtonTitles:canBtn, nil];
    [alert show]; alert=nil;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Yes"])
    {
       
        
        NSURL *url_test =[NSURL URLWithString:@"comgooglemaps-x-callback://"];
        if ([[UIApplication sharedApplication] canOpenURL:url_test])
        {//?saddr=James+L+West+Presbyterian,+Summit Avenue,+Fort Worth,+TX,+United States
            NSString *str = @"comgooglemaps-x-callback://";
            
            float lat = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lat"] floatValue];
            float lon = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lon"] floatValue];
            
            
            str = [str stringByAppendingString:[[NSString stringWithFormat:@"?saddr=%f",lat] stringByAppendingString:[NSString stringWithFormat:@",%f", lon]]];
            
            str = [str stringByAppendingString:
                  [NSString stringWithFormat:@"&daddr=%@",[dict_docDetail[@"Dr_Address"] stringByAppendingString:[NSString stringWithFormat:@", %@",dict_docDetail [@"Dr_City"]]]]] ;
            
            NSString *directionsRequest=[[str stringByAppendingString:@"&x-success=PCLRepAPP://?resume=true&x-source=PCL Rep App"] stringByAddingPercentEscapesUsingEncoding:4];
            
            NSURL *directionsURL = [NSURL URLWithString:directionsRequest];
            NSLog(@"DIR: %@", directionsURL);
            [[UIApplication sharedApplication] openURL:directionsURL];
        }
        else
        {
            [[AppDelegate sharedInstance] showAlertMessage:@"Please Install Google map application in your device first"];
        }
    }
}
-(IBAction)addNewDoctor:(id)sender
{
    
   
  
    
    

}

-(IBAction)CloseViewMethod:(id)sender
{
    detail_view.hidden=YES;
}

-(IBAction)action_headerButton:(UIButton*)sender
{
    self.btn_selectedHeader.backgroundColor =[UIColor clearColor];
    self.btn_selectedHeader=sender;
    sender.backgroundColor = DarkBlueColor();
    switch (sender.tag) {
        case 0:
            if(arr_TableSearchData.count>0)
            {
               arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Dr_First"];
            }
            else
            arr_mainDocList = [self sortedDictionariesFromArray:arr_mainDocList :@"Dr_First"];
            break;
        case 1:
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Dr_Address"];
            }
            else
            arr_mainDocList = [self sortedDictionariesFromArray:arr_mainDocList :@"Dr_Address"];
            break;
        case 2:
            if(arr_TableSearchData.count>0)
            {
                arr_TableSearchData = [self sortedDictionariesFromArray:arr_TableSearchData :@"Dr_Phone"];
            }
            else
            arr_mainDocList = [self sortedDictionariesFromArray:arr_mainDocList :@"Dr_Phone"];
            break;
            
        default:
            break;
    }
        [table_docList reloadData];
    table_docList.contentSize = CGSizeMake(table_docList.contentSize.width, table_docList.contentSize.height+100);
}
-(NSArray*)sortedDictionariesFromArray:(NSArray*)array :(NSString*)key
{
    NSArray *sortedArray;
    NSSortDescriptor*cityDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    NSArray* sortDescriptors = [NSArray arrayWithObject:cityDescriptor];
    sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
}

-(void)closeAddNewDoctyorView:(id)sender
{
    [self.view bringSubviewToFront:detail_view];
    
   
    table_docList.hidden=NO;
   
    
}
UIColor *DarkBlueColor()
{
    return [UIColor colorWithRed:47.0/255.0 green:98.0/255.0 blue:136.0/255.0 alpha:1];
};
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
