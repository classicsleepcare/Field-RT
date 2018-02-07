//
//  NIVTIcketView.m
//  RT APP
//
//  Created by Anil Prasad on 12/5/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVTIcketView.h"

@implementation NIVTIcketView

#pragma mark - Retrive Setup Ticket Data
-(NSDictionary*)retriveSetupTicketData:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivSetupTicketDetail;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - Patient Details
-(NSDictionary*)getPatientDetails:(NSString*)pt_id{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_patientDetail,pt_id];
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    
    return dictionary;
}
#pragma mark - RT Listing

-(NSDictionary*)callRTListing:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivRTListing;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"GET" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}


#pragma mark - Patient Setup Ticket

-(NSDictionary*)submitSetupTicket:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivSetupTicket;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - Respiratory Care Informed Consent Clinical Services
-(NSDictionary*)respCareAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivRespCare;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - Caregiver Competency Checklist (Trilogy)

-(NSDictionary*)trilogyCareCompAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivTrilogyCareComp;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - Caregiver Competency Checklist (Astral)

-(NSDictionary*)astralCareCompAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivAstralCareComp;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - Home Safety Assessment

-(NSDictionary*)homeSafeAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivHomeSafe;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - New Patient Medical History

-(NSDictionary*)newPatientHIstoryAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivNewPtHistory;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - Patient Discharge Summary

-(NSDictionary*)patientDisAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivPtDis;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - Ventilator Performance Record (Trilogy)

-(NSDictionary*)trilogyVentPerfAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivTrilogyVentPerf;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - Ventilator Performance Record (Astral)

-(NSDictionary*)astralVentPerfAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivAstralVentPerf;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - Patient Progress Notes

-(NSDictionary*)patientProgAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivPtProg;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - Take the COPD Assessment Test

-(NSDictionary*)takeCOPDAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivTakeCOPD;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

#pragma mark - New Patient Medication Profile

-(NSDictionary*)newPtProfileAPI:(NSDictionary*)dict{
    dictionary = nil;
    
    NSString *urlString = url_nivNewPtProfile;
    
    [WebserviceClass callNIVWebService:dict withHTTPMethod:@"POST" FromUrl:urlString :^(id result, NSError *error) {
        if (error) {
            dictionary = nil;
        }
        else
        {
            dictionary = result;
        }
    }];
    
    return dictionary;
}

@end
