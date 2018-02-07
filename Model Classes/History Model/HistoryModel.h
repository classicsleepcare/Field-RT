//
//  HistoryModel.h
//  RAP APP
//
//  Created by Anil Prasad on 4/20/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject

@property(nonatomic,strong)NSDictionary *dict_profileInfo;
@property(nonatomic,strong)NSDictionary *dict_docInfo;
@property(nonatomic,strong)NSDictionary *dict_insInfo;
@property(nonatomic,strong)NSArray *arr_pdfs,*arr_pdf_name;
@property(nonatomic,strong) NSArray *arr_Referral, *arr_setup;
@property(nonatomic,strong)NSString *msg;

@property (nonatomic, strong) NSArray *arr_patient_list;
@property (nonatomic, strong) NSArray *arr_files_info;

-(id)initWithDictionary:(NSDictionary*)dict;
-(id)initWithDictionaryForPatientDetail:(NSDictionary*)dict;

@end
