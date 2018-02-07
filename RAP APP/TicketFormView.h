//
//  TicketFormView.h
//  RT APP
//
//  Created by Anil Prasad on 30/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketFormView : NSObject{
    NSDictionary *dictionary;
}

-(NSDictionary*)getMachineListing:(NSString*)ID OfVendor:(NSString*)vendor_id;

-(NSDictionary*)getArrayOfMachines:(NSString*)rt_Id vendorId:(NSString*)vendorId;

-(NSDictionary*)getArraysOfSerialNumbers:(NSString*)RT itemID:(NSString*)ID;

-(NSDictionary*)getArrayOfSupplyItems:(NSString*)machineName;

// get arrays for all the dropdowns present in Ticket
-(NSDictionary*)getArraysForDropdowns:(NSString*)ID;

// get items list of selected Ticket
-(NSDictionary*)getItemsListOfSelectedTicket:(NSString*)ID;

// fetch all the items for search tableview
-(NSDictionary*)getAllItemsListOfRT:(NSString*)ID;

// Searching items in all items list
-(NSMutableArray*)startSearchingFromItemsList:(NSMutableArray*)array keyword:(NSString*)keyword;

// RT Inventory Machines List
-(NSDictionary*)getStockTakeMachinesListOfRT:(NSString*)rt_id;

// RT Inventory Count
-(NSDictionary*)getInventoryCountsOfRT:(NSString*)rt_id item_id:(NSString*)item_id;

// Submit Setup Ticket

-(NSDictionary*)submitTicketWithID:(NSString*)ticket_id
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
                       sms_include:(NSString*)sms_include;

