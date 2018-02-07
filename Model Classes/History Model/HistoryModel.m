//
//  HistoryModel.m
//  RAP APP
//
//  Created by Anil Prasad on 4/20/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel
{
    
}
-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _arr_patient_list = dict[@"patient_list"];
        
        _msg = dict[@"msg"];
        if ([_msg isEqualToString:@"Record(s) found"])
        {
            _arr_Referral = dict[@"Ref_Date"];
            _arr_setup = dict[@"SU_Date"];
            
        }      
        
    }
    return self;
}
-(id)initWithDictionaryForPatientDetail:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _dict_profileInfo= dict[@"patient_info"];
        _dict_docInfo= dict[@"doctor_info"];
        _dict_insInfo= dict[@"insurance_info"];
        _arr_pdfs =dict[@"files_path"];
        _arr_pdf_name = dict[@"files_name"];
        _arr_files_info = dict[@"files_info"];
    }
    return self;
}

@end
