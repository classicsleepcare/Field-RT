//
//  NIVTakeCOPD.m
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVTakeCOPD.h"

@interface NIVTakeCOPD ()

@end

@implementation NIVTakeCOPD
@synthesize formData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self autoFillDates];
    txt_name.text = self.prevFormData[@"pt_name"];

    d_scrollView.contentSize                    = CGSizeMake(880, 1965);
    d_scrollView.contentOffset                  = CGPointMake(0,0);
    
    formData = [NSMutableDictionary new];

}

-(void)saveFormData{
    [formData setObject:self.prevFormData[@"ticket_id"] forKey:@"ticket_id"];
    [formData setObject:RT_ID forKey:@"rt_id"];
    [formData setObject:self.prevFormData[@"pt_id"] forKey:@"pt_id"];
    [formData setObject:NonNilString(str_date) forKey:@"date"];
    [formData setObject:NonNilString(txt_score_1.text) forKey:@"never_cough"];
    [formData setObject:NonNilString(txt_score_2.text) forKey:@"no_mucus"];
    [formData setObject:NonNilString(txt_score_3.text) forKey:@"chest_feel_tight"];
    [formData setObject:NonNilString(txt_score_4.text) forKey:@"walk_hill_not_breathless"];
    [formData setObject:NonNilString(txt_score_5.text) forKey:@"limited_doing_activities"];
    [formData setObject:NonNilString(txt_score_6.text) forKey:@"lung_condition"];
    [formData setObject:NonNilString(txt_score_7.text) forKey:@"sleep_soundly"];
    [formData setObject:NonNilString(txt_score_8.text) forKey:@"lots_of_energy"];
//    [formData setObject:@"" forKey:@"edit"];
    [self callSubmitAPI];
}

-(void)callSubmitAPI{
    NIVTIcketView *object_TV = [NIVTIcketView new];
    dispatch_queue_t myQueue = dispatch_queue_create("SUTII", 0);
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV takeCOPDAPI:formData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
                    NIVNewPatientProfile *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVNewPatientProfile"];
                    objectVC.prevFormData = self.prevFormData;
                    [self.navigationController pushViewController:objectVC animated:YES];
                }
                else{
                    [[AppDelegate sharedInstance] showAlertMessage:dicti[@"msg"]];
                }
            }
        });
    });
}

-(IBAction)nextButtonPressed{
    //[Utils takeScreenshot:d_scrollView];
    [self saveFormData];
    
//    NIVNewPatientProfile *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVNewPatientProfile"];
//    [self.navigationController pushViewController:objectVC animated:YES];
}

-(IBAction)backButtonPressed{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Dates

-(void)autoFillDates{
    NSArray *textFields = [[NSArray alloc] initWithObjects:txt_date, nil];
    [Utils setTodaysDateToTextFields:textFields];
    str_date = [Utils setDateFormatForAPI:[NSDate date]];
}

-(IBAction)selectCheckbox:(APRadioButton*)sender{
    NSNumber *tag = [NSNumber numberWithInteger:(int)sender.tag];
    if ([@[@1, @2, @3, @4, @5, @6] containsObject:tag]) {
        txt_score_1.text = [NSString stringWithFormat:@"%ld", (long)rad_1.selectedButton.tag-1];
    }
    if ([@[@11, @12, @13, @14, @15, @16] containsObject:tag]) {
        txt_score_2.text = [NSString stringWithFormat:@"%ld", (long)rad_2.selectedButton.tag-11];
    }
    if ([@[@111, @112, @113, @114, @115, @116] containsObject:tag]) {
        txt_score_3.text = [NSString stringWithFormat:@"%ld", (long)rad_3.selectedButton.tag-111];
    }
    if ([@[@1111, @1112, @1113, @1114, @1115, @1116] containsObject:tag]) {
        txt_score_4.text = [NSString stringWithFormat:@"%ld", (long)rad_4.selectedButton.tag-1111];
    }
    if ([@[@11111, @11112, @11113, @11114, @11115, @11116] containsObject:tag]) {
        txt_score_5.text = [NSString stringWithFormat:@"%ld", (long)rad_5.selectedButton.tag-11111];
    }
    if ([@[@111111, @111112, @111113, @111114, @111115, @111116] containsObject:tag]) {
        txt_score_6.text = [NSString stringWithFormat:@"%ld", (long)rad_6.selectedButton.tag-111111];
    }
    if ([@[@1111111, @1111112, @1111113, @1111114, @1111115, @1111116] containsObject:tag]) {
        txt_score_7.text = [NSString stringWithFormat:@"%ld", (long)rad_7.selectedButton.tag-1111111];
    }
    if ([@[@11111111, @11111112, @11111113, @11111114, @11111115, @11111116] containsObject:tag]) {
        txt_score_8.text = [NSString stringWithFormat:@"%ld", (long)rad_8.selectedButton.tag-11111111];
    }
    
    int total =
    [txt_score_1.text intValue] +
    [txt_score_2.text intValue] +
    [txt_score_3.text intValue] +
    [txt_score_4.text intValue] +
    [txt_score_5.text intValue] +
    [txt_score_6.text intValue] +
    [txt_score_7.text intValue] +
    [txt_score_8.text intValue];
    
    txt_score_total.text = [NSString stringWithFormat:@"%ld", (long)total];
}

@end