-(NSDictionary*)submitTicketPtId:(NSString*)pt_id
                          status:(NSString*)status
                        pt_first:(NSString*)pt_first
                         pt_last:(NSString*)pt_last
                          gender:(NSString*)gender
                         spanish:(NSString*)spanish
                          pt_add:(NSString*)pt_add
                         pt_city:(NSString*)pt_city
                        pt_state:(NSString*)pt_state
                          pt_zip:(NSString*)pt_zip
                         pt_home:(NSString*)pt_home
                         pt_cell:(NSString*)pt_cell
                         pt_work:(NSString*)pt_work
                        pt_email:(NSString*)pt_email
                         machine:(NSString*)machine
                           cpap1:(NSString*)cpap1
                          level1:(NSString*)level1
                            cpap:(NSString*)cpap
                           level:(NSString*)level
                    manufacturer:(NSString*)manufacturer
                           model:(NSString*)model
                          serial:(NSString*)serial
                              cm:(NSString*)cm
                       ramp_time:(NSString*)ramp_time
                            rate:(NSString*)rate
                           modem:(NSString*)modem
                      modem_type:(NSString*)modem_type
                    modem_serial:(NSString*)modem_serial
                       hum_modem:(NSString*)hum_modem
                hum_manufacturer:(NSString*)hum_manufacturer
                      hum_serial:(NSString*)hum_serial
                            mask:(NSString*)mask
                       mask_type:(NSString*)mask_type
                       mask_name:(NSString*)mask_name
                         mask_id:(NSString*)mask_id
                            date:(NSString*)date
                      care_first:(NSString*)care_first
                       care_last:(NSString*)care_last
                    care_address:(NSString*)care_address
                       care_city:(NSString*)care_city
                      care_state:(NSString*)care_state
                        care_zip:(NSString*)care_zip
                      care_phone:(NSString*)care_phone
                      care_email:(NSString*)care_email
                    cpap_item_id:(NSString*)cpap_item_id
                   modem_item_id:(NSString*)modem_item_id
                     hum_item_id:(NSString*)hum_item_id
           place_of_service_text:(NSString*)place_of_service_text
                other_instructed:(NSString*)other_instructed
                 rt_trainer_name:(NSString*)rt_trainer_name
                reason_for_visit:(NSString*)reason_for_visit
                           goal1:(NSString*)goal1
                           goal2:(NSString*)goal2
                           goal1:(NSString*)goal3
                           goal1:(NSString*)goal4
                           goal1:(NSString*)goal5
                           goal1:(NSString*)goal6
                           goal1:(NSString*)goal7
                           goal1:(NSString*)goal8
                           goal1:(NSString*)goal9
                           goal1:(NSString*)goal10
                           goal1:(NSString*)goal11
                           goal1:(NSString*)goal12
                           goal1:(NSString*)goal13
                           goal1:(NSString*)goal14
                           goal1:(NSString*)goal15
                           goal1:(NSString*)goal16
                           goal1:(NSString*)goal17
                           goal1:(NSString*)goal18
                           goal1:(NSString*)goal19
                           goal1:(NSString*)goal20
                           goal1:(NSString*)goal21
                           goal1:(NSString*)goal22
                      rt_summary:(NSString*)rt_summary
               patient_caregiver:(NSString*)patient_caregiver
                    relationship:(NSString*)relationship
                 rt_trainer_date:(NSString*)rt_trainer_date
                    patient_date:(NSString*)patient_date
                       json_item:(NSString*)json_item
             json_discarded_item:(NSString*)json_discarded_item
                 json_adtnl_item:(NSString*)json_adtnl_item
                           notes:(NSString*)notes
                    machine_type:(NSString*)machine_type
                          pt_dob:(NSString*)pt_dob
                         cpap_cm:(NSString*)cpap_cm
                  cpap_ramp_time:(NSString*)cpap_ramp_time
             cpap_auto_ramp_time:(NSString*)cpap_auto_ramp_time
          cpap_auto_low_pressure:(NSString*)cpap_auto_low_pressure
         cpap_auto_high_pressure:(NSString*)cpap_auto_high_pressure
                 bi_st_ramp_time:(NSString*)bi_st_ramp_time
                      bi_st_ipap:(NSString*)bi_st_ipap
                      bi_st_epap:(NSString*)bi_st_epap
               bi_auto_ramp_time:(NSString*)bi_auto_ramp_time
                bi_auto_epap_min:(NSString*)bi_auto_epap_min
                bi_auto_epap_max:(NSString*)bi_auto_epap_max
    bi_auto_pressure_support_min:(NSString*)bi_auto_pressure_support_min
    bi_auto_pressure_support_max:(NSString*)bi_auto_pressure_support_max
            bi_auto_sv_ramp_time:(NSString*)bi_auto_sv_ramp_time
             bi_auto_sv_epap_min:(NSString*)bi_auto_sv_epap_min
             bi_auto_sv_ipap_max:(NSString*)bi_auto_sv_ipap_max
 bi_auto_sv_pressure_support_min:(NSString*)bi_auto_sv_pressure_support_min
 bi_auto_sv_pressure_support_max:(NSString*)bi_auto_sv_pressure_support_max
          bi_auto_sv_backup_rate:(NSString*)bi_auto_sv_backup_rate
 bi_auto_sv_max_pressure_support:(NSString*)bi_auto_sv_max_pressure_support
            bi_auto_st_ramp_time:(NSString*)bi_auto_st_ramp_time
                 bi_auto_st_ipap:(NSString*)bi_auto_st_ipap
                 bi_auto_st_epap:(NSString*)bi_auto_st_epap
          bi_auto_st_backup_rate:(NSString*)bi_auto_st_backup_rate
                     auth_person:(NSString*)auth_person
                auth_person_name:(NSString*)auth_person_name
                email_to_patient:(NSString*)email_to_patient
                  picked_machine:(NSString*)picked_machine
             picked_machine_name:(NSString*)picked_machine_name
             picked_manufacturer:(NSString*)picked_manufacturer
           picked_machine_serial:(NSString*)picked_machine_serial
               picked_hum_serial:(NSString*)picked_hum_serial
             picked_modem_serial:(NSString*)picked_modem_serial
                   isFinalSubmit:(NSString*)isFinalSubmit
           mrr_medical_agreement:(NSString*)mrr_medical_agreement
             mrr_legal_auth_name:(NSString*)mrr_legal_auth_name
        mrr_legal_auth_sign_date:(NSString*)mrr_legal_auth_sign_date
           mrr_witness_sign_date:(NSString*)mrr_witness_sign_date
                       pip_email:(NSString*)pip_email
                       pip_phone:(NSString*)pip_phone
                pip_notification:(NSString*)pip_notification
    pip_legal_auth_rep_sign_date:(NSString*)pip_legal_auth_rep_sign_date
         pip_legal_auth_rep_name:(NSString*)pip_legal_auth_rep_name
              csc_clinician_name:(NSString*)csc_clinician_name
         ordering_physician_name:(NSString*)ordering_physician_name
                    pap_location:(NSString*)pap_location
                          goal23:(NSString*)goal23
                          goal24:(NSString*)goal24
                   add_item_need:(NSString*)add_item_need

          pip_notification_email:(NSString*)pip_notification_email
           pip_notification_text:(NSString*)pip_notification_text
          pip_notification_voice:(NSString*)pip_notification_voice

                  cig_setup_date:(NSString*)cig_setup_date
               cig_setup_perform:(NSString*)cig_setup_perform
           cig_emergency_contact:(NSString*)cig_emergency_contact
              cig_physician_name:(NSString*)cig_physician_name
             cig_physician_phone:(NSString*)cig_physician_phone
             cig_primary_contact:(NSString*)cig_primary_contact
           cig_secondary_contact:(NSString*)cig_secondary_contact
               cig_patient_email:(NSString*)cig_patient_email
                        cig_epap:(NSString*)cig_epap
                cig_auto_pap_min:(NSString*)cig_auto_pap_min
                cig_auto_pap_max:(NSString*)cig_auto_pap_max
               cig_bi_level_epap:(NSString*)cig_bi_level_epap
               cig_bi_level_ipap:(NSString*)cig_bi_level_ipap
          cig_auto_bi_level_epap:(NSString*)cig_auto_bi_level_epap
          cig_auto_bi_level_ipap:(NSString*)cig_auto_bi_level_ipap
             cig_bi_level_st_min:(NSString*)cig_bi_level_st_min
             cig_bi_level_st_max:(NSString*)cig_bi_level_st_max
              cig_bi_level_st_rr:(NSString*)cig_bi_level_st_rr
                 cig_auto_sv_min:(NSString*)cig_auto_sv_min
                 cig_auto_sv_max:(NSString*)cig_auto_sv_max
                cig_auto_sv_epap:(NSString*)cig_auto_sv_epap
                  cig_make_model:(NSString*)cig_make_model
                      cig_serial:(NSString*)cig_serial
              cig_mask_type_name:(NSString*)cig_mask_type_name
                 cig_wireless_id:(NSString*)cig_wireless_id
                   cig_mask_size:(NSString*)cig_mask_size
            cig_pt_email_monitor:(NSString*)cig_pt_email_monitor
               cig_provider_name:(NSString*)cig_provider_name
                cig_pt_sign_date:(NSString*)cig_pt_sign_date
               cig_provider_date:(NSString*)cig_provider_date
          cig_additional_comment:(NSString*)cig_additional_comment
                        cig_unit:(NSString*)cig_unit
                    cig_rate_off:(NSString*)cig_rate_off
                   cig_rate_auto:(NSString*)cig_rate_auto
                  cig_rate_other:(NSString*)cig_rate_other
                  cig_humidifier:(NSString*)cig_humidifier
                        cig_mask:(NSString*)cig_mask
                  cig_sms_tagged:(NSString*)cig_sms_tagged
              cig_comp_meas_card:(NSString*)cig_comp_meas_card
     cig_comp_meas_modemwireless:(NSString*)cig_comp_meas_modemwireless
               cig_comp_meas_usb:(NSString*)cig_comp_meas_usb
                   cig_agreement:(NSString*)cig_agreement


                  sms_setup_date:(NSString*)sms_setup_date
               sms_setup_perform:(NSString*)sms_setup_perform
           sms_emergency_contact:(NSString*)sms_emergency_contact
              sms_physician_name:(NSString*)sms_physician_name
             sms_physician_phone:(NSString*)sms_physician_phone
             sms_primary_contact:(NSString*)sms_primary_contact
           sms_secondary_contact:(NSString*)sms_secondary_contact
               sms_patient_email:(NSString*)sms_patient_email
                        sms_epap:(NSString*)sms_epap
                sms_auto_pap_min:(NSString*)sms_auto_pap_min
                sms_auto_pap_max:(NSString*)sms_auto_pap_max
               sms_bi_level_epap:(NSString*)sms_bi_level_epap
               sms_bi_level_ipap:(NSString*)sms_bi_level_ipap
          sms_auto_bi_level_epap:(NSString*)sms_auto_bi_level_epap
          sms_auto_bi_level_ipap:(NSString*)sms_auto_bi_level_ipap
             sms_bi_level_st_min:(NSString*)sms_bi_level_st_min
             sms_bi_level_st_max:(NSString*)sms_bi_level_st_max
              sms_bi_level_st_rr:(NSString*)sms_bi_level_st_rr
                 sms_auto_sv_min:(NSString*)sms_auto_sv_min
                 sms_auto_sv_max:(NSString*)sms_auto_sv_max
                sms_auto_sv_epap:(NSString*)sms_auto_sv_epap
                  sms_make_model:(NSString*)sms_make_model
                      sms_serial:(NSString*)sms_serial
              sms_mask_type_name:(NSString*)sms_mask_type_name
                 sms_wireless_id:(NSString*)sms_wireless_id
                   sms_mask_size:(NSString*)sms_mask_size
            sms_pt_email_monitor:(NSString*)sms_pt_email_monitor
               sms_provider_name:(NSString*)sms_provider_name
                sms_pt_sign_date:(NSString*)sms_pt_sign_date
               sms_provider_date:(NSString*)sms_provider_date
          sms_additional_comment:(NSString*)sms_additional_comment
                        sms_unit:(NSString*)sms_unit
                    sms_rate_off:(NSString*)sms_rate_off
                   sms_rate_auto:(NSString*)sms_rate_auto
                  sms_rate_other:(NSString*)sms_rate_other
                  sms_humidifier:(NSString*)sms_humidifier
                        sms_mask:(NSString*)sms_mask
                  sms_sms_tagged:(NSString*)sms_sms_tagged
              sms_comp_meas_card:(NSString*)sms_comp_meas_card
     sms_comp_meas_modemwireless:(NSString*)sms_comp_meas_modemwireless
               sms_comp_meas_usb:(NSString*)sms_comp_meas_usb
                   sms_agreement:(NSString*)sms_agreement
                        cig_cpap:(NSString*)cig_cpap
                    cig_auto_pap:(NSString*)cig_auto_pap
                    cig_bi_level:(NSString*)cig_bi_level
               cig_auto_bi_level:(NSString*)cig_auto_bi_level
                 cig_bi_level_st:(NSString*)cig_bi_level_st
                     cig_auto_sv:(NSString*)cig_auto_sv
                        sms_cpap:(NSString*)sms_cpap
                    sms_auto_pap:(NSString*)sms_auto_pap
                    sms_bi_level:(NSString*)sms_bi_level
               sms_auto_bi_level:(NSString*)sms_auto_bi_level
                 sms_bi_level_st:(NSString*)sms_bi_level_st
                     sms_auto_sv:(NSString*)sms_auto_sv;

