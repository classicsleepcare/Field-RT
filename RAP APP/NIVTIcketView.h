//
//  NIVTIcketView.h
//  RT APP
//
//  Created by Anil Prasad on 12/5/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIVTIcketView : NSObject
{
    NSDictionary *dictionary;
}

#pragma mark - Retrive Setup Ticket Data
-(NSDictionary*)retriveSetupTicketData:(NSDictionary*)dict;

#pragma mark - Patient Details
-(NSDictionary*)getPatientDetails:(NSString*)pt_id;

#pragma mark - RT Listing
-(NSDictionary*)callRTListing:(NSDictionary*)dict;

#pragma mark - Patient Setup Ticket
-(NSDictionary*)submitSetupTicket:(NSDictionary*)dict;

#pragma mark - Respiratory Care Informed Consent Clinical Services
-(NSDictionary*)respCareAPI:(NSDictionary*)dict;

#pragma mark - Caregiver Competency Checklist (Trilogy)

-(NSDictionary*)trilogyCareCompAPI:(NSDictionary*)dict;

#pragma mark - Caregiver Competency Checklist (Astral)

-(NSDictionary*)astralCareCompAPI:(NSDictionary*)dict;

#pragma mark - Home Safety Assessment

-(NSDictionary*)homeSafeAPI:(NSDictionary*)dict;

#pragma mark - New Patient Medical History

-(NSDictionary*)newPatientHIstoryAPI:(NSDictionary*)dict;

#pragma mark - Patient Discharge Summary

-(NSDictionary*)patientDisAPI:(NSDictionary*)dict;

#pragma mark - Ventilator Performance Record (Trilogy)

-(NSDictionary*)trilogyVentPerfAPI:(NSDictionary*)dict;

#pragma mark - Ventilator Performance Record (Astral)

-(NSDictionary*)astralVentPerfAPI:(NSDictionary*)dict;

#pragma mark - Patient Progress Notes

-(NSDictionary*)patientProgAPI:(NSDictionary*)dict;

#pragma mark - Take the COPD Assessment Test

-(NSDictionary*)takeCOPDAPI:(NSDictionary*)dict;

#pragma mark - New Patient Medication Profile

-(NSDictionary*)newPtProfileAPI:(NSDictionary*)dict;

@end
