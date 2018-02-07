//
//  AddDoctorView.m
//  RAP APP
//
//  Created by Anil Prasad on 5/1/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "AddDoctorView.h"
#import "WebserviceClass.h"
@implementation AddDoctorView

-(NSDictionary *)getAllFacilty:(NSString *)ID
{
    dictionary = nil;
     NSString *str_url = [NSString stringWithFormat:url_allFacility,ID];
    
    NSLog (@"url_allFacility here:%@",str_url);
    [WebserviceClass getParseDataFromUrl:str_url:^(id result, NSError *error) {
        if (error) {
            dictionary =nil;
        }
        else
        {
            dictionary= result;
        }
    }
     
     ];
    return dictionary;
   
}
-(NSDictionary *)getAllDoctors:(NSString *)ID
{
    dictionary = nil;
    NSLog(@"id is :%@",ID);
      NSString *str_url = [NSString stringWithFormat:url_allDoctors,ID];
    
    NSLog (@"url_allDoctors:%@",str_url);
    [WebserviceClass getParseDataFromUrl:str_url :^(id result, NSError *error) {
        if (error) {
            dictionary =nil;
        }
        else
        {
            dictionary= result;
        }
    }
     
     ];
    return dictionary;
}
-(NSDictionary *)getFacilityDetailForId:(NSString *)ID
{
    dictionary = nil;
    NSString *str_url = [NSString stringWithFormat:url_facilityDetail,ID];
    [WebserviceClass getParseDataFromUrl:str_url :^(id result, NSError *error) {
        if (error) {
            dictionary =nil;
        }
        else
        {
            dictionary= result;
        }
    }
     
     ];
    return dictionary;
    

}
-(NSDictionary*)getDoctorDetailForId:(NSString*)ID
{
    dictionary = nil;
    NSString *str_url = [NSString stringWithFormat:url_allDoctorsDetail,ID];
    [WebserviceClass getParseDataFromUrl:str_url :^(id result, NSError *error) {
        if (error) {
            dictionary =nil;
        }
        else
        {
            dictionary= result;
        }
    }
     
     ];
    return dictionary;
}
-(NSDictionary *)addNewDoctorWithId:(NSString *)ID FirstName:(NSString *)firstName MiddleName:(NSString *)middleName LastName:(NSString *)lastName NPI:(NSString *)npi License:(NSString *)license Phone:(NSString *)phone Confax:(NSString *)confFax DrContact:(NSString *)dr_contact Address:(NSString *)address City:(NSString *)city State:(NSString *)state Zip:(NSString *)zip Upin:(NSString *)upin Nuance:(NSString *)nuance Notes:(NSString *)notes DoctorFacilityID:(NSString *)dr_fac_id ReferralType:(NSString*)dr_ref_type ReferralOtherType:(NSString*)ref_Other_type DrMachinePref:(NSString*)dr_machine_pref DrMachineOtherPref:(NSString*)dr_machine_other DrMaskPref:(NSString*)dr_Mask_pref DrMaskOtherPref:(NSString*)dr_mask_other DrModem:(NSString*)dr_modem DrEasyModeCare:(NSString*)dr_md_access Dr14:(NSString*)dr_14 Dr25:(NSString*)dr_25 Dr30:(NSString*)dr_30 Dr45:(NSString*)dr_45 Dr60:(NSString*)dr_60 Dr90:(NSString*)dr_90 Dr120:(NSString*)dr_120 DrOtherIns:(NSString*)dr_other_instr CurrentDate:(NSString*)currentdate DrID:(NSString*)dr_id
{
    dictionary = nil;
    NSString *str_url = [NSString stringWithFormat:url_addNewDoctor,ID,firstName,middleName,lastName,npi,license,phone,confFax,dr_contact,address,city,state,zip,upin,nuance,notes,dr_fac_id,dr_ref_type,ref_Other_type,dr_machine_pref,dr_machine_other,dr_Mask_pref,dr_mask_other,dr_modem,dr_md_access,dr_14,dr_25,dr_30,dr_45,dr_60,dr_90,dr_120,dr_other_instr,currentdate,dr_id];
    NSLog(@"url_addNewDoctor:%@",str_url);
    [WebserviceClass getParseDataFromUrl:str_url :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }
     
     ];
    return dictionary;
    
    
}-(NSDictionary *)addNewFacilityWithId:(NSString *)ID FacNickNaem:(NSString*)fac_nickName FacName:(NSString *)facName FacPhone:(NSString*)fac_Phone  Contact:(NSString *)fac_contact Address:(NSString *)address City:(NSString *)city State:(NSString *)state Zip:(NSString *)zip Nuance:(NSString *)nuance Notes:(NSString *)notes FacReferralType:(NSString*)fac_ref_type FacReferralOther:(NSString*)raf_other FacMachineType:(NSString*)machine_type FacMachineOther:(NSString*)machine_other FacMaskType:(NSString*)mask_type facMaskOther:(NSString*)mask_other
                             FacModem:(NSString*)modem FacMDAccess:(NSString*)md Fac14:(NSString*)fac_14 Fac25:(NSString*)fac_25 Fac30:(NSString*)fac_30 Fac45:(NSString*)fac_45 Fac60:(NSString*)fac_60 Fac90:(NSString*)fac_90 Fac120:(NSString*)fac_120 FacOtherIns:(NSString*)instruction FacilityId:(NSString*)fac_id FacFax:(NSString *)fac_fax
{
    dictionary = nil;
    NSString *str_url = [NSString stringWithFormat:url_addNewFacility,ID,fac_nickName,facName,fac_Phone,fac_contact,address,city,state,zip,nuance,notes,fac_ref_type,raf_other,machine_type,machine_other,mask_type,mask_other,modem,md,fac_14,fac_25,fac_30,fac_45,fac_60,fac_90,fac_120,instruction,fac_id,fac_fax];
    [WebserviceClass getParseDataFromUrl:str_url :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }
     
     ];
    return dictionary;
}
-(NSDictionary *)addNewDoctorAndNewFacilityWithId:(NSString*)ID FirstName:(NSString*)firstName MiddleName:(NSString*)middleName LastName:(NSString*)lastName NPI:(NSString*)npi License:(NSString*)license Phone:(NSString*)phone Confax:(NSString*)confFax DrContact:(NSString*)dr_contact Address:(NSString*)address City:(NSString*)city State:(NSString*)state Zip:(NSString*)zip Upin:(NSString*)upin Nuance:(NSString*)nuance Notes:(NSString*)notes ReferralType:(NSString*)dr_ref_type ReferralOtherType:(NSString*)ref_Other_type DrMachinePref:(NSString*)dr_machine_pref DrMachineOtherPref:(NSString*)dr_machine_other DrMaskPref:(NSString*)dr_Mask_pref DrMaskOtherPref:(NSString*)dr_mask_other DrModem:(NSString*)dr_modem DrEasyModeCare:(NSString*)dr_md_access Dr14:(NSString*)dr_14 Dr25:(NSString*)dr_25 Dr30:(NSString*)dr_30 Dr45:(NSString*)dr_45 Dr60:(NSString*)dr_60 Dr90:(NSString*)dr_90 Dr120:(NSString*)dr_120 DrOtherIns:(NSString*)dr_other_instr CurrentDate:(NSString*)currentdate FacNickName:(NSString*)fac_nickName FacName:(NSString*)facName FacPhone:(NSString*)fac_Phone Contact:(NSString*)fac_contact Address:(NSString*)fac_address City:(NSString*)fac_city State:(NSString*)fac_state Zip:(NSString*)fac_zip Nuance:(NSString*)fac_nuance Notes:(NSString*)fac_notes FacReferralType:(NSString*)fac_ref_type FacReferralOther:(NSString*)raf_other FacMachineType:(NSString*)machine_type FacMachineOther:(NSString*)machine_other FacMaskType:(NSString*)mask_type facMaskOther:(NSString*)mask_other
                                         FacModem:(NSString*)modem FacMDAccess:(NSString*)md Fac14:(NSString*)fac_14 Fac25:(NSString*)fac_25 Fac30:(NSString*)fac_30 Fac45:(NSString*)fac_45 Fac60:(NSString*)fac_60 Fac90:(NSString*)fac_90 Fac120:(NSString*)fac_120 FacOtherIns:(NSString*)instruction DrId:(NSString*)dr_id FacilityId:(NSString*)fac_id
{
    dictionary = nil;
    NSString *str_url = [NSString stringWithFormat:url_addNewDoctorAndFacility,ID,firstName,middleName,lastName,npi,license,phone,confFax,dr_contact,address,city,state,zip,upin,nuance,notes,dr_ref_type,ref_Other_type,dr_machine_pref,dr_machine_other,dr_Mask_pref,dr_mask_other,dr_modem,dr_md_access,dr_14,dr_25,dr_30,dr_45,dr_60,dr_90,dr_120,dr_other_instr,currentdate,fac_nickName,facName,fac_Phone,fac_contact,fac_address,fac_city,fac_state,fac_zip,fac_nuance,fac_notes,fac_ref_type,raf_other,machine_type,machine_other,mask_type,mask_other,modem,md,fac_14,fac_25,fac_30,fac_45,fac_60,fac_90,fac_120,instruction,dr_id,fac_id];
    [WebserviceClass getParseDataFromUrl:str_url :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }
     
     ];
    return dictionary;
}
@end
