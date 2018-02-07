//
//  SearchPatientViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 4/22/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "SearchPatientViewController.h"
#import "DoctorDetailCell.h"
#import "AppDelegate.h"
#import "HistoryModel.h"
#import "HistoryView.h"
#import "PatientInformationViewController.h"

@interface SearchPatientViewController ()

{
    NSArray *arr_TableSearchData;
    
    UITableView *tbl_vw;
}
@end

@implementation SearchPatientViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)getTextFromTextField:(NSString *)text
{
    if (arr_TableSearchData)
    {
       
        arr_TableSearchData=nil;
        
    }
    
    
    
    arr_TableSearchData = [_arr_searchedPatientList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSDictionary *dict1 = evaluatedObject;
        NSString *name = [dict1 objectForKey:@"Pt_First"];
        name =[name lowercaseString];
        NSString *searchStr =[text lowercaseString];
        if([name rangeOfString:searchStr].location != NSNotFound) {
            return YES;
        }
        return NO;
        
    }]];
    
    if (arr_TableSearchData.count==0&&text.length>0) {
        [[AppDelegate sharedInstance] showAlertMessage:@"No Record Found"];
    }
    else if(text.length==0)
    {
        lbl_patientCount.text = [NSString stringWithFormat:@"%i",_arr_searchedPatientList.count];
       
    }
    else
    {
         lbl_patientCount.text = [NSString stringWithFormat:@"%i",arr_TableSearchData.count];
    }
    [tbl_vw reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    if (arr_TableSearchData.count>0) {
        return arr_TableSearchData.count;
    }
    return _arr_searchedPatientList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(!tbl_vw)  tbl_vw =tableView;
    static NSString *cellID = @"searchPatient";
    DoctorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DoctorDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dict2;
    if (arr_TableSearchData.count>0) dict2 = arr_TableSearchData[indexPath.row];
   else dict2=_arr_searchedPatientList[indexPath.row];
    cell.lbl_Patient.text = [NSString stringWithFormat:@"%@, %@",dict2[@"Pt_Last"],dict2[@"Pt_First"]];
    cell.lbl_Doctor.text=dict2[@"doctor"];
    cell.lbl_Insurance.text=dict2[@"Pri_Ins"];
    cell.lbl_Status.text=dict2[@"status"];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_queue_t myqueue = dispatch_queue_create("Kumar", 0);
    
    dispatch_async(myqueue, ^{
        
        NSDictionary* dict_tble;
        if (arr_TableSearchData.count>0) dict_tble = arr_TableSearchData[indexPath.row];
        else dict_tble = _arr_searchedPatientList[indexPath.row] ;
        
        HistoryView *object_HV = [HistoryView new];
        NSDictionary *dict = [object_HV getDetailListForPatientOfId:dict_tble[@"Pt_ID"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            if(dict)
            {
                HistoryModel* object_HM = [[HistoryModel alloc]initWithDictionaryForPatientDetail:dict];
                //[self responseForInformation:object_HM];
                PatientInformationViewController *object_PIVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PIVC"];
                object_PIVC.dict_patientInfo=object_HM.dict_profileInfo;
                object_PIVC.dict_docInfo=object_HM.dict_docInfo;
                object_PIVC.dict_insInfo=object_HM.dict_insInfo;
                object_PIVC.arr_pdfs=object_HM.arr_pdfs;
                [self.navigationController pushViewController:object_PIVC animated:YES];
            }
            
        });
    });

}
-(void)viewDidAppear:(BOOL)animated
{
    tbl_vw.contentSize = CGSizeMake(tbl_vw.contentSize.width, tbl_vw.contentSize.height+300);
    
    lbl_patientCount.text = [NSString stringWithFormat:@"%i",_arr_searchedPatientList.count];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)backButtonMethod:(id)sender
{
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:0] animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