// Edit Setup Ticket

-    (NSDictionary*)editTicketId:(NSString*)ticket_id
                            PtId:(NSString*)pt_id
                          status:(NSString*)status
                        pt_first:(NSString*)pt_first
                         pt_last:(NSString*)pt_last
                          gender:(NSString*)gender
                         spanish:(NSString*)spanish
                          pt_add:(NSString*)pt_add
                         pt_city:(NSString*)pt_city
                        pt_state:(NSString*)pt_state
                          pt_zip:(NSString*)pt_zip
                         pt_home:(NSString*)pt_home
                         pt_cell:(NSString*)pt_cell
                         pt_work:(NSString*)pt_work
                        pt_email:(NSString*)pt_email
                         machine:(NSString*)machine
                           cpap1:(NSString*)cpap1
                          level1:(NSString*)level1
                            cpap:(NSString*)cpap
                           level:(NSString*)level
                    manufacturer:(NSString*)manufacturer
                           model:(NSString*)model
                          serial:(NSString*)serial
                              cm:(NSString*)cm
                       ramp_time:(NSString*)ramp_time
                            rate:(NSString*)rate
                           modem:(NSString*)modem
                      modem_type:(NSString*)modem_type
                    modem_serial:(NSString*)modem_serial
                       hum_modem:(NSString*)hum_modem
                hum_manufacturer:(NSString*)hum_manufacturer
                      hum_serial:(NSString*)hum_serial
                            mask:(NSString*)mask
                       mask_type:(NSString*)mask_type
                       mask_name:(NSString*)mask_name
                         mask_id:(NSString*)mask_id
                            date:(NSString*)date
                      care_first:(NSString*)care_first
                       care_last:(NSString*)care_last
                    care_address:(NSString*)care_address
                       care_city:(NSString*)care_city
                      care_state:(NSString*)care_state
                        care_zip:(NSString*)care_zip
                      care_phone:(NSString*)care_phone
                      care_email:(NSString*)care_email
                    cpap_item_id:(NSString*)cpap_item_id
                   modem_item_id:(NSString*)modem_item_id
                     hum_item_id:(NSString*)hum_item_id
           place_of_service_text:(NSString*)place_of_service_text
                other_instructed:(NSString*)other_instructed
                 rt_trainer_name:(NSString*)rt_trainer_name
                reason_for_visit:(NSString*)reason_for_visit
                           goal1:(NSString*)goal1
                           goal2:(NSString*)goal2
                           goal1:(NSString*)goal3
                           goal1:(NSString*)goal4
                           goal1:(NSString*)goal5
                           goal1:(NSString*)goal6
                           goal1:(NSString*)goal7
                           goal1:(NSString*)goal8
                           goal1:(NSString*)goal9
                           goal1:(NSString*)goal10
                           goal1:(NSString*)goal11
                           goal1:(NSString*)goal12
                           goal1:(NSString*)goal13
                           goal1:(NSString*)goal14
                           goal1:(NSString*)goal15
                           goal1:(NSString*)goal16
                           goal1:(NSString*)goal17
                           goal1:(NSString*)goal18
                           goal1:(NSString*)goal19
                           goal1:(NSString*)goal20
                           goal1:(NSString*)goal21
                           goal1:(NSString*)goal22
                      rt_summary:(NSString*)rt_summary
               patient_caregiver:(NSString*)patient_caregiver
                    relationship:(NSString*)relationship
                 rt_trainer_date:(NSString*)rt_trainer_date
                    patient_date:(NSString*)patient_date
                       json_item:(NSString*)json_item
             json_discarded_item:(NSString*)json_discarded_item
                 json_adtnl_item:(NSString*)json_adtnl_item
                           notes:(NSString*)notes
                    machine_type:(NSString*)machine_type
                          pt_dob:(NSString*)pt_dob
                         cpap_cm:(NSString*)cpap_cm
                  cpap_ramp_time:(NSString*)cpap_ramp_time
             cpap_auto_ramp_time:(NSString*)cpap_auto_ramp_time
          cpap_auto_low_pressure:(NSString*)cpap_auto_low_pressure
         cpap_auto_high_pressure:(NSString*)cpap_auto_high_pressure
                 bi_st_ramp_time:(NSString*)bi_st_ramp_time
                      bi_st_ipap:(NSString*)bi_st_ipap
                      bi_st_epap:(NSString*)bi_st_epap
               bi_auto_ramp_time:(NSString*)bi_auto_ramp_time
                bi_auto_epap_min:(NSString*)bi_auto_epap_min
                bi_auto_epap_max:(NSString*)bi_auto_epap_max
    bi_auto_pressure_support_min:(NSString*)bi_auto_pressure_support_min
    bi_auto_pressure_support_max:(NSString*)bi_auto_pressure_support_max
            bi_auto_sv_ramp_time:(NSString*)bi_auto_sv_ramp_time
             bi_auto_sv_epap_min:(NSString*)bi_auto_sv_epap_min
             bi_auto_sv_ipap_max:(NSString*)bi_auto_sv_ipap_max
 bi_auto_sv_pressure_support_min:(NSString*)bi_auto_sv_pressure_support_min
 bi_auto_sv_pressure_support_max:(NSString*)bi_auto_sv_pressure_support_max
          bi_auto_sv_backup_rate:(NSString*)bi_auto_sv_backup_rate
 bi_auto_sv_max_pressure_support:(NSString*)bi_auto_sv_max_pressure_support
            bi_auto_st_ramp_time:(NSString*)bi_auto_st_ramp_time
                 bi_auto_st_ipap:(NSString*)bi_auto_st_ipap
                 bi_auto_st_epap:(NSString*)bi_auto_st_epap
          bi_auto_st_backup_rate:(NSString*)bi_auto_st_backup_rate
                     auth_person:(NSString*)auth_person
                auth_person_name:(NSString*)auth_person_name
                email_to_patient:(NSString*)email_to_patient
                  picked_machine:(NSString*)picked_machine
             picked_machine_name:(NSString*)picked_machine_name
             picked_manufacturer:(NSString*)picked_manufacturer
           picked_machine_serial:(NSString*)picked_machine_serial
               picked_hum_serial:(NSString*)picked_hum_serial
             picked_modem_serial:(NSString*)picked_modem_serial
                   isFinalSubmit:(NSString*)isFinalSubmit;

@end
