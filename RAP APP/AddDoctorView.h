//
//  AddDoctorView.h
//  RAP APP
//
//  Created by Anil Prasad on 5/1/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddDoctorView : NSObject
{
     NSDictionary *dictionary;
}
-(NSDictionary*)getAllFacilty:(NSString*)ID;
-(NSDictionary*)getAllDoctors:(NSString *)ID;
-(NSDictionary*)getFacilityDetailForId:(NSString*)ID;
-(NSDictionary*)getDoctorDetailForId:(NSString*)ID;

-(NSDictionary*)addNewDoctorWithId:(NSString*)ID FirstName:(NSString*)firstName MiddleName:(NSString*)middleName LastName:(NSString*)lastName NPI:(NSString*)npi License:(NSString*)license Phone:(NSString*)phone Confax:(NSString*)confFax DrContact:(NSString*)dr_contact Address:(NSString*)address City:(NSString*)city State:(NSString*)state Zip:(NSString*)zip Upin:(NSString*)upin Nuance:(NSString*)nuance Notes:(NSString*)notes DoctorFacilityID:(NSString*)dr_fac_id ReferralType:(NSString*)dr_ref_type ReferralOtherType:(NSString*)ref_Other_type DrMachinePref:(NSString*)dr_machine_pref DrMachineOtherPref:(NSString*)dr_machine_other DrMaskPref:(NSString*)dr_Mask_pref DrMaskOtherPref:(NSString*)dr_mask_other DrModem:(NSString*)dr_modem DrEasyModeCare:(NSString*)dr_md_access Dr14:(NSString*)dr_14 Dr25:(NSString*)dr_25 Dr30:(NSString*)dr_30 Dr45:(NSString*)dr_45 Dr60:(NSString*)dr_60 Dr90:(NSString*)dr_90 Dr120:(NSString*)dr_120 DrOtherIns:(NSString*)dr_other_instr CurrentDate:(NSString*)currentdate DrID:(NSString*)dr_id;


-(NSDictionary*)addNewFacilityWithId:(NSString*)ID FacNickNaem:(NSString*)fac_nickName  FacName:(NSString*)facName FacPhone:(NSString*)fac_Phone Contact:(NSString*)fac_contact Address:(NSString*)address City:(NSString*)city State:(NSString*)state Zip:(NSString*)zip Nuance:(NSString*)nuance Notes:(NSString*)notes FacReferralType:(NSString*)fac_ref_type FacReferralOther:(NSString*)raf_other FacMachineType:(NSString*)machine_type FacMachineOther:(NSString*)machine_other FacMaskType:(NSString*)mask_type facMaskOther:(NSString*)mask_other
                            FacModem:(NSString*)modem FacMDAccess:(NSString*)md Fac14:(NSString*)fac_14 Fac25:(NSString*)fac_25 Fac30:(NSString*)fac_30 Fac45:(NSString*)fac_45 Fac60:(NSString*)fac_60 Fac90:(NSString*)fac_90 Fac120:(NSString*)fac_120 FacOtherIns:(NSString*)instruction FacilityId:(NSString*)fac_id FacFax:(NSString *)fac_fax;

-(NSDictionary*)addNewDoctorAndNewFacilityWithId:(NSString*)ID FirstName:(NSString*)firstName MiddleName:(NSString*)middleName LastName:(NSString*)lastName NPI:(NSString*)npi License:(NSString*)license Phone:(NSString*)phone Confax:(NSString*)confFax DrContact:(NSString*)dr_contact Address:(NSString*)address City:(NSString*)city State:(NSString*)state Zip:(NSString*)zip Upin:(NSString*)upin Nuance:(NSString*)nuance Notes:(NSString*)notes ReferralType:(NSString*)dr_ref_type ReferralOtherType:(NSString*)ref_Other_type DrMachinePref:(NSString*)dr_machine_pref DrMachineOtherPref:(NSString*)dr_machine_other DrMaskPref:(NSString*)dr_Mask_pref DrMaskOtherPref:(NSString*)dr_mask_other DrModem:(NSString*)dr_modem DrEasyModeCare:(NSString*)dr_md_access Dr14:(NSString*)dr_14 Dr25:(NSString*)dr_25 Dr30:(NSString*)dr_30 Dr45:(NSString*)dr_45 Dr60:(NSString*)dr_60 Dr90:(NSString*)dr_90 Dr120:(NSString*)dr_120 DrOtherIns:(NSString*)dr_other_instr CurrentDate:(NSString*)currentdate FacNickName:(NSString*)fac_nickName FacName:(NSString*)facName FacPhone:(NSString*)fac_Phone Contact:(NSString*)fac_contact Address:(NSString*)fac_address City:(NSString*)fac_city State:(NSString*)fac_state Zip:(NSString*)fac_zip Nuance:(NSString*)fac_nuance Notes:(NSString*)fac_notes FacReferralType:(NSString*)fac_ref_type FacReferralOther:(NSString*)raf_other FacMachineType:(NSString*)machine_type FacMachineOther:(NSString*)machine_other FacMaskType:(NSString*)mask_type facMaskOther:(NSString*)mask_other
                                        FacModem:(NSString*)modem FacMDAccess:(NSString*)md Fac14:(NSString*)fac_14 Fac25:(NSString*)fac_25 Fac30:(NSString*)fac_30 Fac45:(NSString*)fac_45 Fac60:(NSString*)fac_60 Fac90:(NSString*)fac_90 Fac120:(NSString*)fac_120 FacOtherIns:(NSString*)instruction DrId:(NSString*)dr_id FacilityId:(NSString*)fac_id;

@end
/*
rep_id=110&dr_first=Amit&dr_middle=Kumar&dr_last=Sri&dr_fac_id=&dr_npi=dr_npi_text&dr_license=dr_license_text&dr_phone=9878006768&dr_conf_fax=12332234535&dr_contact=doctor_contact_person&dr_address=dr_this_address_info&dr_city=California&dr_state=CA&dr_zip=160055&dr_upin=123456&dr_nuance=dr_nuance_Text_goes_here_&dr_notes=dr_additional_notes_goes_here=&dr_ref_type=HST&dr_other_text=dr_other_text_goes_here&dr_machine_preference=ResMed&dr_machine_preference_text=dr_machine_preference_text_goes_here&dr_mask_preference=dr_mask_preference_goes_here&dr_mask_preference_text=dr_mask_preference_text_goes_here&dr_modem=1&dr_md_easycare=1&dr_14=1&dr_25=1&dr_30=1&dr_45=1&dr_60=1&dr_90=1&dr_120=1&dr_other_instructions=dr_other_instructions_text_goes_here&current_date=26-06-2014&fac_name=Amit_Fac&fac_full_name=Amit_full_fac&fac_phone=9878006768&fac_contact=fac_contact_person&fac_address=fac_address_here&fac_city=Jaipur&fac_state=rj&fac_zip=273001&fac_nuance=fac_nuance_text_here&fac_notes=fac_additional_text_notes_here&&fac_ref_type=&fac_other_text=&fac_machine_preference=&fac_machine_preference_text=&fac_mask_preference=&fac_mask_preference_text=&fac_modem=yes&fac_md_easycare=yes&fac_downloads_14=1&fac_downloads_25=1&fac_downloads_30=1&fac_downloads_45=1&fac_downloads_60=1&fac_downloads_90=1&fac_downloads_120=1&fac_other_instructions=fac_other_instructions_goes_here
 
 */