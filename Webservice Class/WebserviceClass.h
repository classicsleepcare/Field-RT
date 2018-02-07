//
//  WebserviceClass.h
//  SampleCatagory
//
//  Created by Anil Prasad on 4/4/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

typedef void (^RequestOnCompletion)(id result,NSError* error);

@interface WebserviceClass : NSObject

+(void)getParseDataFromUrl :(NSString*)url :(RequestOnCompletion)handler;

+ (void)getParseDataWithID:(NSString*)ticket_id
                  initial1:(UIImage*)initial1
                  initial2:(UIImage*)initial2
                  initial3:(UIImage*)initial3
                 signature:(UIImage*)signature
      rt_trainer_signature:(UIImage*)rt_trainer_signature
      rt_patient_signature:(UIImage*)rt_patient_signature
             isFinalSubmit:(NSString*)isFinalSubmit
           final_signature:(UIImage*)final_signature
       mrr_legal_auth_sign:(UIImage*)mrr_legal_auth_sign
          mrr_witness_sign:(UIImage*)mrr_witness_sign
   pip_legal_auth_rep_sign:(UIImage*)pip_legal_auth_rep_sign
               cig_pt_sign:(UIImage*)cig_pt_sign
   cig_representative_sign:(UIImage*)cig_representative_sign
               sms_pt_sign:(UIImage*)sms_pt_sign
   sms_representative_sign:(UIImage*)sms_representative_sign
               cig_include:(NSString*)cig_include
               sms_include:(NSString*)sms_include
                   FromUrl:(NSString *)url :(RequestOnCompletion)handler;

+(void)callNIVWebService:(NSDictionary*)formData withHTTPMethod:(NSString*)method FromUrl:(NSString *)url :(RequestOnCompletion)handler;

@end
