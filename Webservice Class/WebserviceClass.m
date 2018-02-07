//
//  WebserviceClass.m
//  SampleCatagory
//
//  Created by Anil Prasad on 4/4/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "WebserviceClass.h"
#import "AppDelegate.h"
#import "Reachability.h"

@implementation WebserviceClass

+(void)getParseDataFromUrl:(NSString *)url :(RequestOnCompletion)handler
{
    
    if (handler)
    {
        @try {
            NSLog(@"API:   %@", url);
            NSError *error;
            NSURL *web_url  = [NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
            NSData *data    = [NSData dataWithContentsOfURL:web_url];
            
            id result       = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            
            handler(result,error);
        }
        @catch (NSException *exception) {
            NSLog(@"Des %@ Reason %@", exception.description, exception.reason);
            
            if([exception.reason isEqualToString:@"data parameter is nil"])
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[AppDelegate sharedInstance] showAlertMessage:@"Data Loading Failed. Please check your internet status on VPN connection & try again"];
                    
                });
            else
            {
                NSLog(@"%@",exception.reason);
            }
        }
    }
}

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
                   FromUrl:(NSString *)url :(RequestOnCompletion)handler{
    
    if (handler){
        @try {
            
            NSError *error;
            
            
            NSURL *web_url = [NSURL URLWithString:url];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:web_url];
            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
            [request setHTTPShouldHandleCookies:NO];
            [request setTimeoutInterval:180];
            [request setHTTPMethod:@"POST"];
            
            NSString *boundary = @"uwhQ9Ho7y873Ha";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
            [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"isFinalSubmit"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"%@", isFinalSubmit] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            // Ticket ID
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"ticket_id"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"%@", ticket_id] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            // Initial 1
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"initials1", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(initial1, 1.0)]; 
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // Initial 2
            /*
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"initials2", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(initial2, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            */
            // Initial 3
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"initials3", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(initial3, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // Signature
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"signature", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(signature, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //rt_trainer_signature
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"rt_trainer_signature", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(rt_trainer_signature, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //rt_patient_signature
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"rt_patient_signature", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(rt_patient_signature, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //final_signature
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"final_signature", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(final_signature, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //mrr_legal_auth_sign
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"mrr_legal_auth_sign", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(mrr_legal_auth_sign, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //mrr_witness_sign
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"mrr_witness_sign", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(mrr_witness_sign, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //pip_legal_auth_rep_sign
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"pip_legal_auth_rep_sign", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(pip_legal_auth_rep_sign, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //cig_pt_sign
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"cig_pt_sign", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(cig_pt_sign, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //cig_representative_sign
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"cig_representative_sign", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(cig_representative_sign, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //sms_pt_sign
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"sms_pt_sign", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(sms_pt_sign, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //sms_representative_sign
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                               @"sms_representative_sign", @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:UIImageJPEGRepresentation(sms_representative_sign, 1.0)];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            // cig_include
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"cig_include"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"%@", cig_include] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            // sms_include
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"sms_include"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"%@", sms_include] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            // testing_emails // To remove later 
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"testing_emails"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"%@", @"0"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            
            [request setHTTPBody:body];

            
            NSError *errorReturned = nil;
            NSURLResponse *theResponse = [[NSURLResponse alloc]init];
            NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&theResponse
                                                             error:&errorReturned];
            
            //id result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            /*            __block id dataResponse;
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                dataResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                NSLog(@"dataResponds=%@",dataResponse);
                
            }] resume];
            */
            handler(result,error);
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"Des %@ Reason %@", exception.description, exception.reason);
            
            if([exception.reason isEqualToString:@"data parameter is nil"])
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[AppDelegate sharedInstance] showAlertMessage:@"Please check your internet status on VPN connection & try again"];
                    [[AppDelegate sharedInstance] removeCustomLoader];
                });
            
            else
            {
                NSLog(@"%@",exception.reason);
            }
        }
    }
}


+(void)callNIVWebService:(NSDictionary*)formData withHTTPMethod:(NSString*)method FromUrl:(NSString *)url :(RequestOnCompletion)handler{
    
    if (handler){
        @try {
            NSError *error;
            NSURL *web_url = [NSURL URLWithString:url];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:web_url];
            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
            [request setHTTPShouldHandleCookies:NO];
            [request setTimeoutInterval:360];
            [request setHTTPMethod:method];
            
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", @"uwhQ9Ho7y873Ha"];
            [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            __block NSMutableData *body = [NSMutableData data];
            [formData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
                if ([value isKindOfClass:[UIImage class]]) {
                    //body = [Utils appendImageWithKey:key andImageName:value];
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", @"uwhQ9Ho7y873Ha"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", key, @"JPEG"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:UIImageJPEGRepresentation(value, 1.0)];
                    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                }
                else{
                    //body = [Utils appendTextWithKey:key andValue:value];
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", @"uwhQ9Ho7y873Ha"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"%@", value] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                }
            }];
            
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", @"uwhQ9Ho7y873Ha"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSLog(@"HTTP API: %@", [web_url absoluteString]);
            
            NSString *postLength = [NSString stringWithFormat:@"%ld", (long)[body length]];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:body];
            
            NSError *errorReturned = nil;
            NSURLResponse *theResponse = [[NSURLResponse alloc]init];
            NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&theResponse
                                                             error:&errorReturned];
            
            id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            handler(result,error);
        }
        @catch (NSException *exception) {
            
            NSLog(@"Des %@ Reason %@", exception.description, exception.reason);
            
            if([exception.reason isEqualToString:@"data parameter is nil"])
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[AppDelegate sharedInstance] showAlertMessage:@"Please check your internet status on VPN connection & try again"];
                    [[AppDelegate sharedInstance] removeCustomLoader];
                });
            
            else
            {
                NSLog(@"%@",exception.reason);
            }
        }
    }
}

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
    
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}



@end
